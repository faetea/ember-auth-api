class Collection < ActiveRecord::Base
  belongs_to :user
  has_many :arts, dependent: :destroy

  # validates :image, presence: true
  # validates :desc, length: { maximum: 1000, too_long: "%{count} characters is the maximum allowed" }
end
