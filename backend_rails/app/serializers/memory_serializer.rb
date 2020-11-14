class MemorySerializer < ActiveModel::Serializer
  attributes :id, :key, :value, :visibility

  has_many :tags
end
