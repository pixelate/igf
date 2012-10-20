class Entry < ActiveRecord::Base

  belongs_to :developer
  belongs_to :event
  validates_presence_of :name
  validates_presence_of :developer_id
  validates_presence_of :image_url

  def developer_name=(name)
    unless name.blank?
      self.developer = Developer.find_or_create_by_name(name)
    end
  end  

end
