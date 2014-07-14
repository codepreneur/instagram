require 'rails_helper'

describe 'orders page' do

  let(:post){Post.new title: 'Pretty picture'}
  let(:user){User.new email: 'customer@blah.com', password: '12345678', password_confirmation: '12345678'}
  let(:admin){Admin.new email: 't@t.com', password: '12345678', password_confirmation: '12345678'}

  context 'logged in as an admin' do
    before do
      login_as admin, scope: :admin
    end
    context 'no orders' do
      it 'sees a message' do
        visit '/orders'
        expect(page).to have_content 'No orders yet :-('
      end
    end
    context 'an order' do
      before do
        Order.create post: post, user: user
        visit '/orders'
      end
      it 'should display title of post' do
        expect(page).to have_content 'Pretty picture'
      end
      it 'should display the customer email' do
        expect(page).to have_content 'customer@blah.com'
      end
    end
  end
  context 'not logged in as an admin' do
    it 'prompt to sign in' do
      visit '/orders'
      expect(page).to have_content 'Sign in'
    end
  end
end