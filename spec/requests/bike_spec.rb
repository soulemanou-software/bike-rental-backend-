require 'rails_helper'

RSpec.describe '/bike', type: :request do
  let(:user) { User.create!(name: 'name', email: 'email.com', password: 'password') }
  let(:valid_attributes) do
    { name: 'bikeone', bike_type: 'one', description: 'dasdas', brand: 'dasd', daily_rate: 231.23, color: ['dasd'],
      images: { blue: 'dasda' }, user_id: user.id }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Bike.create! valid_attributes
      get api_v1_bikes_path
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      bike = Bike.create! valid_attributes
      get api_v1_bike_path(bike)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'renders a JSON response with the new bike' do
        post api_v1_bikes_url, params: { bike: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the new bike' do
        post api_v1_bikes_path,
             params: { bike: { name: nil, bike_type: nil, description: nil, brand: nil, daily_rate: nil, images: nil,
                               color: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end
end
