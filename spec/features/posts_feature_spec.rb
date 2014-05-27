require 'spec_helper'

describe 'Posts' do

	before do
      user = User.create(email: 'alex@a.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa')
      login_as user
  	end

	it 'shows no posts' do
		visit('/')
		expect(page).to have_content('No Posts yet!')
	end

	it 'can add a post' do
		add_post('Look at mein Chitter!', 'Image')
	end

	it 'can add another post' do
		add_post('Where ist mein Chitter?', 'Image')
	end
end