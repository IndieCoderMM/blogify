class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id', inverse_of: 'author', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', inverse_of: 'author', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', inverse_of: 'author', dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
