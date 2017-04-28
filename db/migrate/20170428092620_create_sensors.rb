class CreateSensors < ActiveRecord::Migration[5.1]
  def change
    create_table :sensors do |t|
      t.integer :number, null:false
      t.integer :raw_value, null: false
      t.datetime :measured_at, null: false
      t.boolean :is_uploaded, null: false, default: false
    end
  end
end
