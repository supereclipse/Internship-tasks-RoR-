class RemoveReptypeFromReports < ActiveRecord::Migration[6.1]
  def change
    remove_column :reports, :reptype, :string
  end
end
