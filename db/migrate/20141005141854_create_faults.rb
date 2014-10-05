class CreateFaults < ActiveRecord::Migration
  def change
    create_table :faults do |t|
      t.string  :cob_id
      t.string  :name
      t.string  :bit0
      t.integer :bit0_code
      t.string  :bit1
      t.integer :bit2_code
      t.string  :bit2
      t.integer :bit3_code
      t.string  :bit3
      t.integer :bit4_code
      t.string  :bit4
      t.integer :bit4_code
      t.string  :bit5
      t.integer :bit5_code
      t.string  :bit6
      t.integer :bit6_code
      t.string  :bit7     
      t.integer :bit7_code                                   
      t.timestamps
    end
  end
end
