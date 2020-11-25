class ShareableListMemoryPolicy
  attr_reader :user, :shareable_list_memory

  def initialize(user, shareable_list_memory)
    @user = user
    @shareable_list_memory = shareable_list_memory
  end

  def owner?
    user.owner?(shareable_list_memory.memory) && user.owner?(shareable_list_memory.shareable_list)
  end
end
