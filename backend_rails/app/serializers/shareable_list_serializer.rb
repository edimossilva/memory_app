class ShareableListSerializer < ActiveModel::Serializer
  attributes :id, :name, :memories, :user_id

  has_many :memories
end
