class Office < ApplicationRecord

  belongs_to :district
  has_many :reps

end
