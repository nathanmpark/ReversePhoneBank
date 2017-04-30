class CampaignsController < ApplicationController

  def index
    @campaigns = Campaign.all
    render json: @campaigns
  end

  def create
    @campaign = current_user.owned_campaigns.new(campaign_params)
    if @campaign.save
      render json: @campaign
    else
      render json: @campaign.errors
    end
  end

  def update
    @campaign = Campaign.find(params[:id])
    @campaign.update(campaign_params)
    if @campaign.save
      render json: @campaign
    else
      render json: @campaign.errors
    end
  end

  def add_reps
    @campaign = Campaign.find(params[:id])
    @rep = Rep.find_by_uuid(params[:rep_uuid])
    render json: {error: 'Rep not found'} unless @rep
    @campaign.reps << @rep
    render json: @campaign
  end

  def show
    @campaign = Campaign.find(params[:id])
    render json: @campaign
  end

  private

  def campaign_params
    params.require(:campaign).permit(:title, :description, :start_date, :end_date)
  end

end
