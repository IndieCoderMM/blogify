require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Hein', bio: 'Web Developer', posts_counter: 0) }

  before { subject.save }

  context 'validating :name' do
    it 'should not valid if not present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should valid if unique' do
      expect(subject).to be_valid
    end

    it 'should not valid if not unique' do
      user = User.create(name: 'Tom', bio: 'Magician', posts_counter: 3)
      subject.name = 'tom'
      expect(subject).to_not be_valid
    end
  end

  context 'validating :posts_counter' do
    it 'should not valid if less than 0' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end

    it 'should valid if greater than 0' do
      subject.posts_counter = 3
      expect(subject).to be_valid
    end
  end
end
