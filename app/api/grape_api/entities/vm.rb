class GrapeApi
  module Entities
    class Vm < Grape::Entity
      expose :id, documentation: { type: 'Integer', desc: 'Идентификатор ВМ', required: true }
      expose :configuration, documentation: { type: 'String', desc: 'Конфигурация ВМ', required: true }
      expose :name, if: lambda { |_object, options|
                          options[:detail] == true
                        }, documentation: { type: 'Integer', desc: 'name ВМ', required: false }

      def configuration
        "#{object.cpu} CPU/#{object.ram} Gb"
      end
    end
  end
end
