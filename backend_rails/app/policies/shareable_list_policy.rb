class ShareableListPolicy
  attr_reader :user, :shareable_list

  def initialize(user, shareable_list)
    @user = user
    @shareable_list = shareable_list
  end

  def owner?
    user.owner?(shareable_list)
  end
end
