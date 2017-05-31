class Address < ApplicationRecord

  has_many :users
  has_many :reps
  has_many :district_addresses
  has_many :districts, through: :district_addresses

  validates :line_1, presence: true
  validates :primary_zip, presence: true

  def to_s
    self.one_line
  end

  def one_line
    "#{self.line_1}#{' ' + self.line_2 if self.line_2} #{self.city}, #{self.state} #{self.primary_zip}#{'-' + self.extended_zip if self.extended_zip}"
  end

  def self.get_reps_for_address(address_string, user)
    @CivicAdapter = CivicAPIAdapter.new
    @rep_data = @CivicAdapter.get_reps(address_string)
    @CivicAdapter.parse_reps(@rep_data)
    Address.assign_districts(user)
    user.reps
  end

  def self.assign_districts(user)

    return false unless @rep_data
    return false unless @rep_data['divisions']

    user.districts = []

    # Go through divisions, find or create districts
    @rep_data['divisions'].map do |division_id, division_data|

      district = District.find_or_initialize_by(division_id: division_id)
      user.districts << district
      district.update(name: division_data['name'])

      unless district.save
        p "!" * 100
        ap district.errors
      end
    end

  end

end
