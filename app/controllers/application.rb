# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'e8d8944b881d27fa4c0fd56c24390161'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  protected

  def create_permalink(string, separator = '-', max_size = 127)
    ignore_words = ['a', 'an', 'the']
    ignore_regex = String.new

    ignore_words.each do |word|
      ignore_regex << word + '\b|\b'
    end
    ignore_regex = '\b' + ignore_regex + '\b'
    ignore_regex = Regexp.new(ignore_regex)

    permalink = string.gsub("'", separator)

    permalink.gsub!(ignore_regex, '')

    permalink.downcase!

    permalink.gsub!(/[^a-z0-9-]+/, separator)

    permalink = permalink.to(max_size)

    permalink.gsub(Regexp.new("^#{separator}+|#{separator}+$"), '')
  end
end
