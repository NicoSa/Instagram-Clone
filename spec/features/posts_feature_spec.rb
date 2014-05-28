require 'spec_helper'

describe 'Posts' do

	before do
      nico = User.create(email: 'nico@nicosaueressig.de', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa')
      login_as nico
      @sroop = User.create(email: 'sroop@sroop.com', password: 'bbbbbbbb', password_confirmation: 'bbbbbbbb')

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

	it 'can be liked' do
		add_post('Hooray')
		click_on('like')
		expect(page).to have_content('Liked by: alex@a.com ')
	end

	it 'can be deleted' do
		add_post('Look at this beautiful trollface')
		click_on('Delete')
		expect(page).not_to have_content('Look at this beautiful trollface')
	end

	it 'can only be deleted by its poster' do
		add_post('Look at this beautiful trollface')
		logout
		login_as @sroop
		visit ("/")
		expect(page).to_not have_content('can´t touch this, nanana')
	end
end