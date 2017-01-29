class Rep < ApplicationRecord
  belongs_to :office
  belongs_to :address, optional: true
  has_many :campaign_reps
  has_many :campaigns, through: :campaign_reps
  has_many :rep_phone_numbers
  has_many :rep_channels
  has_many :rep_urls

  def phone_numbers
    self.rep_phone_numbers
  end

  def channels
    self.rep_channels
  end

  def urls
    self.rep_urls
  end

end
