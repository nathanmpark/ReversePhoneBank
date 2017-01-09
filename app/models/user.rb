class User < ApplicationRecord
  belongs_to :address
  has_many :campaign_users
  has_many :campaigns, through: :campaign_users

  def find_representatives
    @adapter = CivicAPIAdapter.new
    @adapter.get_reps(self.address)
  end

end
