require './lib/vm'
require './lib/vm_cost'
require 'sinatra'
set :bind, '0.0.0.0'
set :port, 5678

# GET /vmcost?cpu=12&ram=16&hdd_type=sas&hdd_capacity=100&vol_arr[]=ssd&vol_arr[]=250&vol_arr[]=sata&vol_arr[]=100
get '/vmcost' do
  current_vm = VM.new(0, params['cpu'], params['ram'], params['hdd_type'], params['hdd_capacity'])
  price = PricesDataHandler.create_price_list
  volume_list = params['vol_arr']

  # Проверяет передан ли массив с доп. дисками в query и считает их цену если да
  cost_of_volume = if params['vol_arr'].nil?
                     0
                   else
                     VMCost.cost_of_extra_volume(nil, price, volume_list)
                   end

  vm_cost = VMCost.cost_without_extra_volume(current_vm, price)

  "Full cost: #{vm_cost + cost_of_volume} Cost of Extra Volume: #{cost_of_volume}"
end
