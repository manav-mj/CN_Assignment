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
    unless @doubt
      redirect_to root_path
    end
  end

  def accept
    @doubt = Doubt.find(params[:doubt_id])
    unless @doubt.resolved
      @doubt.accepted = true
      @doubt.accepted_on = Time.now
      @doubt.save

      Event.create(user_id: current_user.id, doubt_id: @doubt.id, event_type: Event.types[:accepted])

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

      Event.create(user_id: current_user.id, doubt_id: @doubt.id, event_type: Event.types[:resolved])

      redirect_to root_path
    end
  end

  def escalate
    @doubt = Doubt.find(params[:doubt_id])
    unless @doubt.resolved
      @doubt.escalated = true
      @doubt.accepted = false
      @doubt.save

      Event.create(user_id: current_user.id, doubt_id: @doubt.id, event_type: Event.types[:escalated])

      redirect_to root_path
    end
  end

  private

  def doubt_params
    params.require(:doubt).permit(:title, :body)
  end
end
