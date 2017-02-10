require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user1) {User.first}
  let(:users) {User.all}

  describe 'GET index' do

    it 'assigns all users to @users' do
      get :index
      expect(assigns(:users).length).to eq users.length
      expect(assigns(:users).first).to eq(user1)
    end

    it 'returns HTTP success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    context 'JSON body' do

      it 'User attributes' do
        get :index
        body = JSON.parse(response.body)
        expect(body[0]['first_name']).to eq 'Tom'
        expect(body[0]['last_name']).to eq 'TomTom'
        expect(body[0]['email']).to eq 'tom@tom.com'
        expect(body[0]['phone']).to eq '(415) 555-0420'
      end

      it 'User address' do
        get :index
        body = JSON.parse(response.body)
        expect(body[0]['address']['line_1']).to eq '1 W Portal Ave'
        expect(body[0]['address']['city']).to eq 'San Francisco'
        expect(body[0]['address']['state']).to eq 'CA'
        expect(body[0]['address']['primary_zip']).to eq 94127
      end


      it ' User reps' do
        get :index
        body = JSON.parse(response.body)
        expect(body[0]['address']['line_1']).to eq '1 W Portal Ave'
        expect(body[0]['address']['city']).to eq 'San Francisco'
        expect(body[0]['address']['state']).to eq 'CA'
        expect(body[0]['address']['primary_zip']).to eq 94127
      end

    end

  end

end
