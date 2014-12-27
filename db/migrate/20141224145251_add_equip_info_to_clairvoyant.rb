class AddEquipInfoToClairvoyant < ActiveRecord::Migration
  def change
    add_column :clairvoyants, :equipment, :string    
    add_column :clairvoyants, :client_id, :integer
    add_column :clairvoyants, :obs, :string
    add_column :clairvoyants, :activated, :integer
    add_column :devices, :device_name, :string
    add_column :devices, :obs, :string    
  end
end
