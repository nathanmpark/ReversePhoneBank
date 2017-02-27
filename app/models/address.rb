class Address < ApplicationRecord

  has_many :users
  has_many :reps
  has_many :district_addresses
  has_many :districts, through: :district_addresses

  validates :line_1, presence: true
  validates :primary_zip, presence: true

  def to_s
    self.one_line
  end

  def one_line
    "#{self.line_1}#{' ' + self.line_2 if self.line_2} #{self.city}, #{self.state} #{self.primary_zip}#{'-' + self.extended_zip if self.extended_zip}"
  end

  def self.get_reps_for_address(address_string, user)
    @CivicAdapter = CivicAPIAdapter.new
    @rep_data = @CivicAdapter.get_reps(address_string)

    Address.assign_districts(user)
    user.reps
  end

  def self.assign_districts(user)

    return false unless @rep_data
    return false unless @rep_data['divisions']

    user.districts = []

    # Go through divisions, find or create districts
    @rep_data['divisions'].map do |division_id, division_data|

      district = District.find_or_initialize_by(division_id: division_id)
      user.districts << district
      district.update(name: division_data['name'])

      unless district.save
        p "!" * 100
        ap district.errors
      end

      # Go through division refs, find or create offices if offices
      break unless division_data['officeIndices']
      division_data['officeIndices'].map do |office_id|

        office = district.offices.find_or_create_by(name: @rep_data['offices'][office_id]['name'])
        next unless office.reps.empty?
        office.update(division_id: @rep_data['offices'][office_id]['divisionId'])

        unless office.save
          p "!" * 100
          ap office.errors
        end

        # Go through office refs, find or create reps if reps
        break unless @rep_data['offices'][office_id]['officialIndices']
        @rep_data['offices'][office_id]['officialIndices'].map do |official_id|

          rep = Rep.find_or_create_by(name: @rep_data['officials'][official_id]['name'])
          office.reps << rep
          rep.update(party: @rep_data['officials'][official_id]['party'])
          rep.update(img_url: @rep_data['officials'][official_id]['photoUrl'])
          rep.update(email: @rep_data['officials'][official_id]['emails'][0]) if @rep_data['officials'][official_id]['emails']

          rep.address = Address.find_or_create_by(
            line_1: @rep_data['officials'][official_id]['address'][0]['line1'],
            line_2: @rep_data['officials'][official_id]['address'][0]['line2'],
            city: @rep_data['officials'][official_id]['address'][0]['city'],
            state: @rep_data['officials'][official_id]['address'][0]['state'],
            primary_zip: @rep_data['officials'][official_id]['address'][0]['zip'],
            ) if @rep_data['officials'][official_id]['address']

          unless rep.save
            p "!" * 100
            ap rep.errors
          end

          @rep_data['officials'][official_id]['urls'].map do |url|
            rep.rep_urls.find_or_create_by(url: url)
          end if @rep_data['officials'][official_id]['urls']

          @rep_data['officials'][official_id]['phones'].map do |phone|
            rep.rep_phone_numbers.find_or_create_by(number: phone)
          end if @rep_data['officials'][official_id]['phones']

          @rep_data['officials'][official_id]['channels'].map do |channel|
            rep.rep_channels.find_or_create_by(
              channel_type: channel['type'],
              channel_id: channel['id'])
          end if @rep_data['officials'][official_id]['channels']

        end
      end
    end
    true
  end


end
