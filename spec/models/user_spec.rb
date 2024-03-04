require 'rails_helper'


# rspec spec/models/user_spec.rb
RSpec.describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  context 'associations' do
    it { should have_many(:user_movies) }
    it { should have_many(:movies).through(:user_movies) }
  end

  context 'password encryption' do
    let(:user) { create(:user, password: 'password123') }

    it 'encrypts the password' do
      expect(user.password_digest).not_to eq('password123')
    end
  end
end
