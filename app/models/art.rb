class Art < ActiveRecord::Base
  belongs_to :collection
  belongs_to :user, through: :collections

  # validates :image, presence: true
  # validates :caption, length: { maximum: 250, too_long: "%{count} characters is the maximum allowed" }
end
