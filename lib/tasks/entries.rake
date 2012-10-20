require 'nokogiri'
require 'open-uri'

namespace :igf do
  namespace :entries do      
    task :collect, [] => :environment do |t|

      # Entries: 568 + 295 = 863

      Entry.destroy_all      
      collect_entries("http://www.igf.com/php-bin/entries2012.php", 568, false)
      collect_entries("http://www.igf.com/php-bin/entries2012_student.php", 295, true)
      
    end
    
    task :migrate_2012, [] => :environment do |t|
    
      igf2012main = Event.new(:title => "Main Competition", :year => 2012)
      igf2012main.save
    
      igf2012student = Event.new(:title => "Student Competition", :year => 2012)
      igf2012student.save
    
      Entry.all.each do |entry| 
        if entry.event_id.nil?
          if entry.is_student?
            entry.event = igf2012student
          else
            entry.event = igf2012main
          end
        end
        
        entry.save
      end    
    end
  end
end

private 

def collect_entries(url, number_of_entries, is_student)
     entries_per_page = 30

      number_of_requests = number_of_entries / entries_per_page
      (0..number_of_requests).each do |request|
        start = request * entries_per_page        
        puts "#{url}?start=#{start}"

        doc = Nokogiri::HTML(open("#{url}?start=#{start}"))        
        doc.css('table').each do |table|

          entry = Entry.new
          entry.is_student = is_student

          if (table.get_attribute("bgcolor") == "#eeeeee" || table.get_attribute("bgcolor") == "#fafafa") && table.get_attribute("width") == "100%"
            table.css('tr td a img').each do |image|
              entry.image_url = image.get_attribute("src")
              entry.entry_id = image.parent.get_attribute("href").split("=").last
            end

            table.css('tr td a strong').each do |title|
              entry.name = title.content.strip
              if title.parent.next
                developer = title.parent.next.content
                entry.developer_name = developer.gsub("(", "").gsub(")", "").strip
              end
              
              entry.description = title.parent.parent.children.last.content
            end
          end        
          entry.save
        end
      end
end