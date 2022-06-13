require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  describe 'GET #index' do
    before(:all) do
      create_list(:group, 5)
    end

    after(:all) do
      Group.destroy_all
    end

    it 'returns a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'returns an array body' do
      get :index
      expect(JSON.parse(response.body)).to be_instance_of(Array)
    end

    it 'returns group attributes' do
      get :index
      groups = JSON.parse(response.body)
      expect(groups[0].keys).to contain_exactly('id', 'name')
    end

    it 'filter by name' do
      get :index, params: { name: 'group_1' }
      expect(JSON.parse(response.body).count).to eq(1)
    end

    it 'answer type is Json' do
      get :index
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe 'GET #show' do
    before(:each) do
      create_list(:group, 1, id: 1)
    end

    after(:each) do
      Group.destroy_all
    end

    it 'returns 404 if group not found' do
      get :show, params: { id: 10_000 }
      expect(response.status).to eq(404)
    end

    it 'returns right attributes' do
      get :show, params: { id: 1 }
      group = JSON.parse(response.body)
      expect(group.keys).to contain_exactly('id', 'name')
    end
  end

  describe 'POST #create' do
    before(:each) do
      Group.destroy_all
    end

    after(:each) do
      Group.destroy_all
    end

    it 'creates group' do
      post :create, params: { group: { name: 'foo' } }
      expect(Group.first).to have_attributes(name: 'foo')
    end

    it 'returns group attributes' do
      post :create, params: { group: { name: 'foo' } }
      expect(JSON.parse(response.body).keys).to contain_exactly('id', 'name')
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      create_list(:group, 1, id: 1)
    end

    it 'deletes a group' do
      delete :destroy, params: { id: 1 }
      expect(Group.first).to be_nil
    end

    it 'returns empty answer with 204 code' do
      delete :destroy, params: { id: 1 }
      expect(response.body).to be_empty
      expect(response.status).to eq(204)
    end
  end
end
