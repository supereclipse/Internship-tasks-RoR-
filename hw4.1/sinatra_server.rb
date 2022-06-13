require './hw1 copy/lib/vm'
require 'sinatra'
set :bind, '0.0.0.0'
set :port, 5678

# GET /vmcost?cpu=12&ram=16&hdd_type=sas&hdd_capacity=100&vol_arr[]=ssd&vol_arr[]=250&vol_arr[]=sata&vol_arr[]=100
get '/vmcost' do
  current_vm = VM.new(0, params['cpu'], params['ram'], params['hdd_type'], params['hdd_capacity'], params['vol_arr'])
  prices = Hash[CSV.read('./hw1 copy/data/csv_data/prices.csv')]

  # Проверяет передан ли массив с доп. дисками в query и считает их цену если да
  cost_of_extra_volume = params['vol_arr'].nil? ? 0 : current_vm.cost_of_extra_volume(prices)

  cost_without_extra_volume = current_vm.cost_without_extra_volume(prices)

  "Full cost: #{cost_without_extra_volume + cost_of_extra_volume} Cost of Extra Volume: #{cost_of_extra_volume}"
end
