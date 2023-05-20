require 'rails_helper'

RSpec.describe '/user', type: :request do
  subject do
    User.create(name: 'User', email: 'ernest@gmail.com', password: 'Password')
  end

  before { subject.save }

  describe 'GET /index' do
    it 'renders a successful response' do
      subject
      get api_v1_users_path
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      subject
      get api_v1_user_path(subject)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'render a json with created response' do
        post api_v1_users_path, params: { user: { name: 'name', email: '1234email.com', password: 'password' } }
        expect(response).to have_http_status(:created)
      end
    end
    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the new user' do
        post api_v1_users_path, params: { user: { name: nil, email: nil, password: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end
end
