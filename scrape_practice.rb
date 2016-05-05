require 'nokogiri'
require 'open-'

page = Nokogiri::HTML(open('post.html'))
puts page.class