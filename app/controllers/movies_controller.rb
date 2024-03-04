class MoviesController < ApplicationController
  require 'csv'

  
  before_action :authenticate_user!


  def index
    @movies = Movie.all
    respond_to do |format|
      format.html
      format.json { render json: @movies.to_json(methods: :average_score) }
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "Movie was successfully created."
    else
      render :new
    end
  end

  def mass_movies
    uploaded_file = params[:file]

    if uploaded_file.nil?
      flash[:error] = "Por favor, selecione um arquivo CSV."
      redirect_to root_url
      return
    end

    begin
      CSV.foreach(uploaded_file.path, headers: true) do |row|
        MovieMassWorker.perform_async(row['title'], row['director'])
      end
      flash[:success] = "Filmes importados com sucesso."
      MovieMassWorker.perform_async
    rescue => e
      flash[:error] = "Ocorreu um erro ao importar os filmes: #{e.message}"
    end

    redirect_to movies_path
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :director)
  end
end
