module StoriesHelper
  def user_rolled(story)
    logged_in? && (current_user.id == story.user_id || story.votes.find_by_user_id(current_user.id))
  end

  def get_domain(url)
    regex = /^https?:\/\/(www.)?([^\/]+)/
    regex =~ url
    $2
  end

end
