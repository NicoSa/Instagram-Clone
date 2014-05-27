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
		add_post('Look at mein Chitter!')
		expect(page).to have_css('img.uploaded-pic')
	end

	it 'can add another post' do
		add_post('Where ist mein Chitter?')
		expect(page).to have_css('img.uploaded-pic')
		expect(page.find('img.uploaded-pic')['src']).to have_content('trollface.png')
	end
end