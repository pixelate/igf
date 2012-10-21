class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :find_events
  before_filter :authenticate
  
  private
  
  def find_events
    @events = Event.order("year DESC")
  end
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == "igf2013preview"
    end
  end

end
