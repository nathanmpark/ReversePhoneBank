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

  # Update data on ALL REPS
  def self.refresh_all
    @CivicAdapter = CivicAPIAdapter.new
    @states.each do |state|
      @rep_data = @CivicAdapter.get_all_reps_by_state(state)
      return false unless @rep_data
      @CivicAdapter.parse_reps(@rep_data)
    end
    true
  end

  # Update data on ALL REPS by state
  def self.refresh_state(state='ca')
    @CivicAdapter = CivicAPIAdapter.new
    @rep_data = @CivicAdapter.get_all_reps_by_state(state)
    return false unless @rep_data
    @CivicAdapter.parse_reps(@rep_data)
    true
  end

  def self.find_reps(args = {})

    @level       = args.fetch(:level, 'national')
    @state       = args[:state]
    @county      = args[:county]
    @office_type = args[:office_type]
    @name        = args[:name]
    @party       = args[:party]

    #### HOUSE REPS ####

    if @level == 'national' && @office_type == 'house'

      # Find House Reps by NAME
      if @name
        return Rep.joins(:office).where('division_id LIKE ? AND lower(reps.name) LIKE ?', '%cd:%', "%#{@name.downcase}%")
      end

      # Find all House Reps by STATE
      if @state
        return Rep.joins(:office).where('division_id LIKE ? AND lower(division_id) LIKE ?', "%cd:%", "%#{@state.downcase}%")
      end

      # Find all House Reps by PARTY
      if  @party
        return Rep.joins(:office).where('division_id LIKE ? AND lower(reps.party) LIKE ?', "%cd:%", "%#{@party.downcase}%")
      end

      # Find all House Reps
      return Rep.joins(:office).where('division_id LIKE ?', '%cd:%')

    end

    # to add all house nationally
    # level will be national
    # no state will be passed
    # need to get reps from each state that have divsion_id %cd:%

  end


  # Helpers
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
