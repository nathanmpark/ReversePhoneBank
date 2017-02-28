require 'rails_helper'

RSpec.describe CivicAPIAdapter, type: :model do

  around(:each) do |example|
    VCR.use_cassette('civic_payload',
                     record: :once,
                     re_record_interval: 7.days,
                     &example)
  end


  let(:client) {CivicAPIAdapter.new}
  let(:user_address) {'633 Folsom Street San Francisco, CA'}
  let(:payload) {client.get_reps(user_address)}

  describe '#get_reps' do

    it 'returns a valid payload' do
      expect(payload['kind']).to eq "civicinfo#representativeInfoResponse"
    end

    it 'returns a valid address' do
      expect(payload['normalizedInput']['line1']).to eq '633 Folsom Street'
      expect(payload['normalizedInput']['city']).to eq 'San Francisco'
      expect(payload['normalizedInput']['state']).to eq 'CA'
      expect(payload['normalizedInput']['zip']).to eq '94107'
    end

  end
end
