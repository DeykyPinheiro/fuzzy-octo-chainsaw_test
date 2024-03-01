class UserMoviesController < ApplicationController
  before_action :authenticate_user!
  
  require 'csv'

  def create
    @movie = Movie.find(params[:user_movie][:movie_id])
    current_user.movies << @movie
    @user_movie = current_user.user_movies.find_by(movie_id: @movie.id)
    @user_movie.update(score: params[:user_movie][:score])
    redirect_to movies_path
  end

  def update
    @user_movie = current_user.user_movies.find_by(movie_id: params[:user_movie][:movie_id])
    @user_movie.update(score: params[:user_movie][:score])
    redirect_to movies_path
  end

  def mass_rates
    uploaded_file = params[:file]
   
    if uploaded_file.nil?
      flash[:error] = "Por favor, selecione um arquivo CSV com as notas."
      redirect_to movies_path
      return
    end
   
    begin
      CSV.foreach(uploaded_file.path, headers: true) do |row|
        movie_id = row['movie_id']
        score = row['score']
  
        user_movie = current_user.user_movies.find_or_initialize_by(movie_id: movie_id)
        user_movie.update(score: score)
      end
  
      redirect_to movies_path
    rescue StandardError => e
      flash[:error] = "Ocorreu um erro ao processar o arquivo CSV: #{e.message}"
      redirect_to movies_path
    end
  end
  
  
  
end
