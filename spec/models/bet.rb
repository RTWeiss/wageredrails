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

  context "when bet values are valid" do
    subject(:bet) { Bet.create(bet_attributes) }
    it "creates bet" do
      expect(bet).to be_persisted
    end

    it "the default value for status sets automatically" do
      expect(bet.status).to eq("pending")
    end
  end
end
