# include BeersService

class Beer < ApplicationRecord

  def get_beer(beer_id)
    service.get_beer_by_id(beer_id)
  end

  # Reads beers from punkapi & stores them
  # 25 beers or less by page
  #
  # @param: page [int] - beers list page
  # @param: name [string] - string to search in name
  # @param: abv [int] - integer to search in ABV
  def get_beers(params)
    service.get_beers_by_query(
      page: (params['page'] if params['page'].present?),
      name: (params['name'] if params['name'].present?),
       abv: (params['abv'].to_d if params['abv'].present?)
    )
  end

  # # Gets all stored beers (Model Beer)
  # def get_all_beers
  #   Beer.all
  # end


  def service
    @service = BeersService.new unless @service.present?
    @service
  end
end
