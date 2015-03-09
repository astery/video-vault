class AddFileToVideos < ActiveRecord::Migration
  def self.up
    add_attachment :videos, :file
  end

  def self.down
    remove_attachment :videos, :file
  end
end
