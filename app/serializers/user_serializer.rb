class UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :email, :phone, :created_at
  belongs_to :address
  has_many :reps
end
