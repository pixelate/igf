class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :find_events
  
  private
  
  def find_events
    @events = Event.order("year DESC")
  end
  
end
