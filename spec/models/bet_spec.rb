require 'rails_helper'

RSpec.describe Bet do
  let(:bet_attributes) {
    { amount: 10,
      game_id: 1,
      points: 5,
      team: "Arizona",
      initiating_user_id: 1,
      receiving_user_id: 2
    }
  }

  context "when all bet values are valid" do
    subject(:bet) { Bet.create(bet_attributes) }
    it "creates bet" do
      expect(bet).to be_persisted
    end

    it "sets default value for status automatically" do
      expect(bet.status).to eq("pending")
    end

    it "#receiving_user_points returns the receiving users points" do
      expect(bet.receiving_user_points).to eq(-5)
    end

    it { should belong_to(:initiating_user) }
    it { should belong_to(:receiving_user) }
    it { should belong_to(:game) }
  end
end
