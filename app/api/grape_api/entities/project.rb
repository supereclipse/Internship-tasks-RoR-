class GrapeApi
  module Entities
    class Project < Grape::Entity
      expose :name
      expose :state
      expose :created_at
      expose :vm

      def vm
        object.vms.map do |vm|
          [vm_id: vm.id, name: vm.name, configuration: "#{vm.cpu} CPU/#{vm.ram} Gb", hdds_count: vm.hdds.length]
        end
      end
    end
  end
end
