class Rep < ApplicationRecord

  @states = ["al", "ak", "az", "ar", "ca", "co", "ct", "de", "fl", "ga",
             "hi", "id", "il", "in", "ia", "ks", "ky", "la", "me", "md",
             "ma", "mi", "mn", "ms", "mo", "mt", "ne", "nv", "nh", "nj",
             "nm", "ny", "nc", "nd", "oh", "ok", "or", "pa", "ri", "sc",
             "sd", "tn", "tx", "ut", "vt", "va", "wa", "wv", "wi", "wy"]

  belongs_to :office
  belongs_to :address, optional: true

  has_many :campaign_reps
  has_many :campaigns, through: :campaign_reps

  has_many :rep_phone_numbers
  has_many :rep_channels
  has_many :rep_urls

  validates :name, uniqueness: true

  def self.refresh_all
    @CivicAdapter = CivicAPIAdapter.new
    @states.each do |state|
      @rep_data = @CivicAdapter.get_all_reps_by_state(state)
      @CivicAdapter.parse_reps(@rep_data)
      true
    end
  end

  def self.refresh_state(state='ca')
    @CivicAdapter = CivicAPIAdapter.new
    @rep_data = @CivicAdapter.get_all_reps_by_state(state)
    # ap @rep_data
    # @rep_data['officials'].each_with_index do |rep, index|
    #   byebug if rep['name'].include?('onning')
    # end
    @CivicAdapter.parse_reps(@rep_data)
    true
  end

  def phone_numbers
    self.rep_phone_numbers.map { |num_obj| num_obj.number }
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
