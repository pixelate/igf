class Event < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :entries

end
