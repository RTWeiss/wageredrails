require 'rails_helper'

RSpec.describe Team do
  let(:valid_team_attributes) {
    { name: "49ers",
      logo_url: "urlwherelogois.com"
    }
  }

  context "when all team attributes are valid" do
    subject(:team) { Team.create(valid_team_attributes) }

    it "creates team" do
      expect(team).to be_persisted
    end

    it { should have_many(:home_games) }
    it { should have_many(:away_games) }
    it { should have_many(:bets) }
  end 
end
