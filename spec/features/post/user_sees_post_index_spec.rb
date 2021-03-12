require 'rails_helper'

feature "user sees post index" do 

  before(:each) do 
    @stephen = FactoryBot.create(:user, name: "stephen", email: "stephen@example.com")
    @sean = FactoryBot.create(:user, name: "sean", email: "sean@example.com")
    @kevin = FactoryBot.create(:user, name: "kevin", email: "kevin@example.com") 

    @stephen.friends << @sean

    @post_1 = @stephen.posts.create(body: "this is the first post")
    @post_2 = @sean.posts.create(body: "this is the second post")
    @post_3 = @kevin.posts.create(body: "this is the third post")

    sign_in @stephen
    visit posts_path
  end

  scenario "they see posts belonging to themselves and friends" do
    expect(page).to have_css(".post##{@post_1.id}", text: @post_1.body)
    expect(page).to have_css(".post##{@post_2.id}", text: @post_2.body)
  end

  scenario "they see each post's author's name" do 
    within(".post##{@post_1.id}")do 
      expect(page).to have_content(@post_1.user.name)
    end
  end

  scenario "they don't see posts belonging to users that aren't friends" do 
    expect(page).not_to have_css(".post##{@post_3.id}", text: @post_3.body)
  end

  scenario "they only see up to 15 posts" do 
    20.times do 
      @stephen.posts.create(body: "another post")
    end

    visit posts_path

    expect(page.all('.post').count).to eq(15)
  end

  scenario "the posts are in order of most recent first" do 
    expect(page.body.index(@post_2.body) < page.body.index(@post_1.body)).to eq(true)
  end

  scenario "they see each post's author's name" do 
    within(".post##{@post_1.id}")do 
      expect(page).to have_content(@post_1.user.name)
    end
  end

end