class Event < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title_and_year, use: :slugged

  has_many :entries, :dependent => :destroy

  def title_and_year
    "#{title} #{year}"
  end

end
