require 'swagger_helper'

describe 'Bikes API' do
  path '/api/v1/bikes' do
    post 'Creates a bike' do
      tags 'Bikes'
      consumes 'application/json', 'application/xml'
      parameter name: :bike, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          bike_type: { type: :string },
          description: { type: :string },
          brand: { type: :string },
          daily_rate: { type: :decimal },
          user_id: { type: :integer },
          images: { type: :hstore },
          color: { type: :array }
        },
        required: %w[name bike_type description brand daily_rate user_id images color]
      }

      response '201', 'bike created' do
        let(:user) { User.create!(name: 'name', email: 'email.com', password: 'password') }
        let(:bike) do
          { name: 'Bike', bike_type: 'Mountain', description: 'This is a bike', brand: 'Trek', daily_rate: 10.0, user_id: user.id,
            images: { blue: 'da' }, color: ['abc'] }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:bike) { { name: 'foo' } }
        run_test!
      end
    end

    get 'Retrieves bikes' do
      tags 'Bikes'
      produces 'application/json', 'application/xml'
      response '200', 'bikes found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   bike_type: { type: :string },
                   description: { type: :string },
                   brand: { type: :string },
                   daily_rate: { type: :decimal },
                   user_id: { type: :integer },
                   images: { type: :hstore },
                   color: { type: :array }
                 }
               }
        run_test!
      end
    end
  end

  path '/api/v1/bikes/{id}' do
    delete 'Deletes a bike' do
      tags 'Bikes'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '204', 'bike deleted' do
        let(:user) { User.create!(name: 'name', email: 'email.com', password: 'password') }
        let(:id) do
          Bike.create!(name: 'name', bike_type: 'type', description: 'desc', brand: 'brand',
                       daily_rate: 10.0, user_id: user.id, images: { blue: 'da' }, color: ['abc']).id
        end
        run_test!
      end
    end
  end
end
