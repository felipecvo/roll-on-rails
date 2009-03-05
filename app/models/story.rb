class Story < ActiveRecord::Base
  has_many :tags, :through => :stories_tags
  
  validates_presence_of :url
  validates_format_of :url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}((:[0-9]{1,5})?\/.*)?$/ix
  validates_presence_of :title
  validates_presence_of :description
end
