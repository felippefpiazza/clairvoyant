class AddEquipmentAndDevicenodeToParameters < ActiveRecord::Migration
  def change
  	add_column :parameters, :equipment_id, :integer
  	add_column :parameters, :node_id, :integer

  end
end
