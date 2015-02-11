class AddNodeidToDevice < ActiveRecord::Migration
  def change
  	add_column :devices, :node_id, :string    
  end
end
