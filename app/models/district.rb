class District < ApplicationRecord
  has_many :offices
  has_many :district_users
  has_many :districts, through: :district_users
  has_many :reps, through: :offices, source: :rep
end
