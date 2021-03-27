require 'rails_helper'

feature "user sees post index" do 

  before(:each) do 
    @stephen = FactoryBot.create(:user, :with_profile, name: "stephen", email: "stephen@example.com")
    @sean = FactoryBot.create(:user, :with_profile, name: "sean", email: "sean@example.com")
    @kevin = FactoryBot.create(:user, :with_profile, name: "kevin", email: "kevin@example.com") 

    @stephen.friends << @sean

    @post_1 = @stephen.posts.create(body: "this is the first post")
    @post_2 = @sean.posts.create(body: "this is the second post")
    @post_3 = @kevin.posts.create(body: "this is the third post")

    sign_in @stephen
    visit posts_path
  end

  scenario "they see posts belonging to themselves and friends" do
    expect(page).to have_content(@post_1.body)
    expect(page).to have_content(@post_2.body)
  end

  scenario "they don't see an edit link next to a friend's posts" do 
    post_doesnt_appear_editable(@post_2)
  end

  scenario "they don't see a delete link next to a friend's posts" do 
    post_doesnt_appear_deletable(@post_2)
  end

  scenario "they see each post's author's name" do 
    expect(page).to have_post_author_name(@post_1)
    expect(page).to have_post_author_name(@post_2)
  end

  scenario "they don't see posts belonging to users that aren't friends" do 
    expect(page).not_to have_content(@post_3.body)
  end

  scenario "they only see up to 15 posts" do 
    20.times do 
      @stephen.posts.create(body: "another post")
    end

    visit posts_path

    expect(posts_on_page.count).to eq(15)
  end

  scenario "the posts are in order of most recent first" do 
    expect(page.body.index(@post_2.body) < page.body.index(@post_1.body)).to eq(true)
    user_sees_content_order_descending(@post_1.body, @post_2.body)
  end

end