require 'rails_helper'

describe Notification, ".unacked" do

  it "returns a list of unacknowledged notifications" do 
    notification_1 = Notification.create(message: "new notification")
    notification_2 = Notification.create(message: "new notification")
    notification_2.touch

    expect(Notification.unacked).to include(notification_1)
    expect(Notification.unacked).not_to include(notification_2)
  end

end

describe Notification, "#unacked?" do 

  before do
    @notification = Notification.create(message: "new notification")
  end

  it "returns true if the created_at time matches the updated_at time" do 
    expect(@notification.unacked?).to eq(true)
  end

  it "returns false if the created_at time matches the updated_at time" do 
    @notification.touch

    expect(@notification.unacked?).to eq(false)
  end

end 
