class EntriesController < ApplicationController
  layout 'application' 
  
  before_filter :find_entries

  def index
  end

  def gallery
    render "gallery"
  end

  def concepts
    render "concepts"
  end

  private
  
  def find_entries
    if params[:id].nil?
      @event = Event.last
    else
      @event = Event.find(params[:id])
    end
    
    @entries = Entry.where(:event_id => @event.id).order("name ASC")
    @headline = @event.title + " " + @event.year.to_s        
  end
end