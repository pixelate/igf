require 'nokogiri'
require 'open-uri'

namespace :igf do
  namespace :entries do      
    task :collect, [] => :environment do |t|
      
      number_of_entries = 568
      entries_per_page = 30

      number_of_requests = number_of_entries / entries_per_page
      (0..number_of_requests).each do |request|
        start = request * entries_per_page        
        puts "http://www.igf.com/php-bin/entries2012.php?start=#{start}"

        doc = Nokogiri::HTML(open("http://www.igf.com/php-bin/entries2012.php?start=#{start}"))        
        doc.css('table').each do |table|

          entry = Entry.new

          if table.get_attribute("bgcolor") == "#eeeeee" && table.get_attribute("width") == "100%"
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
            end
          end        
          entry.save
        end
      end
    end
  end
end