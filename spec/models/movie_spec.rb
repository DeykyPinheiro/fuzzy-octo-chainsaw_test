require 'rails_helper'

# rspec spec/models/movie_spec.rb
RSpec.describe Movie, type: :model do
  describe "associations" do
    it { should have_many(:user_movies) }
    it { should have_many(:users).through(:user_movies) }
  end

  describe "#average_score" do
    let(:movie) { create(:movie) }

    context "when there are user_movies with scores" do
      before do
        create(:user_movie, movie: movie, score: 10)
        create(:user_movie, movie: movie, score: 10)
      end

      it "calculates the average score" do
        expect(movie.average_score).to eq(10)
      end
    end
  end
end
