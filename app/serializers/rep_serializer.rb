class RepSerializer < ActiveModel::Serializer
  attributes :name, :party, :email, :img_url, :address_string, :public_office, :public_office_id, :phone_numbers, :urls, :channels

  # belongs_to :address
end
