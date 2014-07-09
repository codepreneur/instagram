require 'rails_helper'

describe "tagging posts" do
	
	context "when logged in" do

		before do
			alex = User.create(email: 'alex@example.com', password: '12345678', password_confirmation: '12345678')
			login_as alex
		end

		it "can add a post" do
			visit '/posts/new'
			fill_in 'Title', with: 'Cool post'
			fill_in 'Description', with: 'This is cool description'
			fill_in 'Tags', with: '#yolo, #swag'
			click_button "Post it!"

			expect(page).to have_link '#yolo'
			expect(page).to have_link '#swag'
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

end