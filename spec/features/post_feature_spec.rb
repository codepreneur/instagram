require 'rails_helper'

describe "Posts" do
	
	context "no posts" do
		it "should have no posts when initialized" do
			visit '/posts'
			expect(page).to have_content 'No posts yet'
		end
	end

	context "has posts" do

		before {Post.create title: 'Cool post', description: 'Hello world'}
		it "displays posts" do
			visit '/posts'
			expect(page).to have_content "Cool post"
			expect(page).to have_content 'Hello world'
		end

	end


end


describe "adding posts" do

	it "can add a post" do
		visit '/posts/new'
		fill_in 'Title', with: 'Cool post'
		fill_in 'Description', with: 'This is cool description'
		click_button "Post it!"
		expect(current_path).to eq '/posts'
		expect(page).to have_content 'Cool post'
		expect(page).to have_content 'This is cool description'
	end	

end





