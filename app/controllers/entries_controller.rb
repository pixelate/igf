class EntriesController < ApplicationController
  layout 'application' 

  def main
    @entries = Entry.where(:is_student => false).order("name ASC")
    @headline = "Main competition"
    render "index"
  end
  
  def students
    @entries = Entry.where(:is_student => true).order("name ASC")
    @headline = "Student competition"
    render "index"
  end

  def gallery_main
    @entries = Entry.where(:is_student => false).order("name ASC")
    @headline = "Main competition"
    render "gallery"
  end

  def gallery_students
    @entries = Entry.where(:is_student => true).order("name ASC")
    @headline = "Student competition"
    render "gallery"
  end

  def concepts_main
    @headline = "Main competition"
    @entries = Entry.where(:is_student => false).order("name ASC")
    render "concepts"
  end

  def concepts_students
    @entries = Entry.where(:is_student => true).order("name ASC")
    @headline = "Student competition"
    render "concepts"
  end

end
