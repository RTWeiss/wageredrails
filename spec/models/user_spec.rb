require 'rails_helper'

RSpec.describe User do
  let(:valid_attributes) {
    { email: "mrexample@example.com",
      username: "mrexample",
      name: "Benjamin",
      admin: false, 
      password: "validpassword" 
    }
  }

  context "when all user attributes are valid" do
    subject(:user) { User.create(valid_attributes) }

    it "creates the user" do
      expect(user).to be_persisted
    end

    it { expect(user).to have_many(:initiated_bets) }
    it { expect(user).to have_many(:received_bets) }
    it { expect(user).to have_many(:comments) }
    it { expect(user).to have_one(:image) }
  end

  describe "Validations" do
    it "validates presence of email" do
      user = User.create(email: "", username: "howdydodah", name: "ben", password: "validpassword")
      expect(user.errors).to have_key(:email)
    end

    it "validates format of email" do 
      user = User.create(email: "blaaahity", username: "example", name: "ben", password: "password22oi")
      expect(user).to_not allow_value("blaaahity").for(:email) 
    end

    it "does not allow emails with special characters" do
      user = User.create(email: "hiphop@email.com!", username: "example", name: "ben", password: "password220i")
      expect(user).to_not allow_value("hiphop@email.com!").for(:email) 
    end

    it "validates uniqueness of email" do 
      user_2 = User.create(email: "mrexample@example.com", username: "hoddydodah", name: "ben", password: "password220i")
      expect(user_2).to validate_uniqueness_of(:email)
    end
    
    it "validates presence of username" do 
      user = User.create(email: "", username: "molinethedream", name: "ben", password: "validpassword")
      expect(user.errors).to have_key(:email)
    end

    it "ensures minimum password length" do
      user = User.create(email: "molinethedream@example.com", username: "50 cent", name: "alex", password: "bo")
      expect(user).to ensure_length_of(:password).is_at_least(8)
    end
  end
end