require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:user) { User.create(name: 'name', email: 'email1.com', password: 'password') }
  let(:bike) do
    Bike.create(name: 'bikeone', bike_type: 'one', description: 'dasdas', brand: 'dasd', daily_rate: 231.23,
                color: ['dasd'], images: { blue: 'dasda' }, user_id: user.id)
  end
  let(:valid_attributes) do
    { reservation_date: '2021-03-01', due_date: '2021-03-03', user_id: user.id, bike_id: bike.id, city: 'Accra' }
  end

  it 'is valid with valid attributes' do
    subject = Reservation.new(valid_attributes)
    expect(subject).to be_valid
  end

  it 'is not valid without a bike_id' do
    reservation = Reservation.new(valid_attributes.except(:bike_id))
    expect(reservation).to_not be_valid
  end

  it 'is not valid without a user_id' do
    reservation = Reservation.new(valid_attributes.except(:user_id))
    expect(reservation).to_not be_valid
  end
end
