require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { User.create(name: 'Jane', bio: 'Adventurer', posts_counter: 0) }
  let!(:post) do
    Post.create(title: 'My Journey', text: 'Be curious.', author: user, likes_counter: 0, comments_counter: 0)
  end
  subject { described_class.create(text: 'My comment', post:, author: user) }

  describe 'associations' do
    it 'should belong to correct user' do
      expect(subject.author).to eql user
    end

    it 'should belong to correct post' do
      expect(subject.post).to eql post
    end

    it 'should update counter of related post' do
      expect(subject.post.comments_counter).to eql 1
    end
  end
end
