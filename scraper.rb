class Scraper

  def initialize(url)
    @data = Scraper.scrape(url)
  end

  def raw
    @data
  end

  # returns a parsed post in a hash
  def parse_post
    {
      title: @data.css("td.title a")[0].text,
      url: @data.css("td.title a")[0]["href"],
      points: @data.css("span.score")[0].text.gsub("points","").strip,
      item_id: @data.css("span.score")[0]["id"].gsub("score_","")
    }
  end

  # returns an array of comment hashes
  def parse_comments
    comment_array = []
    parsed_comments = @data.css("td.default")
    parsed_comments.each do |com|
      comment_array << {
        user: com.css("span.comhead a")[0].text,
        text: com.css("span.c00").text.gsub("-----","").gsub("\n"," ").strip,
        age: com.css(".age a").text
      }
    end
    comment_array
  end

  class << self
    def scrape(url)
      Nokogiri::HTML(open(url))
    end
  end

end