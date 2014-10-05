class CreateDeviceinfos < ActiveRecord::Migration
  def change
    create_table :deviceinfos do |t|
      t.string  :cob_id
      t.string  :name                                  
      t.timestamps
    end
  end
end
