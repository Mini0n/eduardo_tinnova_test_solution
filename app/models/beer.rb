class Beer < ApplicationRecord

  # 25 beers or less by page.
  #
  # @param: page [int] - beers list page
  # @param: id [int] - beer id
  # @param: name [string] - string to search in name
  # @param: abv [int] - integer to search in ABV
  def get_beers(params)
    byebug
    # get_beers_by_page()
    @beers = get_beers_by_page(1) if params.empty?
    @beers = get_beers_by_page(params['page']) if params['page'].present?



  end

  # Gets all stored beers (Model Beer)
  def get_all_beers
  end

  def get_beers_by_page(page)
    byebug

  end



end
