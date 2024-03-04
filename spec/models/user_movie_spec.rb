require 'rails_helper'

# rspec spec/models/user_movie_spec.rb
RSpec.describe UserMovie, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:movie) }
  end
end