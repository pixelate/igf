class EntriesController < ApplicationController
  layout 'application' 

  def index
    @entries = Entry.all
  end

  def gallery
    @entries = Entry.all
  end

  def show
    @entry = Entry.find(params[:id])
  end
end
