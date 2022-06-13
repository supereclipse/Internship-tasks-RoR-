# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

75.times do |time|
  Vm.create(
    name: "VM_#{time}",
    cpu: rand(8),
    ram: rand(16)
  )
end

50.times do |time|
  Project.create(
    name: "Project_#{time}",
    state: "state_#{rand(3)}"
  )
end

projects = Project.all
vms = Vm.all

projects.each do |project|
  rand(4).times { |_t| project.vms << vms.sample }
end

100.times do |_time|
  Hdd.create(
    hdd_type: %w[sas sata ssd].sample,
    size: [100, 150, 200, 250, 1000].sample,
    vm: vms.sample
  )
end
