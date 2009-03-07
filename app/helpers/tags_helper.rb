module TagsHelper
  def linklize(list)
    links = []
    list.each do |item|
      links << (link_to item.name, :controller => :tags, :action => :show, :id => item.name)
    end
    links.join(', ')
  end
end
