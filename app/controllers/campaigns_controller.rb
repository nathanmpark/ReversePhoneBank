class CampaignsController < ApplicationController

  def index
    @campaigns = Campaign.all
    render json: @campaigns
  end

  def create
    @campaign = Campaign.new(campaign_params)
  end

  def show
    @campaign = Campaign.find(params[:id])
    render json: @campaign
  end

  private

  def campaign_params
    params.require(:campaign).permit(:title, :desctiption, :start_date, :end_date)
  end

end
