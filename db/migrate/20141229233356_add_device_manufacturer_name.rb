class AddDeviceManufacturerName < ActiveRecord::Migration
  def change
    add_column :devices, :device_manufacturer_identification, :string    
  end
end
