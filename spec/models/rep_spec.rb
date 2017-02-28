require 'rails_helper'

RSpec.describe Rep, type: :model do
  describe 'Uniqueness' do

    let(:rep) {Rep.new(
                        name: 'Tom Tingleton',
                        party: 'Republican',
                        email: 'tingleton@broken-gov.gov',
                        img_url: 'http://www.thepublicprofessor.com/wp-content/uploads/2015/08/Donald-Trump-image-from-Salon-dot-com.jpg',
                        address: Address.first,
                        office: Office.first)}
    let(:rep_dup) {Rep.new(
                        name: 'Tom Tingleton',
                        party: 'Republican',
                        email: 'tom@broken-gov.gov',
                        img_url: 'http://www.thepublicprofessor.com/wp-content/uploads/2015/08/Donald-Trump-image-from-Salon-dot-com.jpg',
                        address: Address.first,
                        office: Office.first)}

    it 'Saves when no other rep is present' do
      expect(rep.save).to eq true
    end

    it 'Cannot have duplicate entires' do
      rep.save
      rep_dup.save
      expect(rep_dup.errors.count).to be >= 1
    end

  end
end
