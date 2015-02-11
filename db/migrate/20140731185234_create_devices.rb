class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string  :serial
      t.string  :serial_hex
      t.integer :clairvoyant_id
      t.timestamps
    end
  end
end
