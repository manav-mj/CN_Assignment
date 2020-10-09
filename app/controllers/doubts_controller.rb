class DoubtsController < ApplicationController
  def new
    @doubt = Doubt.new
  end

  def create
    if current_user.doubts.create(doubt_params)
      redirect_to root_path
    end
  end

  def show
    @doubt = Doubt.find(params[:id])
  end

  def accept
    @doubt = Doubt.find(params[:doubt_id])
    unless @doubt.resolved
      @doubt.accepted = true
      @doubt.accepted_on = Time.now
      @doubt.save

      # Event.create(user_id: current_user.id, doubt_id: @doubt.id, accept: true, accept_time: Time.now.to_i)

      render 'show'
    end
  end

  def resolve
    @doubt = Doubt.find(params[:doubt_id])
    unless @doubt.resolved
      @doubt.solution = params.require(:doubt).permit(:solution)[:solution]
      @doubt.resolved = true
      @doubt.resolved_on = Time.now
      @doubt.resolution_time = @doubt.resolved_on - @doubt.created_at
      @doubt.activity_time = @doubt.resolved_on - @doubt.accepted_on
      @doubt.save

      # @event = Event.where(["user_id = :user and doubt_id = :doubt", {user: current_user.id, doubt: @doubt.id}]).order(created_at: :desc)
      # @event[0].resolve = true
      # @event[0].resolve_time = @doubt.resolved_on
      # @event[0].save

      redirect_to root_path
    end
  end

  def escalate
    @doubt = Doubt.find(params[:doubt_id])
    unless @doubt.resolved
      @doubt.escalated = true
      @doubt.accepted = false
      @doubt.save

      # @event = Event.where(["user_id = :user and doubt_id = :doubt", {user: current_user.id, doubt: @doubt.id}]).order(created_at: :desc)
      # puts @event.inspect
      # @event[0].escalate = true
      # @event[0].escalate_time = Time.now.to_i
      # @event[0].save

      redirect_to root_path
    end
  end

  private

  def doubt_params
    params.require(:doubt).permit(:title, :body)
  end
end
