require 'rspec'
require 'nokogiri'
require 'open-uri'
require 'colorize'
require_relative 'post'
require_relative 'comment'
require_relative 'scraper'

describe Post do
  
  before(:each) do
    @post = Post.new({title: "Title",url: "URL",points: "Points",item_id:"Item_ID"})
    @comment = Comment.new("User","Text","Age")
    5.times { @post.add_comment(@comment) }
  end

  describe "#comments" do
    it "can return a list of its comments" do
      expect(@post.comments.length).to eq(5)
    end
  end

  describe "#load_comments" do
    it "receives an array of hashes and sends Comment objects to #add_comment" do
      comments = Array.new(5,{user: "User",text: "Text", age: "Age"})
      expect(@post).to receive(:add_comment).with(Comment).exactly(5).times
      @post.load_comments(comments)
    end
  end

  describe "#add_comment" do
    it "can add a new Comment object to a comment list" do
      comment_length = @post.comments.length
      @post.add_comment(@comment)
      expect(@post.comments.length).to eq(comment_length + 1)
    end

    it "raises InvalidCommentError when trying to add a non-Comment object to a comment list" do
      expect { @post.add_comment("Banana") }.to raise_error(Post::InvalidCommentError)
    end
  end

end

describe Comment do

  it "has a user, text, and age property and can access them" do
    @comment = Comment.new("User","Text","Age")
    expect(@comment.user).to eq("User")
    expect(@comment.text).to eq("Text")
    expect(@comment.age).to eq("Age")
  end
end

describe Scraper do

  before(:all) do
    @scraper = Scraper.new("https://news.ycombinator.com/item?id=11632420")
  end

  describe "#raw" do
    it "returns a Nokogiri HTML doc object" do
      expect(@scraper.raw).to be_a Nokogiri::HTML::Document
    end
  end

  describe "#parse_post" do
    it "returns a hash with no nil values" do
      @post_hash = @scraper.parse_post
      expect(@post_hash.all? {|key,val| val}).to be true
    end
  end

  describe "#parse_comments" do
    it "returns an array of hashes with no nil values" do
      @comment_array = @scraper.parse_comments
      expect(@comment_array.all? {|el| el.all? {|key,val| val}}).to be true
    end
  end

end