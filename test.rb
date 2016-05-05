require 'rspec'
require_relative 'post'
require_relative 'comment'

describe Post do
  
  before(:each) do
    @post = Post.new("Title","URL","Points","ID")
    @comment = Comment.new("User","Text","Age")
    5.times { @post.add_comment(@comment) }
  end

  describe "#comments" do
    it "can return a list of its comments" do
      expect(@post.comments.length).to eq(5)
      expect(@post.comments.all?{ |com| com.is_a? Comment}).to be true
    end
  end

  describe "#add_comment" do
    it "can add a new Comment object to a comment list" do
      comment_length = @post.comments.length
      @post.add_comment(@comment)
      expect(@post.comments.length).to eq(comment_length + 1)
      expect(@post.comments.last).to be_a Comment
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