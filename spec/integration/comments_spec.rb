require 'swagger_helper'

RSpec.describe 'Comments API', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create!(name: 'John', email: 'john@gmail.com', password: 'password') }
  let(:post) { Post.create!(author: user, title: 'Title', text: 'Text') }

  before do
    user.confirmed_at = Time.now
    sign_in user
  end

  path '/users/{user_id}/posts/{id}/comments' do
    get 'Lists all comments of a post' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer
      parameter name: :id, in: :path, type: :integer

      response '200', 'all comments returned' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   text: { type: :string },
                   author_id: { type: :integer },
                   post_id: { type: :integer },
                   created_at: { type: :string },
                   updated_at: { type: :string }
                 },
                 required: %w[id title text author_id created_at updated_at]
               }
        let(:user_id) { user.id }
        let(:id) { post.id }
        run_test!
      end
    end
  end
end
