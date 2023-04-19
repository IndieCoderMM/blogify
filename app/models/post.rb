class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, inverse_of: 'post', dependent: :destroy
  has_many :comments, inverse_of: 'post', dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  after_save :increase_counter
  before_destroy :decrease_counter

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def increase_counter
    author.increment!(:posts_counter)
  end

  def decrease_counter
    author.decrement!(:posts_counter)
  end
end
