class Rep < ApplicationRecord
  belongs_to :office
  belongs_to :address, optional: true
  has_many :campaign_reps
  has_many :campaigns, through: :campaign_reps
  has_many :rep_phone_numbers
  has_many :rep_channels
  has_many :rep_urls

  def phone_numbers
    self.rep_phone_numbers.map {|num_obj| num_obj.number}
  end

  def channels
    results = {}
    self.rep_channels.map { |channel_obj| results[channel_obj.channel_type] = channel_obj.channel_id }
    results
  end

  def urls
    self.rep_urls.map { |url_obj| url_obj.url }
  end

  def address_string
    self.address.one_line if self.address
  end

  def public_office
    self.office.name
  end

  def public_office_id
    self.office.division_id
  end

end
