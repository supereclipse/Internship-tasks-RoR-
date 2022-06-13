require 'net/http'
require 'json'

class OrderService
  attr_reader :params, :session

  def initialize(params, session)
    @params = params
    @session = session
  end

  URI_SINATRA = 'http://sinatra_server:5678/vmcost'.freeze
  URI_POSS_ORD = 'http://possible_orders.srv.w55.ru/'.freeze

  def check
    check_config(parse_configs_from_site)
    check_balance_cost_diff(get_cost_from_sinatra_server)

    # If all checks raised no exceptions than return:
    {
      return: true,
      total: cost,
      balance: session[:balance],
      balance_after_transaction: session[:balance] - cost
    }

    # If one of the checks fails
  rescue RuntimeError => e
    [{ result: false, error: e.message }, :not_acceptable]
  rescue SocketError
    [{ result: false, error: 'Unable to connect to external services' }, :service_unavailable]
  end

  private

  def check_balance_cost_diff(cost)
    raise 'Insufficient funds' if session[:balance] < cost
  end

  def get_cost_from_sinatra_server
    uri = URI(URI_SINATRA)
    d_params = { cpu: params[:cpu], ram: params[:ram], hdd_type: params[:hdd_type],
                 hdd_capacity: params[:hdd_capacity] }

    uri.query = URI.encode_www_form(d_params)
    res = Net::HTTP.get_response(uri)

    raise SocketError if (500..526).include?(res.code.to_i)

    res.body.match(/^[^\d]*(\d+)/)[1].to_i
  end

  def parse_configs_from_site
    uri = URI(URI_POSS_ORD)
    res = Net::HTTP.get_response(uri)

    raise SocketError if (500..526).include?(res.code.to_i)

    JSON.parse(res.body)
  end

  def check_config(configs)
    # Iterates through configurations from json
    configs['specs'].each do |config|
      # Moves to the next config if one of the following conditions doesnt match
      next unless config['os'].include?(params[:os])
      next unless config['cpu'].include?(params[:cpu].to_i)
      next unless config['ram'].include?(params[:ram].to_i)
      next unless config['hdd_type'].include?(params[:hdd_type])

      from = config['hdd_capacity'][params[:hdd_type]]['from']
      to = config['hdd_capacity'][params[:hdd_type]]['to']
      next unless (from...to).include?(params[:hdd_capacity].to_i)

      return true
    end
    raise 'Invalid configuration'
  end
end
