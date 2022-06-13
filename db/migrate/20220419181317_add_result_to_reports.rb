class AddResultToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :result, :string
  end
end
