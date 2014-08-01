class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string :access_token
      t.integer :clairvoyant_id
      t.boolean :revoked
      t.datetime :expires_at
      t.timestamps
    end
  end
end
