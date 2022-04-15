class AddStateToVms < ActiveRecord::Migration[6.1]
  def change
    add_column :vms, :state, :string
  end
end
