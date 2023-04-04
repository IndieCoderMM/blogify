class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def update_counter
    count = post.comments_counter || 0
    post.update_columns(comments_counter: count + 1)
  end
end
