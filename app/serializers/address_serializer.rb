class AddressSerializer < ActiveModel::Serializer
  attributes :line_1, :line_2, :city, :state, :primary_zip, :extended_zip
end
