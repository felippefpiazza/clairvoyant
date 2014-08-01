class CreateDeviceparameters < ActiveRecord::Migration
  def change
    create_table :deviceparameters do |t|
      t.integer :device_id
      t.integer :parameter_id
      t.integer :value
      t.timestamps
    end
  end
end
