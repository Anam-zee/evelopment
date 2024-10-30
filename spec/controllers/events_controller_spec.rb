require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  let(:user) { create(:user) }
  let(:event) { create(:event, organizer: user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Event' do
        expect {
          post :create, params: { event: attributes_for(:event) }
        }.to change(Event, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable_entity status' do
        post :create, params: { event: attributes_for(:event, name: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      it 'updates the requested event' do
        put :update, params: { id: event.id, event: { name: 'New Name' } }
        expect(response).to have_http_status(:accepted)
        event.reload
        expect(event.name).to eq('New Name')
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable_entity status' do
        put :update, params: { id: event.id, event: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested event' do
      event
      expect {
        delete :destroy, params: { id: event.id }
      }.to change(Event, :count).by(-1)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #join' do
    it 'adds the current user to the event' do
      post :join, params: { id: event.id }
      expect(response).to have_http_status(:accepted)
      expect(event.joiners).to include(user)
    end
  end
end
