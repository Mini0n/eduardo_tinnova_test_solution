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
    @beers = @beer.get_beers(beer_params.to_h)

    render json: {
      status: @beers.status,
      beers: JSON.parse(@beers.body)
    }
  end

  def show
    @beers = @beer.get_beer(beer_params['id'])

    render json: {
      status: @beers.status,
      beers: JSON.parse(@beers.body)
    }
  end

  def beer_params
    params.permit(:page, :id, :name, :abv)
  end

  def start_beer
    @beer = Beer.new unless @beer.present?
  end
end