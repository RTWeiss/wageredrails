require 'rails_helper'

RSpec.describe Bet do
  let(:valid_bet_attributes) {
    { amount: 10,
      game_id: 1,
      points: 5,
      team_id: 1,
      initiating_user_id: 1,
      receiving_user_id: 2
    }
  }

  context "when all bet values are valid" do
    subject(:bet) { Bet.create(valid_bet_attributes) }
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
  
  context "post game calculations" do
    before do
      @game = Game.create(
        date: 3.days.from_now, 
        time: "757", 
        home_team_id: 900, 
        away_team_id: 400, 
        home_final_score: 55, 
        away_final_score: 63, 
        margin: 8)
      @bet = Bet.create(
        game_id: @game.id,
        team_id: 900,
        points: 5,
        initiating_user_id: 1,
        receiving_user_id: 2,
        amount: 10
        )
    end

    describe "#initiators_team_score" do
      it "returns score of initiators team" do
        expect(@bet.initiators_team_score).to eq(55)
      end
    end

    describe "#receivers_team" do
      it "returns the receiving users team" do
        expect(@bet.receivers_team).to eq(@game.away_team)
      end
    end

    describe "#team_score_of_receiver" do
      it "returns score of receiver user's team" do
        expect(@bet.team_score_of_receiver).to eq(63)
      end
    end

    describe "#initiator_adjusted_score" do
      it "returns score added to point spread" do
        expect(@bet.initiator_adjusted_score).to eq(60)
      end
    end

    describe "#winner_of_bet" do
      it "returns user who won bet" do
        expect(@bet.winner_of_bet).to eq(@bet.receiving_user)
      end
    end
  end

end
