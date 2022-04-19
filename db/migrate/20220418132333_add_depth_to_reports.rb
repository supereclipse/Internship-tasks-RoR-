class AddDepthToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :depth, :int
  end
end
