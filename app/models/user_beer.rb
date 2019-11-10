class UserBeer < ApplicationRecord
  belongs_to :user
  belongs_to :beer

  def get_favs(user)
    @user = user
    res = UserBeer.where(user: @user, favorite: true).map do |beer|
      read_beer(beer)
    end
    res
  end

  def toggle_fav(beer_id, user)
    @user = user
    user_beer = UserBeer.where(beer_id: beer_id, user: @user).first
    return nil unless user_beer.present?

    user_beer.favorite = !user_beer.favorite
    user_beer.save
    [read_beer(user_beer)]
  end

  def beer_favorite?(beer_id, user)
  end

  def read_beer(user_beer)
    Beer.find(user_beer.beer.id).attributes.merge!(
      favorite: user_beer.favorite,
      seen_at: user_beer.seen_at.localtime.strftime('%Y-%m-%d %H:%M:%S')
    )
  end

  def read_beers(user_beers)
    user_beers.map { |user_beer| read_beer(user_beer) }
  end

end
