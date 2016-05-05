class Post

  class InvalidCommentError < StandardError
  end

  attr_reader :title, :url, :points, :comments

  def initialize(data)
    @title = data[:title]  
    @url = data[:url]
    @points = data[:points]
    @item_id = data[:item_id]
    @comments = []
  end

  def load_comments(comment_array)
    comment_array.each do |comment_hash| 
      comment = Comment.new(comment_hash[:user],comment_hash[:text],comment_hash[:age])
      add_comment(comment)
    end
  end
  
  def to_s
    "Post title: #{title.white}\nURL: #{url.white}\nPoints: #{points.to_s.red}\n# of comments: #{comments.length.to_s.blue}"
  end

  def add_comment(comment)
    unless comment.is_a? Comment
      raise InvalidCommentError, "You can only add Comments. You tried to add a #{comment.class}"
    end
    @comments << comment
  end
end