class GrapeApi
  module Entities
    class Project < Grape::Entity
      expose :name, documentation: { type: 'String', desc: 'Name of a project', required: true }
      expose :state, documentation: { type: 'String', desc: 'State of a project', required: true }
      expose :created_at, documentation: { type: 'String', desc: 'Created at', required: true }
      expose :vm, documentation: { type: 'Hash', desc: 'Конфигурация ВМ', required: true }

      def vm
        object.vms.map do |vm|
          [vm_id: vm.id, name: vm.name, configuration: "#{vm.cpu} CPU/#{vm.ram} Gb", hdds_count: vm.hdds.length]
        end
      end
    end
  end
end
