class GrapeApi
  class ProjectsApi < Grape::API
    format :json

    namespace :projects do
      params do
        optional :state, type: Array[String]
      end

      get do
        projects = Project.all
        if params[:state].present?
          projects = projects.where('state IN (:state)', state: params[:state].map do |x|
                                                                  "state_#{x}"
                                                                end)
        end
        present projects
      end

      params do
        requires :name, type: String
        requires :state, type: Integer
      end

      # curl -X POST --data "name=test1&state=3" http://localhost:3000/api/projects
      post do
        Project.create(
          name: params[:name],
          state: params[:state]
        )
      end

      route_param :id, type: Integer do
        get do
          project = Project.find_by_id(params[:id])
          error!({ message: 'Project не найден' }, 404) unless project
          present project
        end

        delete do
          project = Project.find_by_id(params[:id])
          error!({ message: 'Project не найден' }, 404) unless project
          project.destroy
          status 204
        end
      end
    end
  end
end
