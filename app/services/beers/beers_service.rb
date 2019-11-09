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

    save_beer(JSON.parse(res.body)[0])
    res
  end


  def save_beer(beer)
    id = beer['id']
    return true if Beer.where(id: id).first.present?

    name  = beer['name']
    tag   = beer['tagline']
    desc  = beer['description']
    abv   = beer['abv'].to_d
    beer = Beer.new(id: id, name: name, tagline: tag, description: desc, abv: abv)
    beer.save
  end

end