require 'rails_helper'

RSpec.describe OrderService do
  describe '.check' do
    # External services URIs for mocking
    poss_ord_uri = URI('http://possible_orders.srv.w55.ru/')
    sin_serv_uri = URI('http://sinatra_server:5678/vmcost')

    # Adding params to sinatra URI
    valid_test_params = { os: 'linux', cpu: 1, ram: 16, hdd_type: 'sata', hdd_capacity: 20 }
    sin_serv_uri.query = URI.encode_www_form(valid_test_params.slice(:cpu, :ram, :hdd_type, :hdd_capacity))

    # Default responses from external services for testing
    let(:test_resp_config) do
      {
        "specs": [
          {
            "os": ['linux'],
            "cpu": [1, 2, 4, 8, 16],
            "ram": [1, 2, 4, 8, 16, 32],
            "hdd_type": %w[sata sas],
            "hdd_capacity": {
              "sata": {
                "from": 10,
                "to": 100
              },
              "sas": {
                "from": 20,
                "to": 150
              }
            }
          }
        ]
      }
    end
    let(:test_resp_cost) { 'Full cost: 999999 Cost of Extra Volume: 0' }

    # Set of different invalid input configs
    let(:invalid_test_params) do
      [
        { os: 'Wrong os', cpu: 1, ram: 16, hdd_type: 'sata', hdd_capacity: 20 },
        { os: 'linux', cpu: 99_999, ram: 16, hdd_type: 'sata', hdd_capacity: 20 },
        { os: 'Wrong os', cpu: 1, ram: 99_999, hdd_type: 'sata', hdd_capacity: 20 },
        { os: 'linux', cpu: 1, ram: 16, hdd_type: 'wrong type', hdd_capacity: 20 },
        { os: 'linux', cpu: 1, ram: 16, hdd_type: 'sata', hdd_capacity: 99_999 }
      ]
    end

    # Valid params and session for testing
    let(:session) { { login: 'test', balance: 1_000_000 } }
    let(:params) { valid_test_params }

    subject { OrderService.new(params, session).check }

    before do
      stub_request(:get, sin_serv_uri)
        .to_return(body: test_resp_cost)

      stub_request(:get, poss_ord_uri)
        .to_return(body: test_resp_config.to_json, status: resp_status)
    end

    context 'external services working right' do
      let(:resp_status) { 200 }

      context 'config is valid' do
        it 'returns hash with right attributes' do
          expect(subject).to eq({ balance: 1_000_000, balance_after_transaction: 1, return: true, total: 999_999 })
        end

        context 'enough money' do
          it 'returns hash with right attributes' do
            expect(subject).to eq({ balance: 1_000_000, balance_after_transaction: 1, return: true, total: 999_999 })
          end
        end

        context 'not enough money' do
          let(:session) { { login: 'test', balance: 1 } }
          subject { OrderService.new(params, session).check }

          it 'returns hash with right attributes' do
            expect(subject).to eq([{ result: false, error: 'Insufficient funds' }, :not_acceptable])
          end
        end
      end

      context 'config is invalid' do
        it 'returns hash with right attributes' do
          invalid_test_params.each do |params|
            expect(OrderService.new(params, session).check).to eq([{ error: 'Invalid configuration', result: false }, :not_acceptable])
          end
        end
      end
    end

    context 'sinatra_server returns 5.. code' do
      let(:resp_status) { 504 }
      it 'returns :service_unavailable' do
        expect(subject).to eq([{ result: false, error: 'Unable to connect to external services' }, :service_unavailable])
      end
    end

    context 'possible_orders returns 5.. code' do
      let(:resp_status) { 504 }
      it 'returns :service_unavailable' do
        expect(subject).to eq([{ result: false, error: 'Unable to connect to external services' }, :service_unavailable])
      end
    end
  end
end
