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