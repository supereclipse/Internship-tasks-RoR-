class AddReptypeToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :reptype, :integer
  end
end
