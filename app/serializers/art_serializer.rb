class ArtSerializer < ActiveModel::Serializer
  attributes :id, :title, :caption, :collection_id, :image, :thumb_url, :small_url, :medium_url

  private
  def thumb_url
    image.url(:thumb)
  end

  def small_url
    image.url(:small)
  end

  def medium_url
    image.url(:medium)
  end

end
