module ApplicationHelper
  def find_all
    @users = User.all
  end
end
