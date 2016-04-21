class ArtSerializer < ActiveModel::Serializer
  attributes :id, :title, :caption, :collection_id, :image, :thumb_url, :small_url, :medium_url
  # :created_at, :updated_at, :image_file_name, :image_content_type, :image_file_size, :image_updated_at
  
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
