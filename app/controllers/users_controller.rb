class UsersController < ApplicationController

  def index
  end

  def show
    # Toggle for debugging
    # @user = User.find(1)
    @user = User.find(params[:id])
    render json: @user, include: { offices: { include: { reps: {include: [:urls, :phone_numbers, :channels, ]} } }}
  end

end
