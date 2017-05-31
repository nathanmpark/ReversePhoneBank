class RepsController < ApplicationController

  # Leaving AUTH off for now, may change in the future
  skip_before_action :authenticate_request

  def find_reps
    @reps = Rep.find_reps(rep_params)
    render json: @reps
  end

  private

  def rep_params
    params.fetch(:rep, {}).permit(
      :name,
      :office,
      :level,
      :office_type,
      :state,
      :county,
      :party)
  end
end
