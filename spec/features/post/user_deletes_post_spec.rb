require 'rails_helper'

feature "user deletes a post" do 

  before(:each) do 
    @bob = FactoryBot.create(:user, :with_example_profile, name: "bob", email: "bob@example.com")
    @post = @bob.posts.last
    @post_image_filename = @post.picture.filename.to_s

    sign_in @bob
    visit root_path 
    click_on "bob"

    delete_post(@post)
  end
  
  scenario "the post no longer exists" do 
    expect(page).not_to have_content(@post.body)
  end

  scenario "they see a flash message" do 
    expect(page).to have_content("Post successfully destroyed")
  end

end