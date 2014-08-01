class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address_type
      t.string :name
      t.integer :addressable_id
      t.string :addressable_type
      t.string :address_1
      t.string :address_2
      t.string :address_3
      t.string :address_4
      t.string :neighborhood
      t.string :reference
      t.string :city
      t.string :state
      t.integer :country_id
      t.integer :lat_degree
      t.integer :lat_hour
      t.integer :lat_minute
      t.integer :lat_second
      t.integer :lon_degree
      t.integer :lon_hour
      t.integer :lon_minute
      t.integer :lon_second
      t.integer :zipcode
      t.timestamps
    end
  end
end
