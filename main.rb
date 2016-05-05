require_relative 'post'
require_relative 'comment'
require 'open-uri'
require 'nokogiri'
require 'colorize'

def make_post(data)
  post_title = data.css("td.title a")[0].text
  post_href = data.css("td.title a")[0]["href"]
  post_points = data.css("span.score")[0].text.gsub("points","").strip
  post_item_id = data.css("span.score")[0]["id"].gsub("score_","")
  Post.new(post_title,post_href,post_points,post_item_id)
end

def load_comments(data, post)
  parsed_comments = data.css("td.default")
  parsed_comments.each do |com|
    com_user = com.css("span.comhead a")[0].text
    com_text = com.css("span.c00").text.gsub("-----","").gsub("\n"," ").strip
    com_age = com.css(".age a").text
    comment = Comment.new(com_user,com_text,com_age)
    post.add_comment(comment)
  end
  post
end

URL_REGEX = /^https?:\/\/news\.ycombinator\.com\/item\?id=\d+$/
@url = ARGV[0]

if @url[URL_REGEX]
  data = Nokogiri::HTML(open(@url))
  @post = load_comments(data,make_post(data))
  puts @post
  puts "\nComments Summary:\n---".white
  @post.comments.each { |comment| puts comment }
  puts "---"
else
  puts "Invalid URL!"
end