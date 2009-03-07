class Tag < ActiveRecord::Base
  has_and_belongs_to_many :stories

  def to_s
    name
  end
end
