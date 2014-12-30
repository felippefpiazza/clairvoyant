class CreateFaulthistories < ActiveRecord::Migration
  def change
    create_table :faulthistories do |t|
      t.string  :description
      t.integer :active
      t.integer :device_id
      t.integer :parameter_id
      t.timestamps
    end
  end
end
