require 'rails_helper'

RSpec.describe BeersController, type: :controller do


  describe '#index' do
    context 'beer pages' do
      let(:beer_page){ { page: 1 } }

      it 'gets 1st page' do
        request.headers.merge!(auth_header)
        get 'index', params: beer_page

        byebug
      end
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