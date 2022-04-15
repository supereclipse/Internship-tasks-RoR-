class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.string :vmname
      t.integer :result

      t.timestamps
    end
  end
end
