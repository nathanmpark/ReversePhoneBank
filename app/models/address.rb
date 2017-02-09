class Address < ApplicationRecord
  has_many :users
  has_many :reps
  has_many :district_addresses
  has_many :districts, through: :district_addresses

  def to_s
    self.one_line
  end

  def one_line
    "#{self.line_1}#{' ' + self.line_2 if self.line_2} #{self.city}, #{self.state} #{self.primary_zip}#{'-' + self.extended_zip if self.extended_zip}"
  end

end
