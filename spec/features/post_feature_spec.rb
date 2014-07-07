require 'rails_helper'

describe "Posts" do
	
	context "no posts" do

		before do
		  user = User.create email: 'tansaku@gmail.com', password: '12345678', password_confirmation: '12345678'
		  login_as user
		end

		it "should have no posts when initialized" do
			visit '/posts'
			expect(page).to have_content 'No posts yet'
			expect(page).to have_link 'New post'
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


describe "creating posts" do

	context "logged in" do

	

		it "can add a post" do
			visit '/posts/new'
			fill_in 'Title', with: 'Cool post'
			fill_in 'Description', with: 'This is cool description'
			click_button "Post it!"
			expect(current_path).to eq '/posts'
			expect(page).to have_content 'Cool post'
			expect(page).to have_content 'This is cool description'
			expect(page).not_to have_css 'img.uploaded-pic'
		end	

		it "can upload the photo" do
			visit '/posts/new'
			fill_in 'Title', with: 'Cool post'
			fill_in 'Description', with: 'This is cool description'
			attach_file 'Image', Rails.root.join('spec/images/cat.jpg')

			click_button "Post it!"
			expect(current_path).to eq posts_path
			expect(page).to have_content 'Cool post'
			expect(page).to have_content 'This is cool description'
			expect(page).to have_css 'img.uploaded-pic'
		end	

	end


	# context "logged out" do

	# 	it "can add a post" do
	# 		visit '/posts/new'

	# 	end	

	# 	it "can upload the photo" do
	# 		visit '/posts/new'

	# 	end	

	# end

end





