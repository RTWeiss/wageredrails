require 'rails_helper'

RSpec.describe Comment do
  let(:valid_attributes) {
    { user_id: 1, 
      bet_id: 2,
      content: "Dumb bet virginia is going to win!"
    }
  }

  context "with valid attributes" do
    subject(:comment) { Comment.create(valid_attributes) }

    it "creates the comment" do
      expect(comment).to be_persisted
    end

    it { should belong_to(:user) }
    it { should belong_to(:bet) }
    it { expect(comment).to ensure_length_of(:content).is_at_least(4).is_at_most(300) }
  end

  context "comment validations" do

    it "validates length of content" do 
      comment = Comment.create(user_id: 1, bet_id: 2, content: "asd")
      expect(comment.errors).to have_key(:content)
    end

    it "does not allow an empty value for user_id" do
      comment = Comment.create(user_id: "", bet_id: 2, content: "hibbbbidy zibbbidy")
      expect(comment).to_not be_persisted
    end

  end
end