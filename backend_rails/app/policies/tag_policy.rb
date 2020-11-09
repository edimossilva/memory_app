class TagPolicy
  attr_reader :user, :tag

  def initialize(user, tag)
    @user = user
    @tag = tag
  end

  def owner?
    user.owner?(tag)
  end
end
