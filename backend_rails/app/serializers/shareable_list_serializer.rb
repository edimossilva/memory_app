class ShareableListSerializer < ActiveModel::Serializer
  attributes :id, :name, :memories

  has_many :memories
end
