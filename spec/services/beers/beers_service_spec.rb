require 'rails_helper'
require 'vcr'

RSpec.describe BeersService do

  describe '#get_beer_by_id', :vcr, record: :new_episodes do
    it 'gets beer id=1 & saves it' do
      service = BeersService.new
      response = service.get_beer_by_id(1)

      result = JSON.parse(response.body).first
      beer = Beer.find(1)

      expect(response.status).to eq 200
      expect(result['id']).to eq 1
      expect(result['name']).to eq beer.name
      expect(result['tagline']).to eq beer.tagline
      expect(result['description']).to eq beer.description
    end
  end

  describe '#get_beers_by_query', :vcr, record: :new_episodes do
    before(:all) do
      @service = BeersService.new
    end

    it 'gets beers with "buzz" in its name & saves them' do
      response = @service.get_beers_by_query(name: 'buzz')

      result = JSON.parse(response.body)
      beer = Beer.first

      expect(response.status).to eq 200
      expect(result.length).to eq 25
      expect(result.first['id']).to eq 1
      expect(result.first['name']).to eq beer.name
      expect(result.first['tagline']).to eq beer.tagline
      expect(result.first['description']).to eq beer.description
    end

    it 'gets beers with abv=4.5 & saves them' do
      response = @service.get_beers_by_query(abv: 4.5)

      result = JSON.parse(response.body)
      beer = Beer.first

      expect(response.status).to eq 200
      expect(result.length).to eq 18
      expect(result.first['id']).to eq 1
      expect(result.first['name']).to eq beer.name
      expect(result.first['tagline']).to eq beer.tagline
      expect(result.first['description']).to eq beer.description
    end

    it 'gets beers for page=1 & saves them' do
      response = @service.get_beers_by_query(page: 1)

      result = JSON.parse(response.body)
      beer = Beer.first

      expect(response.status).to eq 200
      expect(result.length).to eq 25
      expect(result.first['id']).to eq 1
      expect(result.first['name']).to eq beer.name
      expect(result.first['tagline']).to eq beer.tagline
      expect(result.first['description']).to eq beer.description
    end
  end

end
