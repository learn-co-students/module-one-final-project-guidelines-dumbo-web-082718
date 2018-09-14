# MovieQueueApp™

The MovieQueueApp™ will let you keep track of the movies you want to watch! A user can...

1) Add movies to their queue
2) Remove movies from their queue
3) Randomly select a movie from their queue
4) View movies in queue by genre or
5) View all movies that are in the database

The app works with The Movie db API. If you want to use the API, following instruction for Seeding the Database.
If you want to populate the database with your own data, add movies through the CLI.

### Getting Started 

1) Fork and clone the repository
2) bundle install
3) run ```rake db:migrate``` 
4) run the file - bin/run.rb

### Running the App

```ruby bin/run.rb```

#### Seeding the Database

Get your API key [here](https://www.themoviedb.org/account)

Go to the seed.rb inside of the db folder.

```movie = Tmdb::Search.movie('movie_name')```

replace movie_name with movie topic of choice to add movies from The Movie Db API to the database.
