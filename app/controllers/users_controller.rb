class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(1)
    # @user = User.find(params[:id])
    @user.update_voter_info
    render json: @user, include: { offices: { include: { reps: {include: [:urls, :phone_numbers, :channels, ]} } }}
  end

end
