class CreateDevicefaults < ActiveRecord::Migration
  def change
    create_table :devicefaults do |t|
      t.integer :device_id
      t.integer :fault_id
      t.string :hexa_value      
      t.integer :value
      t.timestamps
    end
  end
end
