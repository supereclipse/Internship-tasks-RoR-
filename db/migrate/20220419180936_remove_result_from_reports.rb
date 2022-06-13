class RemoveResultFromReports < ActiveRecord::Migration[6.1]
  def change
    remove_column :reports, :result, :integer
  end
end
