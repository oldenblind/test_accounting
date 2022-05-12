require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe '#index' do
    let(:user) { create(:user) }
    let(:headers) { { 'X-API-TOKEN' => user.api_token } }

    subject { get :index }

    before do
      request.headers.merge! headers

      subject
    end

    it 'should return success' do
      expect(response).to have_http_status(:success)
    end

    it 'should return current user details' do
      expect(JSON.parse(response.body)).to be_truthy
    end
  end

  describe '#create' do
    let(:user) { build(:user) }
    let(:password) { '123456789' }

    let(:params) { { user: { username: user.username, password: } } }

    subject { post :create, params: }

    before { user }

    it 'should return success' do
      subject

      expect(response).to have_http_status(:success)
    end

    it 'should create new user' do
      expect { subject }.to change { User.count }.by(1)
    end

    context 'with non unique username' do
      let(:o_user) { create(:user, username: user.username) }

      before { o_user }

      it 'should return unproccessable entity' do
        subject

        expect(response).to have_http_status(422)
      end

      it 'should not create user' do
        expect { subject }.not_to change { User.count }
      end
    end
  end
end
