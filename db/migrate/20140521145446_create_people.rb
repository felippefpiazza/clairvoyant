class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :type,  default: 'Person'
      t.string :username
      t.string :password
      t.string :title
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :nickname
      t.string :tel_1
      t.string :tel_2
      t.string :email
      t.date :birthday
      t.string :gender, limit: 1
      t.timestamps
    end

    add_index :people, :type
    add_index :people, :email
    add_index :people, :username
    
  end
end
