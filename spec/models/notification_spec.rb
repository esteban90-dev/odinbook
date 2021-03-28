require 'rails_helper'

describe Notification, ".unacked" do

  it "returns a list of unacknowledged notifications" do 
    bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    notification_1 = bob.notifications.create(message: "new notification")
    notification_2 = bob.notifications.create(message: "new notification")
  
    notification_2.touch

    expect(Notification.unacked).to include(notification_1)
    expect(Notification.unacked).not_to include(notification_2)
  end

end

describe Notification, "#unacked?" do 

  before do
    bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
    
    @notification = bob.notifications.create(message: "new notification")
  end

  it "returns true if the created_at time matches the updated_at time" do 
    expect(@notification.unacked?).to eq(true)
  end

  it "returns false if the created_at time matches the updated_at time" do 
    @notification.touch

    expect(@notification.unacked?).to eq(false)
  end

end 

describe Notification do 

  context "validations" do 

    it "isn't valid without a message" do 
      bob = FactoryBot.create(:user, name: "bob", email: "bob@example.com")
      notification = bob.notifications.new(message: "")

      expect(notification.valid?).to be(false)
    end

  end

end
