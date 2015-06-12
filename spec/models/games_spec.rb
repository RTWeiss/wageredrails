require 'rails_helper'

RSpec.describe Game do
  let(:game_attributes) {
    { date: Date.new(2017,4,5),
      time: "757 pm",
      home_team_id: 1,
      away_team_id: 2
    }
  }
  context "When attributes are valid:" do
    subject(:game) { Game.create(game_attributes) }

    it "creates the game" do
      expect(game).to be_persisted
    end

    it { expect(game).to have_many(:bets) }
    it { should belong_to(:home_team) }
    it { should belong_to(:away_team) }
  end
end
