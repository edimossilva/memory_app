class MemoryListPolicy
  attr_reader :user, :memory_list

  def initialize(user, memory_list)
    @user = user
    @memory_list = memory_list
  end

  def owner?
    user.owner?(memory_list)
  end
end
