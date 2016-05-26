class Admin::MoviesController < Admin::ApplicationController
  def index
    search = false
    if params[:title] || params[:director] || params[:runtime_in_minutes]
      search = true
      @movies = Movie.single_search(params[:query])
      if params[:runtime_in_minutes] && @movies.empty?
          case params[:runtime_in_minutes]
          when "1"
            @movies = (Movie.runtime_search_less(90))
          when "2"
            @movies = Movie.runtime_search_between(90, 120)
          when "3"
            @movies = Movie.runtime_search_greater(120)
          end
      end
    end
    if !search
      @movies = Movie.all
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params) #if the update is successful
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected


  def movie_params
    params.require(:movie).permit(:title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description)
  end
end
