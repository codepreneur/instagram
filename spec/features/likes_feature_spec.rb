require 'rails_helper'

describe 'liking posts' do
	before do 
		alex = User.create(email: 'alex@example.com', password: '12345678', password_confirmation: '12345678')
		alex.posts.create title: 'Cool post', description: 'Hello world'
	end

  it 'is initially at 0 likes' do
    visit '/posts'
    expect(page).to have_content '♥ 0'
  end

  it 'increments the like count of a post', js: true do
    visit '/posts'
    click_link '♥ 0'
    # sleep 2
    expect(page).to have_content '♥ 1'
  end

  it 'can only be liked once per user', js: true do
  	
    visit '/posts'
    click_link '♥ 0'
    click_link '♥ 1'
    expect(page).to have_link '♥ 1'
  end

end