class MemoryListMemoryPolicy
  attr_reader :user, :memory_list_memory

  def initialize(user, memory_list_memory)
    @user = user
    @memory_list_memory = memory_list_memory
  end

  def owner?
    user.owner?(memory_list_memory.memory) && user.owner?(memory_list_memory.memory_list)
  end
end
