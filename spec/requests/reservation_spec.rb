require 'rails_helper'

RSpec.describe '/reservation', type: :request do
  let(:user) { User.create!(name: 'name', email: 'email.com', password: 'password') }
  let(:bike) do
    Bike.create!(name: 'bikeone', bike_type: 'one', description: 'dasdas', brand: 'dasd', daily_rate: 231.23,
                 color: ['dasd'], images: { blue: 'dasda' }, user_id: user.id)
  end
  let(:valid_attributes) do
    { reservation_date: Date.today, due_date: Date.today + 1, user_id: user.id, bike_id: bike.id, city: 'Ali city' }
  end
  let(:invalid_attributes) do
    { bike_id: nil, user_id: nil, reservation_date: nil, due_date: nil }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Reservation.create! valid_attributes
      get api_v1_reservations_url, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      reservation = Reservation.create! valid_attributes
      get api_v1_reservation_url(reservation), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'renders a JSON response with the new reservation' do
        post api_v1_reservations_url,
             params: { reservation: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Reservation' do
        expect do
          post api_v1_reservations_url,
               params: { reservation: invalid_attributes }, as: :json
        end.to change(Reservation, :count).by(0)
      end

      it 'renders a JSON response with errors for the new reservation' do
        post api_v1_reservations_url,
             params: { reservation: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end
end
