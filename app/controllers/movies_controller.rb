class MoviesController < ApplicationController
  def index
    @movies = []
    binding.pry
    if params[:title] || params[:director] || params[:runtime_in_minutes]
      movie = Movie.find_by(title: params[:title]) if (params[:title])
      @movies << movie if movie && !(movie.empty?)
      movie = Movie.find_by(director: params[:director])
      @movies << movie if movie && !(movie.empty?)
      if params[:runtime_in_minutes]
        binding.pry
        case params[:runtime_in_minutes]
        when "1"
          movie = Movie.where("runtime_in_minutes < 90")
          @movies << movie if movie && !(movie.empty?)
        when "2"
          movie = Movie.where("runtime_in_minutes >= 90 AND runtime_in_minutes <= 120")
          @movies << movie if movie && !(movie.empty?)
          binding.pry
        when "3"
          movie = Movie.where("runtime_in_minutes >= 120")
          @movies << movie if movie && !(movie.empty?)
        end
      end
    else
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
