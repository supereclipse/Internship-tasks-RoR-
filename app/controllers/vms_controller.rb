class VmsController < ApplicationController
  def index
    @vms = []
    Vm.eager_load(:projects, :hdds).each do |vm|
      @vms << {
        name: vm.name,
        projects: vm.projects.map { |project| { name: project.name, state: project.state } },
        hdds: vm.hdds.map { |hdd| { hdd_type: hdd.hdd_type, hdd_capacity: hdd.size } },
        state: vm.state
      }
    end
    render json: { vms: @vms }
  end
end
