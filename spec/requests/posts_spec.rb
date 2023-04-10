require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) { User.create(name: 'Jerry', posts_counter: 0) }
  let!(:post) { Post.create(author: user, title: 'My new blog', likes_counter: 0, comments_counter: 0) }

  describe 'GET /users/:user_id/posts' do
    it 'should return a 200 ok status' do
      get user_posts_path(user_id: user.id)
      expect(response).to have_http_status(200)
    end

    it 'should render posts/index template' do
      get user_posts_path(user_id: user.id)
      expect(response).to render_template('index')
    end

    it 'should list all posts for correct user' do
      get user_posts_path(user_id: user.id)
      expect(response.body).to include("List of Posts for User ##{user.id}")
    end
  end

  describe 'GET users/:user_id/posts/:id' do
    it 'should return a 200 ok status' do
      get user_post_path(user_id: user.id, id: post.id)
      expect(response).to have_http_status(200)
    end

    it 'should render posts/show template' do
      get user_post_path(user_id: user.id, id: post.id)
      expect(response).to render_template('show')
    end

    it 'should show correct post' do
      get user_post_path(user_id: user.id, id: post.id)
      expect(response.body).to include("Post ##{post.id}")
    end
  end
end
