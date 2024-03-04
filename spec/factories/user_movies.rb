# spec/factories/user_movies.rb

FactoryBot.define do
    factory :user_movie do
        user_id { FactoryBot.create(:user).id }
        movie_id { FactoryBot.create(:movie).id }
        score { Faker::Number.between(from: 1, to: 10) }
        created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
        updated_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    end
  end
  