require 'spec_helper'

describe 'Likes', js: true do

  before do
    nico = User.create(email: 'nico@nicosaueressig.de', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa')
    login_as nico
    @sroop = User.create(email: 'sroop@sroop.com', password: 'bbbbbbbb', password_confirmation: 'bbbbbbbb')
  end

  it 'can be added to a post' do
    add_post('Hooray')
    click_on('Like')
    expect(page).to have_content('nico@nicosaueressig.de ')
  end

  it 'doesn´t die when you log out' do
  	logout
  	visit('/')
  	expect(page).to have_button('Login')
  end

  # it 'can´t be added to a post twice' do
  # 	add_post('Hooray')
  # 	click_on('Like')
  # 	click_on('Like')
  # 	expect(page).to_not have_content('Liked by: nico@nicosaueressig.de nico@nicosaueressig.de')
  # end
  	
  it 'can be unliked' do
  	add_post('Hooray')
  	click_on('Like')
  	click_on('Unlike')
  	expect(page).to_not have_content('nico@nicosaueressig.de')
    expect(page).to have_link('Like')
  end

  it 'can only be unliked by the liker' do
  	add_post('Hooray')
  	click_on('Like')
    sleep 1
  	logout
  	login_as @sroop
    visit "/posts"
  	expect(page).to_not have_link('Unlike')
  end


  it 'hides like button when picture is liked for a user' do
  	add_post('Hooray')
  	click_on('Like')
  	expect(page).to have_link('Unlike')
  	expect(page).to_not have_link('Like')
  end

  it 'shows number of likes' do
    add_post('Hooray')
    click_on('Like')
    logout
    login_as @sroop
    click_on('Like')
    expect(page).to have_link('♥2')
  end
end
