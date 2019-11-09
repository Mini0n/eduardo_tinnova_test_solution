class BeersService

  def initialize
    @punk_api = 'https://api.punkapi.com/v2/beers'
    @con = Faraday.new(url: @punk_api)
  end

  # beer
  # id, name, tagline, description, abv

  def get_beer_by_id(id)
    params = { ids: id }
    res = @con.get '', params
    return res if res.status != 200

    save_beers(JSON.parse(res.body))
    res
  end

  def get_beers_by_name(name, page = 1)
    params = { name: clean_string(name), page: page }
    res = @con.get '', params
    return res if res.status != 200

    save_beers(JSON.parse(res.body))
    res
  end

  def get_beers_by_abv(abv, page = 1)
    params = { abv_lt: (abv + 0.1), abv_gt: (abv - 0.1), page: page }
    res = @con.get '', params
    return res if res.status != 200

    save_beers(JSON.parse(res.body))
    res
  end

  def get_beers_by_page(page = 1)
    params = { page: page }
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
  end

  def clean_string(string)
    string.gsub(' ', '_')
  end

end