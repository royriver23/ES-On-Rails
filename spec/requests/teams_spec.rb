require 'rails_helper'

RSpec.describe 'teams API', type: :request do
  # initialize test data
  let!(:teams) { create_list(:team, 10) }
  let(:team_id) { teams.first.id }

  # Test suite for GET /teams
  describe 'GET /teams' do
    # make HTTP get request before each example
    before { get '/teams' }

    it 'returns teams' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /teams/:id
  describe 'GET /teams/:id' do
    before { get "/teams/#{team_id}" }

    context 'when the record exists' do
      it 'returns the team' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(team_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:team_id) { -1 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Team/)
      end
    end
  end

  # Test suite for POST /teams
  describe 'POST /teams' do
    # valid payload
    let(:valid_attributes) { { name: 'Bernhard, Schneider and Casper', mission: 'mission-critical brand convergence' } }

    context 'when the request is valid' do
      before { post '/teams', params: valid_attributes }

      it 'creates a team' do
        valid_attributes.each { |attr| expect(json[attr.first.to_s]).to eq(attr.last) }
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/teams', params: { title: 'Moen - McGlynn' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /teams/:id
  describe 'PUT /teams/:id' do
    let(:valid_attributes) { { name: 'Kulas, Davis and Strosin' } }

    context 'when the record exists' do
      before { put "/teams/#{team_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /teams/:id
  describe 'DELETE /teams/:id' do
    before { delete "/teams/#{team_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
