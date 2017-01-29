class UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find_by(id: params[:id])
    @user = User.find(1) unless params[:id]
    render json: @user, include: { offices: { include: { reps: {include: [:urls, :phone_numbers, :channels, ]} } }}
  end

  def create
    @user = User.new(
      first_name: user_params[:first_name],
      last_name: user_params[:last_name],
      phone: user_params[:phone],
      email: user_params[:email],
      user_type: 1)

    address = Address.new(
      line_1: user_params[:address][:line_1],
      line_2: user_params[:address][:line_2],
      city: user_params[:address][:city],
      state: user_params[:address][:state],
      primary_zip: user_params[:address][:primary_zip],
      extended_zip: user_params[:address][:extended_zip])

    if address.save
      @user.address = address
    else
      render json: address.errors
    end

    if @user.save
      p "$" * 80
      redirect_to user_path(@user)
    else
      render json: @user.errors
    end

  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :phone,
      :user_type,
      address: [
        :line_1,
        :line_2,
        :city,
        :state,
        :primary_zip,
        :extended_zip]
    )
  end
end
