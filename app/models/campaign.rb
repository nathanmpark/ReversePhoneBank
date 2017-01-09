class Campaign < ApplicationRecord
  has_many :campaign_users
  has_many :users, through: :campaign_users
  has_many :campaign_representatives
  has_many :representatives, through: :campaign_representatives
  has_many :campaign_tags
  has_many :tags, through: :campaign_tags
  belongs_to :owner, class_name: :user
end
