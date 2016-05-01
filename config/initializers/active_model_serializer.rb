# Be sure to restart your server when you modify this file.
#
# The use of .embed method on a Serializer will be soon removed,
# as this should have a global scope and not a class scope.
# Please use the global .setup method instead:
ActiveModel::Serializer.setup do |config|
  # embeds an array of ids
  config.embed = :ids
  # sideloads models
  config.embed_in_root = true
end
