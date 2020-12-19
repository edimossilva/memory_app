class MemorySerializer < ActiveModel::Serializer
  attributes :id, :key, :value, :visibility, :tags

  has_many :tags
end
