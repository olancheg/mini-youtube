class AddFailedFieldToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :failed, :boolean, default: false
  end
end
