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
		end
	end

end