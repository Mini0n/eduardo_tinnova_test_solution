Ready to go :)

# Routes: 
```
  post 'auth/login', to: 'authentication#login'

  get 'beers/all', to: 'beers#get_all'
  get 'beers/favs', to: 'beers#get_favs'
  get 'beers/:id/fav', to: 'beers#toggle_fav'

  resources :beers
```

# Testing
Just run rspec in the proyect folder
```
 rspec
```
# Screeshots

| Screenshot                                   | Description                                     |
|----------------------------------------------|-------------------------------------------------|
| [POST Auth](https://ibb.co/DbzKXvH)          | sings in, gets auth token                       |
| [GET beers](https://ibb.co/vzyX2S1)          | gets 1st page from punkapi                      |
| [GET beers/:id](https://ibb.co/yN3VKTp)      | gets beer w/ id=:id from punkapi                |
| [GET beers?name=sth](https://ibb.co/8DCMsz5) | gets beers w/ name=sth from punkapi             |
| [GET beers?abv=num](https://ibb.co/fM0Qk3k)  | gets beers w/ abv=num from punkapi (res 0.1)    |
| [GET beers?page=num](https://ibb.co/rvy4n0P) | gets beers in page=num from punkapi             |
| [GET beetrs/favs](https://ibb.co/k11zsWV)    | gets fav beers for current user                 |
| [GET beers/:id/fav](https://ibb.co/qdLqwpf)  | toggles favorite for beer w/ id=:id in punkapi  |
| [GET beetrs/favs](https://ibb.co/V9th0pm)    | gets fav beers for current user                 |
| [GET beers/:id/fav](https://ibb.co/ZYP1MzY)  | toggles favorite for beer w/ id=:id in punkapi  |
| [GET beetrs/favs](https://ibb.co/XVb6zmp)    | gets fav beers for current user                 |
| [GET beers/all](https://ibb.co/GvSB70m)      | gets all stored beers                           |


----------------


# Tinnova Api Test

Welcome!

In this test, you will have to prove your full stack skills' worth, by building an API which has to meet certain criteria.

Read carefully the instructions, as they contain all the details regarding this evaluation.

We've already started a project for you, so it's easier to work with.

* Ruby version
  2.6.0

* Rails version
  5.2

### Authentication
The user authentication is already managed with JWT. For every request regarding beers, you'll need to attach the token generated with the `login` method as a header. The controller already contains an instance variable called `@current_user` which is an `User` object extracted from Database.

For you to login, you need to make a **POST** request to the route `/auth/login`, with the json:
```
user: {
  username: 'username',
  password: 'password'
}
```

The JSON response will contain a token, which you will use to authenticate the user on every request.

The authentication header **MUST** be in the format:
```
Authorization: Bearer {token}
```
In any other case, the application will throw an error.

The project's seeds already come with an `admin` user for creation, but feel free to add any user's you'd like.

## Your challenge

Your challenge will be to build a small beer-centered API through Ruby on Rails. The first information set will be taken from an open API, found (here)[https://punkapi.com/documentation/v2].

The (Punk API)[https://punkapi.com/documentation/v2] is a beer API list, which responds with JSON, and contains relevant beer information.

The user, must be able to get all beers, showing only relevant information:

* id
* name
* tagline
* description
* abv

Of course, the user should be able to filter by `name` or by `abv`.

When a user has seen a beer (shown/processed by the API), it **MUST** be saved in a `Beers` table, with the `date` and `time` the user saw it. When showing the beer list, the field `seen_at` should contain the information.

You have to generate the `Beers` model & migration.

Keep in mind that as a user, I don't want to know when other users have seen a beer. If I haven't seen it and others have, I wouldn't know.

After I've seen quite a list of beers, I, as a user, would like to save one as my favorite.

Create an endpoint that will save the beer as my favorite. By creating the endpoint, you need to create the route, migration and model.

I also want to be able to retrieve my favorite beer. So, create an endpoint to `get` it.

My favorite beer should be seen in the `get all` beers endpoint, with the property `favorite: true`.

Place all endpoint operations inside the `beer` controller.

Again, keep in mind, that I do **NOT** want to know anyone else's favorite beer, only mine.

All responses **MUST** be in `JSON` format, and will be tested with Postman.

You have 24 hours to finish this task. Good luck, and may the force be with you.

If you come up with **ANY** doubts, do **NOT** hesitate to ask, as you have limited time to finish. As soon as you don't understand somethig, please just ask.

## Extra Credit

Install RSpec and use it to write out tests for your application. Write as many as you consider appropiate.

### HTTP Requests

A `gem` called `faraday` comes already installed with the project. But feel free to use any HTTP client.

The documentation for `faraday` can [be found here](https://github.com/lostisland/faraday).

## Setup

For this to work you need to install PostgreSQL database in your computer and start a server.

You'll need Ruby v2.6.0 and Rails v5.2.

Clone the project, and create your branch. Use any name you'd like. We recommend you using something like `{name}_test_solution`.

Install dependencies:
```
bundle install
```

Create database and migrate the changes:
```
rake db:create
rake db:migrate
```

Seed the `User` data to the database:
```
rake db:seed
```

Run the projects
```
rails s
```
