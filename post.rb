class Post

  class InvalidCommentError < StandardError
  end

  attr_reader :title, :url, :points, :comments

  def initialize(title,url,points,item_id)
    @title = title  
    @url = url
    @points = points
    @item_id = item_id
    @comments = []
  end

  def add_comment(comment)
    unless comment.is_a? Comment
      raise InvalidCommentError, "You can only add Comments. You tried to add a #{comment.class}"
    end
    @comments << comment
  end
  
  def to_s
    "Post title: #{title.white}\nURL: #{url.white}\nPoints: #{points.to_s.red}\n# of comments: #{comments.length.to_s.blue}"
  end

end