class BeersController < ApplicationController
  before_action :authenticate!

  # GET: reads, searches & saves beers from punkapi
  # 25 beers by page.
  #
  # @param: page [int] - beers list page
  # @param: id [int] - beer id
  # @param: name [string] - string to search in name
  # @param: tagline [string] - string to search in tagline
  # @param: description [string] - string to search in description
  # @param: abv [int] - integer to search in ABV
  def index
    @beer = Beer.new unless @beer.present?
    @beers = @beer.get_beers(beer_params.to_h)

    render json: {
        hello: @current_user.name
    }
  end

  def beer_params
    params.permit(:page, :id, :name, :tagline, :description, :abv)
  end
end
