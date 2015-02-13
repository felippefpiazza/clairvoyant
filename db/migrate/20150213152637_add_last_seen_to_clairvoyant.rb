class AddLastSeenToClairvoyant < ActiveRecord::Migration
  def change
    	add_column :clairvoyants, :last_seen_at, :datetime
  end
end
