class User < ApplicationRecord

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

  def assign_districts

    return false unless @rep_data

    # Go through divisions, find or create districts
    @rep_data['divisions'].map do |division_id, division_data|

      district = self.districts.find_or_create_by(division_id: division_id)
      district.update(name: division_data['name'])

      unless district.save
        p "!" * 100
        ap district.errors
      end

      # Go through division refs, find or create offices
      division_data['officeIndices'].map do |office_id|

        office = district.offices.find_or_create_by(name: @rep_data['offices'][office_id]['name'])
        office.update(division_id: @rep_data['offices'][office_id]['divisionId'])

        unless office.save
          p "!" * 100
          ap office.errors
        end

        # Go through office refs, find or create reps
        @rep_data['offices'][office_id]['officialIndices'].map do |official_id|

          rep = office.reps.find_or_create_by(name: @rep_data['officials'][official_id]['name'])
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
            rep.urls.find_or_create_by(url: url)
          end if @rep_data['officials'][official_id]['urls']

          @rep_data['officials'][official_id]['phones'].map do |phone|
            rep.phone_numbers.find_or_create_by(number: phone)
          end if @rep_data['officials'][official_id]['phones']

          @rep_data['officials'][official_id]['channels'].map do |channel|
            rep.channels.find_or_create_by(
              channel_type: channel['type'],
              channel_id: channel['id'])
          end if @rep_data['officials'][official_id]['channels']

        end
      end
    end
    true
  end

  def update_voter_info
    @CivicAdapter = CivicAPIAdapter.new
    @rep_data = @CivicAdapter.get_reps(address_string)
    assign_districts
  end

end
