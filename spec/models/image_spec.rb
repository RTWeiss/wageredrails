require 'rails_helper'

RSpec.describe Image do
  let(:valid_attributes) { 
    { source: "zibbidydodah.jpg",
      user_id: 1 
    }
  }
  context "when image file extension is not valid" do
    subject(:image) { Image.create(valid_attributes) }

    it "does not create the image" do
      expect(image).to_not be_valid
    end

    it { should belong_to(:user) }
  end
end