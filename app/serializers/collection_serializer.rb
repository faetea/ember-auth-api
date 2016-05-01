class CollectionSerializer < ActiveModel::Serializer
  attributes :id, :name, :desc, :user_id, :cover, :thumb_url, :small_url, :medium_url
  has_many :arts

  def thumb_url
    cover.url(:thumb)
  end

  def small_url
    cover.url(:small)
  end

  def medium_url
    cover.url(:medium)
  end

end
