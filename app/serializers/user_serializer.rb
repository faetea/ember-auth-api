# Serializer determines what information is served into the JSON, and how it is formatted
class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :first_name, :last_name, :bio
  # , :can_edit

  # def can_edit
  #   # defaults to current user which may be nil
  #   scope ? scope == object : false
  # end
end
