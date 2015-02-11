class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.string  :name
      t.integer  :manufacturer_id
      t.timestamps
    end
    add_column :clairvoyants, :equipment_id, :integer    
  end
end
