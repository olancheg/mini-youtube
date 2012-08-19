class AddPerformedFieldToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :performed, :boolean, default: false
  end
end
