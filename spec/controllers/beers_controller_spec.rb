require 'rails_helper'
require 'vcr'

RSpec.describe BeersController, type: :controller do

  before(:each) do
    request.headers.merge!(auth_header)
  end

  describe '#show', :vcr, record: :none do
    it 'shows and saves beer with id=1' do
      get 'show', params: { id: 1 }
      result = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(result['status']).to eq 200
      expect(result['beers'].first['id']).to eq 1
      expect(result['beers'].first['name']).to eq 'Buzz'
    end
  end

  describe '#index', :vcr, record: :none do
    it 'shows and saves beers for name="buzz"' do
      get 'index', params: { name: 'buzz' }
      result = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(result['status']).to eq 200
      expect(result['beers'].length).to eq 25
      expect(result['beers'].first['id']).to eq 1
      expect(result['beers'].first['name']).to eq 'Buzz'
    end

    it 'shows and saves beerswith ABV=4.5' do
      get 'index', params: { abv: 4.5 }
      result = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(result['status']).to eq 200
      expect(result['beers'].length).to eq 18
      expect(result['beers'].first['id']).to eq 1
      expect(result['beers'].first['name']).to eq 'Buzz'
    end

    it 'shows and saves beers in page 10' do
      get 'index', params: { page: 10 }
      result = JSON.parse(response.body)

      ap result

      expect(response.status).to eq 200
      expect(result['status']).to eq 200
      expect(result['beers'].length).to eq 25
      expect(result['beers'].first['id']).to eq 226
      expect(result['beers'].first['name']).to eq 'Chili Hammer'
    end
  end

  describe '#get_all', :vcr, record: :none do
    it 'gets all stored beers' do
      # Populate DB
      get 'index', params: { page: 1 }
      result = JSON.parse(response.body)
      expect(result['beers'].length).to eq 25

      # Get all
      get 'get_all'
      result = JSON.parse(response.body)

      expect(result['beers'].length).to eq 25
      expect(result['beers'].first['id']).to eq 1
      expect(result['beers'].first.key?('favorite')).to be true
    end
  end

  describe '#toggle_favs', :vcr, record: :new_episodes do
    it 'saves beer id=1 as a fav' do
      # Populate
      get 'show', params: { id: 1 }
      result = JSON.parse(response.body)
      expect(result['beers'].length).to eq 1

      get 'toggle_fav', params: { id: 1 }
      result = JSON.parse(response.body)

      expect(result['status']).to eq 200
      expect(result['beers'].first['id']).to eq 1
      expect(result['beers'].first['favorite']).to eq true
    end

    it 'saves nad unsaves beer id=1 as a fav' do
      # Populate
      get 'show', params: { id: 1 }
      result = JSON.parse(response.body)
      expect(result['beers'].length).to eq 1

      # Save fav
      get 'toggle_fav', params: { id: 1 }
      result = JSON.parse(response.body)
      expect(result['beers'].first['id']).to eq 1
      expect(result['beers'].first['favorite']).to eq true

      # Unsave fav
      get 'toggle_fav', params: { id: 1 }
      result = JSON.parse(response.body)

      expect(result['status']).to eq 200
      expect(result['beers'].first['id']).to eq 1
      expect(result['beers'].first['favorite']).to eq false
    end
  end

  describe '#get_favs', :vcr, record: :all do
    it 'gets user favorite beers' do
      # Populate
      get 'show', params: { id: 1 }
      result = JSON.parse(response.body)
      expect(result['beers'].length).to eq 1

      # Save fav
      get 'toggle_fav', params: { id: 1 }
      result = JSON.parse(response.body)
      expect(result['beers'].first['id']).to eq 1
      expect(result['beers'].first['favorite']).to eq true

      get 'get_favs'
      result = JSON.parse(response.body)

      expect(result['beers'].first['id']).to eq 1
      expect(result['beers'].first['favorite']).to eq true
    end
  end

end

# beer
# id, name, tagline, description, abv

# user_beer
# id, user_id, beer_id, favorite, seen_at

def auth_header
  admin = User.first
  token = Auth::JsonWebToken.encode(admin.to_token)
  { 'Authorization': "Bearer #{token}" }
end