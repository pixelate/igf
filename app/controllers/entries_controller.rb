class EntriesController < ApplicationController
  layout 'application' 

  def index
    @entries = Entry.order("name ASC")
  end

  def gallery
    @entries = Entry.order("name ASC")
  end

  def show
    @entry = Entry.find(params[:id])
  end
end
