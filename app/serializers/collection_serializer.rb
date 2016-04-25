class CollectionSerializer < ActiveModel::Serializer
  attributes :id, :name, :desc, :user_id, :arts, :cover, :thumb_url, :small_url, :medium_url

  private
  def arts
    object.arts.pluck(:id)
  end

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
