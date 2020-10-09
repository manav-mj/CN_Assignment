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
  end

  def accept
    @doubt = Doubt.find(params[:doubt_id])
    unless @doubt.resolved
      @doubt.accepted = true
      @doubt.accepted_on = Time.now.to_i
      @doubt.save

      render 'show'
    end
  end

  def resolve
    @doubt = Doubt.find(params[:doubt_id])
    unless @doubt.resolved
      @doubt.solution = params.require(:doubt).permit(:solution)
      @doubt.resolved = true
      @doubt.resolved_by_id = current_user.id
      @doubt.resolved_on = Time.now.to_i
      @doubt.save

      redirect_to root_path
    end
  end

  def escalate
    @doubt = Doubt.find(params[:doubt_id])
    unless @doubt.resolved
      @doubt.escalated = true
      @doubt.accepted = false
      @doubt.save

      redirect_to root_path
    end
  end

  private

  def doubt_params
    params.require(:doubt).permit(:title, :body)
  end
end
