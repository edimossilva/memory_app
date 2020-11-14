class MemorySerializer < ActiveModel::Serializer
  attributes :id, :key, :value, :visibility
end
