# MovieQueueApp™

The MovieQueueApp™ will let you keep track of the movies you want to watch! A user can...

1) Add movies to their queue
2) Remove movies from their queue
3) Randomly select a movie from their queue
4) View movies in queue by genre or
5) View all movies that are in the database

### Getting Started 

1) Fork and clone the repository
2) bundle install
3) run the file - bin/run.rb

### Running the App

```ruby bin/run.rb```

#### Seeding the Database

Go to the seed.rb inside of the db folder.

```movie = Tmdb::Search.movie('movie_name')```

replace movie_name with movie topic of choice to add movies from The Movie Db API to the database.
