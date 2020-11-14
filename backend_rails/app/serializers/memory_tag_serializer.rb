class MemoryTagSerializer < ActiveModel::Serializer
  attributes :id
  has_one :memory
  has_one :tag
end
