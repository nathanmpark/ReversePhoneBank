class User < ApplicationRecord

  has_secure_password

  belongs_to :address

  has_many :campaign_users
  has_many :campaigns, through: :campaign_users

  has_many :district_users
  has_many :districts, through: :district_users

  has_many :offices, through: :districts, source: :offices

  has_many :reps, through: :offices, source: :reps

  has_many :owned_campaigns, foreign_key: 'owner_id', class_name: :Campaign

  after_create :update_voter_info

  validates :address, presence: true

  def address_string
    self.address.to_s
  end

  def update_voter_info
    Address.get_reps_for_address(self.address.to_s, self)
  end

end
