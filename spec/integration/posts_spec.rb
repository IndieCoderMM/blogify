require 'swagger_helper'

RSpec.describe 'Posts API', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create!(name: 'John', email: 'john@gmail.com', password: 'password') }

  before do
    user.confirmed_at = Time.now
    sign_in user
  end

  path '/users/{id}/posts' do
    get 'Lists all posts of a user' do
      tags 'Posts'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'all posts returned' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   text: { type: :string },
                   comments_counter: { type: :integer },
                   likes_counter: { type: :integer },
                   author_id: { type: :integer },
                   created_at: { type: :string },
                   updated_at: { type: :string }
                 },
                 required: %w[id title text author_id created_at updated_at]
               }
        let(:id) { user.id }
        run_test!
      end
    end
  end

  path '/users/{id}/posts' do
    post 'Create a new post' do
      tags 'Posts'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :post_params, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          text: { type: :string }
        },
        required: %w[title text]
      }

      response '201', 'post created' do
        let(:id) { user.id }
        let(:post_params) { { title: 'New Post', text: 'This is a test post.' } }

        run_test!
      end
    end
  end
end
