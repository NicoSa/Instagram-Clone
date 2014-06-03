require 'spec_helper'

describe 'order page' do

  context 'logged in as admin' do

    before do
      @admin = Admin.new(email: "nico@nicosaueressig.de", password:"12345678", password_confirmation:"12345678")
      @user = User.new(email: "user@nicosaueressig.de", password:"12345678", password_confirmation:"12345678")
      @post = Post.create(comment: "Pizza")
      login_as @admin, scope: :admin
    end

    it 'says no orders when there are no orders' do
      visit('/orders')
      expect(page).to have_content "Currently no orders!"
    end

    it 'and one order has been placed' do
      Order.create(user: @user, post: @post)
      visit('/orders')
      expect(page).to have_content('user@nicosaueressig.de')
      expect(page).to have_content('Pizza')
    end

  end

  context 'not logged in as admin' do

    it 'shows admin signup when trying to see orders' do
      visit('/orders')
      expect(current_path).to eq('/admins/sign_in')
    end
  end

  context 'logged in as user' do

    before do
      @user = User.new(email: "user@nicosaueressig.de", password:"12345678", password_confirmation:"12345678")
      @post = Post.create(comment: "Pizza")

      login_as @user
    end

    it 'shows buy button' do
      visit('/')
      expect(page).to have_link('Buy')
    end

    it 'takes you to charges page when you click the Buy button' do
      visit('/')
      click_on('Buy')
      expect(current_path).to eq(new_post_charge_path(@post))
    end


    end
  end
