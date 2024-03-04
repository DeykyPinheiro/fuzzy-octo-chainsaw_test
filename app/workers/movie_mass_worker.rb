class MovieMassWorker
    include Sidekiq::Worker
  
    def perform(title, director)
      Movie.create(title: title, director: director)
    end
  end
  