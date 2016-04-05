#
class User < ActiveRecord::Base
  include Authentication

  has_many :collections
  has_many :arts, through: :collections

  # validates :bio, length: { maximum: 500, too_long: "%{count} characters is the maximum allowed" }
end
