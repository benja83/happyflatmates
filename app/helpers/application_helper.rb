module ApplicationHelper
  def find_all
    @users = User.all
  end
  def next_month name, options = {}, html_options = {} # or some variation
    # eg. deal with options hash the way button_to deals with it here?
    content_tag :button, html_options = nil do
      raw name
    end
  end
end
