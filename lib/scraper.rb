require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_hash = []
    
    html = Nokogiri::HTML(open(index_url))
    
    html.css(".student-card").each do |student|
      hash = {:name => student.css("h4.student-name").text, :location => student.css("p.student-location").text, :profile_url => "http://students.learn.co/" + student.css("a").attribute("href")
      }
      students_hash << hash
    end
    students_hash
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    return_hash = {}

      social = doc.css(".vitals-container .social-icon-container a")
      social.each do |element|
        if element.attr('href').include?("twitter")
          return_hash[:twitter] = element.attr('href')
        elsif element.attr('href').include?("linkedin")
          return_hash[:linkedin] = element.attr('href')
        elsif element.attr('href').include?("github")
          return_hash[:github] = element.attr('href')
        elsif element.attr('href').end_with?("com/")
          return_hash[:blog] = element.attr('href')
        end
      end
      return_hash[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text
      return_hash[:bio] = doc.css(".bio-block.details-block .bio-content.content-holder .description-holder p").text

  return_hash
  
  end

end

