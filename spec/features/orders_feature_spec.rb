require 'rails_helper'

describe 'orders page' do

  let(:post){Post.create title: 'Pretty picture'}
  let(:user){User.create email: 'customer@blah.com', password: '12345678', password_confirmation: '12345678'}
  let(:admin){Admin.create email: 't@t.com', password: '12345678', password_confirmation: '12345678'}

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
        Order.create id: 1, post: post, user: user, created_at: Date.new(2013, 12, 25)
        visit '/orders'
      end
      it 'should display title of post' do
        expect(page).to have_content 'Pretty picture'
      end
      it 'should display the customer email' do
        expect(page).to have_content 'customer@blah.com'
      end
      it 'displays an order number' do
        expect(page).to have_content '2512130001'
      end
    end
  end
  context 'not logged in as an admin' do
    it 'prompt to sign in' do
      visit '/orders'
      expect(page).to have_content 'Sign in'
    end
  end

  describe 'email confirmation' do
    before do
      clear_emails
    end

    it 'is sent when an order is created' do
      Order.create(post: post, user: user)
      open_email('customer@blah.com')
      expect(current_email).to have_content 'Order successful!'
      expect(current_email.subject).to eq 'You just ordered a print of Pretty picture'
    end
  end
  
end




