#
class User < ActiveRecord::Base
  include Authentication

  has_many :collections, dependent: :destroy

  has_attached_file :avatar,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # By default, every file uploaded will be named 'data'.
  # This renames the file to a timestamp, preventing name collisions.
  # This will also fix browser caching issues for updates
  def rename_avatar
    self.avatar.instance_write :file_name, "#{Time.now.to_i.to_s}.png"
  end

  before_post_process :rename_avatar

  # validates :bio, length: { maximum: 500, too_long: "%{count} characters is the maximum allowed" }
end
