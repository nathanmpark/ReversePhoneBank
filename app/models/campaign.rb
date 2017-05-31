class Campaign < ApplicationRecord

  validates :description, presence: true
  validates :title, presence: true
  #### Leaving out date validation for now until a format is agreed upon with front end
  # validates :start_date, presence: true
  # validates :end_date, presence: true

  has_many :campaign_districts
  has_many :districts, through: :campaign_districts

  has_many :campaign_users
  has_many :users, through: :campaign_users

  has_many :campaign_reps
  has_many :reps, through: :campaign_reps

  has_many :campaign_tags
  has_many :tags, through: :campaign_tags

  belongs_to :owner, class_name: :User

end
