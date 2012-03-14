class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.get_ratings
    session[:field] = params[:field] if params[:field]
    session[:ratings] = params[:ratings] if params[:ratings]
    @field = session[:field] || ''
    ratings = session[:ratings].respond_to?('keys') ? session[:ratings].keys : session[:ratings]
    @ratings = session[:ratings] ? ratings : @all_ratings

    @movies = Movie.where(:rating => @ratings).order(@field)
    redirect_to movies_path(:ratings => @ratings, :field => @field) unless (params[:field] || params[:ratings])
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
