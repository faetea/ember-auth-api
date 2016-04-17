class CollectionSerializer < ActiveModel::Serializer
  attributes :id, :name, :desc, :user_id, :cover, :thumb_url, :small_url, :medium_url
  # :created_at, :updated_at, :cover_file_name, :cover_content_type, :cover_file_size, :cover_updated_at

  private
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
