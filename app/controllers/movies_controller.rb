class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end


  def index
    sort = params[:sort] || session[:sort]
    @all_ratings = Movie.ratings.keys
    @selected_ratings = params[:ratings] || session[:ratings] || Movie.ratings
    sort_by, @title_header = {:order => :title}, 'hilite'if sort == 'title' 
    sort_by, @release_date_header = {:order => :release_date}, 'hilite' if sort == 'release_date'
    session[:sort] = sort if params[:sort] != session[:sort]  
    session[:ratings] = @selected_ratings if params[:ratings] != session[:ratings] and !@selected_ratings.empty?  
    @movies = Movie.find_all_by_rating(@selected_ratings.keys, sort_by)
  end


  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
