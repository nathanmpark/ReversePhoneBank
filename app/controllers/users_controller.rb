class UsersController < ApplicationController
  def index
    @user = User.find(1)
    # @user = User.find(params[:id])
    @reps = @user.find_representatives
    render json: @reps
  end
end
