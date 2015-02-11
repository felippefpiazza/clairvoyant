class CreateDevicevalues < ActiveRecord::Migration
  def change
    create_table :devicevalues do |t|
      t.integer :device_id
      t.integer :parameter_id
      t.string  :value_hexa
      t.integer :value
      t.string  :type
      t.timestamps
    end
  end
end
