module Beers
  class BeersService

    def initialize(user)
      @user = user
      @punk_api = 'https://api.punkapi.com/v2/beers'
      @con = Faraday.new(url: @punk_api)
    end

    # Beers will be searched through name and ABV
    # We advance through the beer list with page
    # We get a beer by its id
    # Beers are saved as (Model) Beer once retrieved

    def get_beers_by_query(name: nil, abv: nil, page: 1)
      query = { page: page || 1 }
      query.merge!(name: clean_string(name)) if name.present?
      query.merge!(abv_lt: (abv + 0.1), abv_gt: (abv - 0.1)) if abv.present?

      res = @con.get '', query
      return res if res.status != 200

      save_beers(JSON.parse(res.body))
      res
    end

    def get_beer_by_id(id)
      params = { ids: id.to_i }
      res = @con.get '', params
      return res if res.status != 200

      save_beers(JSON.parse(res.body))
      res
    end

    def save_beers(beers)
      beers.each { |beer| save_beer(beer) }
    end

    def save_beer(beer)
      id = beer['id']
      return true if Beer.where(id: id).first.present?

      beer = Beer.new(id: id, name: beer['name'], tagline: beer['tagline'],
                      description: beer['description'], abv: beer['abv'].to_d)
      beer.save
      user_beer = UserBeer.new(user: @user, beer: beer,
                              favorite: false, seen_at: Time.now.localtime)
      user_beer.save
    end

    def clean_string(string)
      string.gsub(' ', '_')
    end
  end
end