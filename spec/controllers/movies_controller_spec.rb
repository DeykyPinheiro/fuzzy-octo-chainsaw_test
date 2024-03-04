require 'rails_helper'

# rspec spec/controllers/movies_controller_spec.rb
RSpec.describe MoviesController, type: :controller do
  render_views
  let(:user) { create(:user) }
  let(:valid_attributes) { { title: 'Test Movie', director: 'Test Director' } }
  let(:invalid_attributes) { { title: '', director: '' } }

  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "GET #index" do
    it "assigns all movies as @movies" do
      movie = Movie.create!(valid_attributes)
      get :index
      expect(assigns(:movies)).to eq([movie])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    context "when format is JSON" do
      it "returns a JSON response with movies including average_score" do
        movie = Movie.create!(valid_attributes)
        get :index, format: :json
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to be_an_instance_of(Array)
        expect(parsed_response.first).to include(
          "id" => movie.id,
          "title" => movie.title,
          "director" => movie.director,
          "average_score" => movie.average_score,
        )
      end
    end
  end

  describe "GET #new" do
    it "assigns a new movie as @movie" do
      get :new
      expect(assigns(:movie)).to be_a_new(Movie)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Movie" do
        expect {
          post :create, params: { movie: valid_attributes }
        }.to change(Movie, :count).by(1)
      end

      it "redirects to the movies list" do
        post :create, params: { movie: valid_attributes }
        expect(response).to redirect_to(movies_path)
      end
    end
  end

end
