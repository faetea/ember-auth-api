# Serializer determines what information is served into the JSON, and how it is formatted
class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :first_name, :last_name, :bio, :created_at
end
