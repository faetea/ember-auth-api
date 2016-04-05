class Collection < ActiveRecord::Base
  has_many :arts
  belongs_to :user

  # validates :image, presence: true
  # validates :desc, length: { maximum: 1000, too_long: "%{count} characters is the maximum allowed" }
end
