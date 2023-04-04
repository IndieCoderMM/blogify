class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  private 
  
  def update_counter
    post.increment!(:likes_counter)
  end
end
