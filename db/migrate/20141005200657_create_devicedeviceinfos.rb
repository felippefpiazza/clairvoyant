class CreateDevicedeviceinfos < ActiveRecord::Migration
  def change
    create_table :devicedeviceinfos do |t|
      t.integer :device_id
      t.integer :deviceinfo_id
      t.string :hexa_value      
      t.integer :value
      t.timestamps
    end
  end
end
