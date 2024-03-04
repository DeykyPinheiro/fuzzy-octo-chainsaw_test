FactoryBot.define do
  factory :movie do
    title { "nome teste" }
    transient do
      score { 10 }
    end
    after(:create) do |movie, evaluator|
      create(:user_movie, movie: movie, score: evaluator.score)
    end
  end
end
