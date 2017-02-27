class AddressesController < ApplicationController

  skip_before_action :authenticate_request

  def new

    return render json: {error: 'Missing or Invalid Address'} unless params['address'].present?
    @user = User.find_by(email: 'sample@sample.com')
    @address = assign_address(address_params)


    if @address.save
      @user.address = @address
      @reps = Address.get_reps_for_address(@address, @user)
      render json: @reps
    else
      render json: @address.errors
    end

  end

  private

  def address_params
    params.fetch(:address, {}).permit(
      :line_1,
      :line_2,
      :city,
      :state,
      :primary_zip,
      :extended_zip)
  end

  def assign_address(params)

    Address.new(
      line_1: params[:line_1],
      line_2: params[:line_2],
      city: params[:city],
      state: params[:state],
      primary_zip: params[:primary_zip],
      extended_zip: params[:extended_zip])

  end



end
