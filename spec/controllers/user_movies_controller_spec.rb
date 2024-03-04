require 'rails_helper'

# rspec spec/controllers/user_movies_controller_spec.rb
RSpec.describe UserMoviesController, type: :controller do
  render_views
  describe "POST #create" do
    let(:user) { create(:user) }
    let(:movie) { create(:movie) }

    before do
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)
    end

    it "adds a movie to the user's list and redirects to movies_path" do
      post :create, params: { user_movie: { movie_id: movie.id, score: 5 } }
      expect(response).to redirect_to(movies_path)
      expect(user.movies).to include(movie)
    end
  end

  describe "POST #mass_rates" do
    let(:user) { create(:user) }

    before do
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
    end

    context "with no file uploaded" do
      it "displays flash error and redirects to movies_path" do
        post :mass_rates, params: { file: nil }
        expect(flash[:error]).to be_present
        expect(response).to redirect_to(movies_path)
      end
    end
  end
end
