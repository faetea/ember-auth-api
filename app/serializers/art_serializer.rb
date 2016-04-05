class ArtSerializer < ActiveModel::Serializer
  attributes :id, :title, :caption, :image
end
