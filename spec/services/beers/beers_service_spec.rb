require 'rails_helper'
require 'vcr'

RSpec.describe BeersService do

  describe '#get_beer_by_id', :vcr, record: :new_episodes do
    it 'gets beer id=1 & saves it' do
      service = BeersService.new
      response = service.get_beer_by_id(1)

      result = JSON.parse(response.body)[0]
      beer = Beer.find(1)

      expect(response.status).to eq 200
      expect(result['id']).to eq 1
      expect(result['name']).to eq beer.name
      expect(result['tagline']).to eq beer.tagline
      expect(result['description']).to eq beer.description
    end
  end

end