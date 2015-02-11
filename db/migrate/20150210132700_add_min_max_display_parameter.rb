class AddMinMaxDisplayParameter < ActiveRecord::Migration
  def change
  	add_column :parameters, :display_min, :string
  	add_column :parameters, :display_max, :string
  end
end
