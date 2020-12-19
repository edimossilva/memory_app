class ShareableListPolicy
  attr_reader :user, :shareable_list_policy

  def initialize(user, shareable_list_policy)
    @user = user
    @shareable_list_policy = shareable_list_policy
  end

  def owner?
    user.owner?(shareable_list_policy)
  end
end
