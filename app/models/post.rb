class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, inverse_of: 'post', dependent: :destroy
  has_many :comments, inverse_of: 'post', dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :comments_counter, numericality: {greater_than_or_equal_to: 0}

  after_save :update_counter

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_counter
    author.increment!(:posts_counter)
  end
end
