class AddAttachmentCoverToCollections < ActiveRecord::Migration
  def self.up
    change_table :collections do |t|
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :collections, :cover
  end
end
