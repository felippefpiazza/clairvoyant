class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.string  :cob_id
      t.string  :display_name
      t.boolean :signed_value
      t.integer :decimal_shift
      t.integer :min
      t.integer :max
      t.integer :bit_select      
      t.string  :unit
      t.integer :step_size
      t.integer :length_in_bytes
      t.string  :can_name
      t.timestamps
    end
  end
end
