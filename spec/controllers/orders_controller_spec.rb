require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'GET #check' do
    context 'when user is authorized and params suite config' do
      let(:session) { { login: 'test', balance: 1_000_000 } }
      it 'returns a json with right attributes and 200 code' do
        allow_any_instance_of(OrderService).to receive(:check).and_return({
                                                                            return: true,
                                                                            total: 999,
                                                                            balance: 999,
                                                                            balance_after_transaction: 999
                                                                          })
        get :check, session: session

        expect(JSON.parse(response.body).keys).to contain_exactly('return', 'total', 'balance',
                                                                  'balance_after_transaction')
        expect(response.status).to eq(200)
      end
    end

    context 'when current session doesnt have login' do
      let(:session) { { login: nil, balance: 1_000_000 } }
      it 'returns a 401 status code if unauthorized' do
        get :check, session: session
        expect(response.status).to eq(401)
      end
    end

    context 'when current session doesnt have balance' do
      let(:session) { { login: 'test', balance: nil } }
      it 'returns a 401 status code if unauthorized' do
        get :check, session: session
        expect(response.status).to eq(401)
      end
    end
  end
end
