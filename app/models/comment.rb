class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :text, presence: true

  after_save :increase_counter
  before_destroy :decrease_counter

  private

  def increase_counter
    post.increment!(:comments_counter)
  end

  def decrease_counter
    post.decrement!(:comments_counter)
  end
end
