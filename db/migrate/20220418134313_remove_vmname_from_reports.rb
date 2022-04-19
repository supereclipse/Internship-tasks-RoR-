class RemoveVmnameFromReports < ActiveRecord::Migration[6.1]
  def change
    remove_column :reports, :vmname, :string
  end
end
