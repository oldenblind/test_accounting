require 'rails_helper'

RSpec.describe Api::V1::Users::BalanceTransactionsController, type: :controller do
  let(:user) { create(:user) }
  let(:headers) { { 'X-API-TOKEN' => user.api_token } }

  describe '#index' do
    let(:balance_transactions) { 10.times { create(:balance_transaction, user:) } }

    let(:base_params) { {} }

    subject { get :index, params: }

    before do
      request.headers.merge! headers
      balance_transactions

      subject
    end

    context 'when period specified' do
      let(:balance_transactions) do
        10.times do
          create(:balance_transaction, user:, created_at: 6.weeks.ago)
        end
      end

      let(:period_start) { (Time.now.utc - 2.months).to_i }
      let(:period_end) { (Time.now.utc - 1.month).to_i }

      let(:period) { period_start..period_end }

      let(:params) { base_params.merge({ start: period_start, end: period_end }) }

      it 'should return success' do
        expect(response).to have_http_status(:success)
      end

      it 'should return user balance transactions between two periods' do
        expect(JSON.parse(response.body)['data'].all? do |transaction|
                 transaction.dig('attributes', 'created_at_timestamp').in? period
               end).to be_truthy
      end
    end

    context 'when period is absence' do
      let(:params) { base_params }

      it 'should return success' do
        expect(response).to have_http_status(:success)
      end

      it 'should return user balance transactions' do
        expect(JSON.parse(response.body)).to be_truthy
      end
    end
  end

  describe '#create' do
    let(:balance_transaction) { build(:balance_transaction) }
    let(:user) { balance_transaction.user }
    let(:balance_transaction_params) do
      {
        delta: balance_transaction.delta,
        target: balance_transaction.target
      }
    end

    subject { post :create, params: { balance_transaction: balance_transaction_params } }

    before { request.headers.merge! headers }

    it 'should return success' do
      subject

      expect(response).to have_http_status(:success)
    end

    it 'should create user balance transaction' do
      expect { subject }.to change { BalanceTransaction.count }.by(1)
    end

    it 'should return new user balance transaction' do
      subject

      expect(JSON.parse(response.body)).to be_truthy
    end

    it 'should update user balance' do
      expect { subject }.to change { user.reload.balance }.by(balance_transaction.delta)
    end
  end
end
