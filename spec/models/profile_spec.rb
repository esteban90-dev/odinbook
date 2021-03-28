require 'rails_helper'

describe Profile do 

  context "uniqueness validation" do 

    #note - location validation is tested by the feature spec

    it "isn't valid without a relationship status" do
      bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      profile = bob.build_profile(location: "new york", relationship_status: "", education: "college")

      expect(profile.valid?).to eq(false)
    end

    it "isn't valid without an education" do
      bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      profile = bob.build_profile(location: "new york", relationship_status: "married", education: "")

      expect(profile.valid?).to eq(false)
    end

  end

end