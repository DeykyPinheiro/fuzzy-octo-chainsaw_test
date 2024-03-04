class RateMassWorker
    include Sidekiq::Worker
  
    def perform(user_id, movie_id, score)
    puts 'terminei a fila de importacao de filme'

    user_movies = UserMovie.find_by(user_id: user_id, movie_id: movie_id)
    if user_movies
      user_movies.update(score: score)
      puts "Score atualizado com sucesso para o usuário #{user_id} e o filme #{movie_id}"
    else
      UserMovie.create(user_id: user_id, movie_id: movie_id, score: score)
    end
  end
end
  