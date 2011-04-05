class Album < ActiveRecord::Base
  validates :name,  :presence => true
  validates_uniqueness_of :name
  cattr_reader :per_page
  @@per_page = 4

end
