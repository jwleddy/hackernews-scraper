require_relative 'post'
require_relative 'comment'
require_relative 'scraper'
require 'open-uri'
require 'nokogiri'
require 'colorize'

URL_REGEX = /^https?:\/\/news\.ycombinator\.com\/item\?id=\d+$/

def main
  @url = ARGV[0]
  if @url[URL_REGEX]
    @scraper = Scraper.new(@url)
    post_data = @scraper.parse_post
    @post = Post.new(post_data)
    comment_data = @scraper.parse_comments
    @post.load_comments(comment_data)
    puts @post
    puts "\nComments Summary:\n---".white
    @post.comments.each { |comment| puts comment }
    puts "---"
  else
    puts "Invalid URL!"
  end
end

main