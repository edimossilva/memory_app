class MemoryTagPolicy
  attr_reader :user, :memory_tag

  def initialize(user, memory_tag)
    @user = user
    @memory_tag = memory_tag
  end

  def owner?
    user.owner?(memory_tag.memory) && user.owner?(memory_tag.tag)
  end
end
