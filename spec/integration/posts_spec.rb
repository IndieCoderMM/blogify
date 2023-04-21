require 'swagger_helper'

RSpec.describe 'Posts API', type: :request do
  let(:user) { User.create!(name: 'John', email: 'john@gmail.com', password: 'password') }

  path '/users/{id}/posts.json' do

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
                 required: ['id', 'title', 'text', 'author_id', 'created_at', 'updated_at']
               }
        let(:id) { user.id }
        run_test!
      end
    end
  end
end
