require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user1) {User.first}
  let(:users) {User.all}

  describe 'GET index' do

    before(:each) do
      get :index
    end

    it 'assigns all users to @users' do
      expect(assigns(:users).length).to eq users.length
      expect(assigns(:users).first).to eq(user1)
    end

    it 'returns HTTP success' do
      expect(response).to have_http_status(:success)
    end

    context 'JSON body' do

      let(:body) {JSON.parse(response.body)}

      it 'contains all user instances' do
        expect(body.length).to eq 3
      end

      it 'User Attributes' do
        expect(body[0]['first_name']).to eq 'Tom'
        expect(body[0]['last_name']).to eq 'TomTom'
        expect(body[0]['email']).to eq 'tom@tom.com'
        expect(body[0]['phone']).to eq '(415) 555-0420'
      end

      it 'User Address' do
        expect(body[0]['address']['line_1']).to eq '1 W Portal Ave'
        expect(body[0]['address']['city']).to eq 'San Francisco'
        expect(body[0]['address']['state']).to eq 'CA'
        expect(body[0]['address']['primary_zip']).to eq 94127
      end

      it 'User Reps' do
        expect(body[0]['reps'][0]['name']).to eq 'Donald J. Trump'
        expect(body[0]['reps'][0]['party']).to eq 'Republican'
        expect(body[0]['reps'][0]['address_string']).to eq 'The White House 1600 Pennsylvania Avenue NW Washington, DC 20500'
        expect(body[0]['reps'][0]['public_office']).to eq 'President of the United States'
        expect(body[0]['reps'][0]['public_office_id']).to eq 'ocd-division/country:us'
        expect(body[0]['reps'][0]['phone_numbers'][0]).to eq '(202) 456-1111'
        expect(body[0]['reps'][0]['urls'][0]).to eq 'http://www.whitehouse.gov/'
        expect(body[0]['reps'][0]['channels']['Facebook']).to eq 'whitehouse'
      end

    end

  end

end
