class BeersController < ApplicationController
  before_action :authenticate!, :start_beer

  # GET: reads, searches & saves beers from punkapi
  # 25 beers by page.
  #
  # @param: page [int] - beers list page
  # @param: id [int] - beer id
  # @param: name [string] - string to search in name
  # @param: abv [int] - integer to search in ABV
  def index
    beers = @beer.get_beers(beer_params.to_h, @current_user)

    render json: {
      status: beers[:status],
      beers: beers[:beers],
      errors: beers[:errors]
    }
  end

  def show
    beers = @beer.get_beer(beer_params['id'], @current_user)

    render json: {
      status: beers[:status],
      beers: beers[:beers],
      errors: beers[:errors]
    }
  end

  def get_all
    beers = @beer.get_all_beers(@current_user)

    render json: {
      status: 200,
      beers: beers,
      errors: nil
    }
  end

  # Gets fav beers for current user
  def get_favs
    beers = @user_beer.get_favs(@current_user)

    render json: {
      status: 200,
      beers: beers,
      errors: nil
    }
  end

  # Toggles a beer favorite (true||false) for a beer id
  def toggle_fav
    beer = @user_beer.toggle_fav(beer_params[:id], @current_user)

    render json: {
      status: 200,
      beers: beer,
      errors: nil
    }
  end


  def beer_params
    params.permit(:page, :id, :name, :abv)
  end

  def start_beer
    @beer = Beer.new unless @beer.present?
    @user_beer = UserBeer.new unless @user_beer.present?
  end
end