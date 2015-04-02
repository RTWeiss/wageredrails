require 'rails_helper'

RSpec.describe Game do
  let(:valid_attributes) {
    { date: Date.now,
      time: "757 pm",
      home_team: "Bulldogs",
      away_team: "wildcats",
    }
  }
  context "When attributes are valid" do
    subject(:game) { Game.create(valid_attributes) }

    it "creates the game" do
      expect(user).to be_persisted
    end

    it { expect(game).to have_many(:bets) }
    it { expect(game).to validate_presence_of(:home_team) }
    it { expect(game).to validate_presence_of(:away_team) }
  end
end

