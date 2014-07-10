class MoviesController < ApplicationController

  def home
  
  end

  def results
    #search method
    search_str = params[:movie]
    response = Typhoeus.get("http://www.omdbapi.com/", :params => {:s => search_str})
    omdbdata = JSON.parse(response.body)
    @movies = omdbdata["Search"]
  end

  def show
    imdb_id = params[:imdbID]
    info = Typhoeus.get("http://www.omdbapi.com/", :params => {:i => imdb_id})
    @infodata = JSON.parse(info.body)
    @link = @infodata["imdbID"]
    @title = @infodata["Title"]

    # @movie = Movie.find_or_create_by(imdbID: @link, title: @title)
     
    response = Typhoeus.get("https://api.themoviedb.org/3/movie/#{@link}?api_key=#{ENV['MOVIE_KEY']}")
    trailerid = JSON.parse(response.body)
    @called = trailerid["id"]
    var = Typhoeus.get("https://api.themoviedb.org/3/movie/#{@called}/videos?api_key=#{ENV['MOVIE_KEY']}")
    var2 = JSON.parse(var.body)
    @var3 = var2["results"][0]["key"]
    # preparing @favorite for the form
    # @favorite = Favorite.find_by_movie_id(@movie) || Favorite.new
  end

end
