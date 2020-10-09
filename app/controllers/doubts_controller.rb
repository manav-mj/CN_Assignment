class DoubtsController < ApplicationController
  def new
    @doubt = Doubt.new
  end

  def create
    if current_user.doubts.create(doubt_params)
      redirect_to root_path
    end
  end

  private

  def doubt_params
    params.require(:doubt).permit(:title, :body)
  end
end
