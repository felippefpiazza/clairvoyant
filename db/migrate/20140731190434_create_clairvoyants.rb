class CreateClairvoyants < ActiveRecord::Migration
  def change
    create_table :clairvoyants do |t|
      t.string  :serial
      t.string  :serial_hex
      t.timestamps
    end
  end
end
