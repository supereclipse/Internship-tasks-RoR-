class GrapeApi
  module Entities
    class Vm < Grape::Entity
      expose :id
      expose :configuration
      expose :name, if: ->(_object, options) { options[:detail] == true }

      def configuration
        "#{object.cpu} CPU/#{object.ram} Gb"
      end
    end
  end
end
