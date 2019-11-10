# include BeersService

class Beer < ApplicationRecord
  has_many :user_beer

  def get_beer(beer_id, user)
    @user = user
    response = service.get_beer_by_id(beer_id)

    return_beers(response)
  end

  # Reads beers from punkapi & stores them
  # 25 beers or less by page
  #
  # @param: page [int] - beers list page
  # @param: name [string] - string to search in name
  # @param: abv [int] - integer to search in ABV
  def get_beers(params, user)
    @user = user
    response = service.get_beers_by_query(
      page: (params['page'] if params['page'].present?),
      name: (params['name'] if params['name'].present?),
      abv: (params['abv'].to_d if params['abv'].present?)
    )

    return_beers(response)
  end

  def return_beers(response)
    result = { status: response.status }
    result.merge!(beers: beer_infos(response.body)) if result[:status] == 200
    result.merge!(errors: JSON.parse(response.body)) unless result[:status] == 200
    result
  end

  # Gets all stored beers (Model Beer)
  def get_all_beers(user)
    @user = user
    user_beers = Beer.all.map do |beer|
      UserBeer.where(beer_id: beer.id, user_id: @user.id).first
    end
    UserBeer.new.read_beers(user_beers)
  end

  def beer_infos(beers_body)
    user_beers = JSON.parse(beers_body).map do |beer|
      UserBeer.where(beer_id: beer['id'], user_id: @user.id).first
    end
    UserBeer.new.read_beers(user_beers)
  end

  def service
    @service = Beers::BeersService.new(@user) unless @service.present?
    @service
  end
end
