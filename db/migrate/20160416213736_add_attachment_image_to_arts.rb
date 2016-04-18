class AddAttachmentImageToArts < ActiveRecord::Migration
  def self.up
    change_table :arts do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :arts, :image
  end
end
