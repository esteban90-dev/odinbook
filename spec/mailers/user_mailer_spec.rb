require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  describe "welcome_email" do
    before(:each) do 
      bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      @mail = UserMailer.welcome_email(bob)
    end

    it "sends an email to the user's email address" do
      expect(@mail.to).to eq(["bob@example.com"])
    end

    it "sends with the correct subject" do 
      expect(@mail.subject).to eq('Welcome to Odinbook')
    end

    it "greets the user by name" do 
      expect(@mail.body).to match(/Welcome to Odinbook, bob/)
    end
  end

end
