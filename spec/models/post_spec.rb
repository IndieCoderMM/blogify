require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { User.create(name: 'John', bio: 'Teacher', posts_counter: 0) }
  subject do
    described_class.new(title: 'New Post', text: 'This is my blog.', author: user, comments_counter: 0,
                        likes_counter: 0)
  end

  before { subject.save }

  describe 'validations' do
    it 'should valid with valid attribuites' do
      expect(subject).to be_valid
    end

    it 'should not valid if :title is blank' do
      subject.title = ''
      expect(subject).to_not be_valid
    end

    it 'should not valid if :title is longer than 250' do
      subject.title = 'A' * 251
      expect(subject).to_not be_valid
    end

    it 'should not valid if :likes_counter is less than 0' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end

    it 'should not valid if :likes_counter is not integer' do
      subject.likes_counter = 3.5
      expect(subject).to_not be_valid
    end

    it 'should not valid if :comments_counter is less than 0' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'should not valid if :comments_counter is not integer' do
      subject.comments_counter = 0.4
      expect(subject).to_not be_valid
    end
  end

  describe 'associations' do
    it 'should belong to the correct user' do
      expect(subject.author).to eql user
    end

    it 'should update counter of related user' do
      expect(subject.author.posts_counter).to eql 1
    end
  end

  describe '#recent_comments' do
    before do
      6.times do |i|
        Comment.create(text: "Comment#{i + 1}", author: user, post: subject)
      end
    end

    it 'should return 5 most recent comments' do
      expect(subject.recent_comments.length).to eql 5
    end

    it 'should return the most recent one as first item' do
      expect(subject.recent_comments[0].text).to eql 'Comment6'
    end
  end
end
