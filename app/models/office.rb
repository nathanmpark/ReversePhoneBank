class Office < ApplicationRecord
  belongs_to :district
  has_many :reps

  # Defaults
  def self.find_reps(location='ca', office_type='sldu')
    # Method accepts 3 inputs
    # location:
    # office_type
    Rep.joins(:office).where('division_id LIKE ?', "ocd-division/country:us/state:#{location}/#{office_type}%")
  end


end
