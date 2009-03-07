class Story < ActiveRecord::Base
  #has_many :tags, :through => :stories_tags
  has_and_belongs_to_many :tags
  belongs_to :user
  
  validates_presence_of :url
  validates_format_of :url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}((:[0-9]{1,5})?\/.*)?$/ix
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :user_id

  def tag_list
    self.tags.to_a
  end

  def tag_list=(list)
    list.downcase!
    split = list.split(',')
    split.each do |s|
      s.strip!
      tag = Tag.find_by_name(s)
      tag = Tag.new(:name => s, :count => 0) unless tag
      tag.count += 1
      self.tags << tag
    end
  end
end
