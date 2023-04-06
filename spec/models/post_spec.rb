require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { User.create(name: "Bob", bio: "Teacher", posts_counter: 0) }
  subject { described_class.new(title: "New Post", text: "This is my blog.", author: user, comments_counter: 0, likes_counter: 0) }

  context "when all requirements are satisfied" do 
    it "should valid" do 
      expect(subject).to be_valid
    end
  end 

  context "validating :title" do 
    it "should not valid if blank" do 
      subject.title = ""
      expect(subject).to_not be_valid
    end

    it "should not valid if longer than 250" do 
      subject.title = "A" * 251
      expect(subject).to_not be_valid
    end
  end

  context "validating :likes_counter" do 
    it "should not valid if less than 0" do 
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end
  end

  context "validating :comments_counter" do 
    it "should not valid if less than 0" do 
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end
  end

  context "checking associations" do 
    it "should belong to the correct user" do 
      expect(subject.author).to eql user
    end
  end    
  
end
