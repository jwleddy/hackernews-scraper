class Comment

  attr_reader :user, :text, :age

  def initialize(user,text,age)
    @user = user
    @text = text
    @age = age
  end

  def trunc_comment
    "#{text[0..20]}..."
  end

  def to_s
    "User: #{user.green}\tDays old: #{age.red}\tComment: #{trunc_comment.yellow}"
  end

end