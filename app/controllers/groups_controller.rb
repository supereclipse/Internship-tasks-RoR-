class GroupsController < ApplicationController
  def index
    groups = Group.all
    groups = groups.where(name: params[:name]) if params[:name]
    render json: groups.select(:id, :name)
  end

  def show
    group = Group.find_by_id(params[:id])
    return head :not_found unless group
    render json: { id: group.id, name: group.name }
  end

  def create
    group = Group.create(group_params)
    render json: { id: group.id, name: group.name }
  end

  def destroy
    Group.find_by_id(params[:id]).destroy
    return head :no_content
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
