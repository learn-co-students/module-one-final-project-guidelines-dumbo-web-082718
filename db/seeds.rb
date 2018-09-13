require_relative '../config/environment'


@genre_list_cache = nil
def get_genre_list
 if @genre_list_cache.nil?
   @genre_list_cache = Tmdb::Genre.movie_list
 end
 @genre_list_cache
end




# character_data = RestClient.get('https://api.themoviedb.org/3/movie/popular?api_key=0daab27198c8748989487d142cf08103')

# jsonparsero = JSON.parse(character_data)
# puts movies = jsonparsero["results"]




Tmdb::Api.key("0daab27198c8748989487d142cf08103")
Tmdb::Api.language("en")



# puts Tmdb::Genre.movie_list




movie = Tmdb::Search.movie('Batman')
movies = movie.results

#
#
title = movies.map { |movie| movie.title }

# puts title

release_year = movies.map { |movie| movie.release_date.to_i }
# puts release_year

# puts movies



# puts Tmdb::Genre.movie_list


def genre_id_to_name(id)
 genre = get_genre_list.find{|genre| genre.id == id}
 if genre.nil?
   nil
 else
   return genre.name
 end
end

genre_id_to_name(27)

genre_ids = movies.map { |movie| movie.genre_ids.first }
genre_flatten = genre_ids.flatten
genres_name = genre_flatten.map { |id| genre_id_to_name(id)}
# puts genres_name

(0...20).each do |n|
Movie.find_or_create_by(title: title[n]) do |movie|
movie.genre = genres_name[n]
movie.release_year = release_year[n]
end
end
