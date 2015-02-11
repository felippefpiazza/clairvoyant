class AddTypeToParameters < ActiveRecord::Migration
  def change
    add_column :parameters, :type_param, :string
    
  end
end
