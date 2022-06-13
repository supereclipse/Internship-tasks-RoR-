class GrapeApi
  class ProjectsApi < Grape::API
    format :json

    namespace :projects do
      desc 'Список Project',
           success: GrapeApi::Entities::Project,
           is_array: true

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
        present projects, with: GrapeApi::Entities::Project
      end

      desc 'Create project',
           success: [{ code: 200, message: 'Project created' }],
           failure: [{ code: 404, message: 'Project не найден' }]

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
        desc 'Просмотр Project',
             success: GrapeApi::Entities::Project,
             failure: [{ code: 404, message: 'Project не найден' }]

        get do
          project = Project.find_by_id(params[:id])
          error!({ message: 'Project не найден' }, 404) unless project
          present project
        end

        desc 'Delete project',
             success: [{ code: 204, message: 'Project deleted' }],
             failure: [{ code: 404, message: 'Project не найден' }]

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
