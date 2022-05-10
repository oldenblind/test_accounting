require 'rails_helper'

RSpec.describe Api::V1::Users::SessionsController, type: :controller do

  let(:password) { '123456789' }
  let(:user) { create(:user, password: password) }

  describe '#create' do

    subject { post :create, params: auth_data }

    context 'with correct auth data' do
      let(:auth_data) {{ username: user.username, password: password }}

      before { subject }

      it 'should return success' do
        expect(response).to have_http_status(:success)
      end

      it 'should return user details' do
        expect(JSON.parse(response.body)).to be_truthy
      end

    end

    context 'with incorrect auth data' do

      let(:auth_data) {{ username: user.username, password: '123456' }}      

      it 'should return unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

  end

end