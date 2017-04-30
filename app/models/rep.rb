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
    @office_type = args.fetch(:office_type, 'house')
    @state       = args[:state]
    @county      = args[:county]
    @name        = args[:name]
    @party       = args[:party]

    #### U.S. HOUSE REPS ####

    if @level.downcase == 'national' && @office_type.downcase == 'house'

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

      # Find all House Reps if no other options are passed
      return Rep.joins(:office).where('division_id LIKE ?', '%cd:%')

    end

    #### U.S. SENATE ####

    if @level.downcase == 'national' && @office_type.downcase == 'senate'

      # Find Senators by NAME
      if @name
        return Rep.joins(:office).where('offices.name = ? AND lower(reps.name) LIKE ?', 'United States Senate', "%#{@name.downcase}%")
      end

      # Find Senators by STATE
      if @state
        return Rep.joins(:office).where('offices.name = ? AND lower(division_id) LIKE ?', 'United States Senate', "%state:#{@state.downcase}%")
      end

      # Find Senators by PARTY
      if @party
        return Rep.joins(:office).where('offices.name = ? AND lower(reps.party) LIKE ?', 'United States Senate', "%#{@party.downcase}%")
      end

      # Find all U.S. Senators if no other options are passed
      return Rep.joins(:office).where(offices: {name: "United States Senate"})

    end

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
