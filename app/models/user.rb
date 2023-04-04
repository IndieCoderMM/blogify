class User < ApplicationRecord
    has_many :posts, foreign_key: 'author_id', inverse_of: 'author', dependent: :destroy
    has_many :likes, foreign_key: 'author_id', inverse_of: 'author', dependent: :destroy
    has_many :comments, foreign_key: 'author_id', inverse_of: 'author', dependent: :destroy
end