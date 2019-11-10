require 'rails_helper'
require 'vcr'

RSpec.describe BeersController, type: :controller do

  describe '#show', :vcr, record: :none do
    it 'shows and saves beer with id=1' do
      request.headers.merge!(auth_header)
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
      request.headers.merge!(auth_header)
      get 'index', params: { name: 'buzz' }

      result = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(result['status']).to eq 200
      expect(result['beers'].length).to eq 25
      expect(result['beers'].first['id']).to eq 1
      expect(result['beers'].first['name']).to eq 'Buzz'
    end

    it 'shows and saves beerswith ABV=4.5' do
      request.headers.merge!(auth_header)
      get 'index', params: { abv: 4.5 }

      result = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(result['status']).to eq 200
      expect(result['beers'].length).to eq 18
      expect(result['beers'].first['id']).to eq 1
      expect(result['beers'].first['name']).to eq 'Buzz'
    end

    it 'shows and saves beers in page 10' do
      request.headers.merge!(auth_header)
      get 'index', params: { page: 10 }

      result = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(result['status']).to eq 200
      expect(result['beers'].length).to eq 25
      expect(result['beers'].first['id']).to eq 226
      expect(result['beers'].first['name']).to eq 'Chili Hammer'
    end
  end


  # describe '#favorite' do
  # end

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