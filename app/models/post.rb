class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, inverse_of: 'post', dependent: :destroy
  has_many :comments, inverse_of: 'post', dependent: :destroy

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def update_counter
    count = author.posts_counter || 0
    author.update_columns(posts_counter: count + 1)
  end
end
