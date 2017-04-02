class CampaignsController < ApplicationController

  def index
    @campaigns = Campaign.all
  end

  def create
    @campaign = Campaign.new(campaign_params)
  end

  private

  def campaign_params
    params.require(:campaign).permit(:title, :desctiption, :start_date, :end_date)
  end

end
