#
class User < ActiveRecord::Base
  include Authentication

  has_many :collections, dependent: :destroy

  validates :email, :username, uniqueness: true
  # validates :bio, length: { maximum: 500, too_long: "%{count} characters is the maximum allowed" }
end
