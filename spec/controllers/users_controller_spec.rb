require 'rails_helper'

# rspec spec/controllers/users_controller_spec.rb
RSpec.describe UsersController, type: :controller do
  render_views
  describe "GET #new" do
    it "assigns a new user to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_params) do
        {
          user: {
            username: "testuser",
            email: "test@example.com",
            password: "password",
            password_confirmation: "password"
          }
        }
      end

      it "creates a new user" do
        expect {
          post :create, params: valid_params
        }.to change(User, :count).by(1)
      end

      it "sets the session user_id" do
        post :create, params: valid_params
        expect(session[:user_id]).to eq(User.last.id)
      end

      it "redirects to movies_path" do
        post :create, params: valid_params
        expect(response).to redirect_to(movies_path)
      end
    end

    context "with invalid params" do
      let(:invalid_params) do
        {
          user: {
            username: "",
            email: "invalid_email",
            password: "password",
            password_confirmation: "different_password"
          }
        }
      end

      it "does not create a new user" do
        expect {
          post :create, params: invalid_params
        }.not_to change(User, :count)
      end

      it "renders the new template" do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end
end
