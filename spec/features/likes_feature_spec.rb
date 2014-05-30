require 'spec_helper'

describe 'Likes' do

  before do
    nico = User.create(email: 'nico@nicosaueressig.de', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa')
    login_as nico
    @sroop = User.create(email: 'sroop@sroop.com', password: 'bbbbbbbb', password_confirmation: 'bbbbbbbb')
  end

  it 'can be added to a post' do
    add_post('Hooray')
    click_on('Like')
    expect(page).to have_content('Liked by: nico@nicosaueressig.de ')
  end

  it 'doesn´t die when you log out' do
  	logout
  	visit('/')
  	expect(page).to have_content('Login')
  end

  it 'can´t be added to a post twice' do
  	add_post('Hooray')
  	click_on('Like')
  	click_on('Like')
  	expect(page).to_not have_content('Liked by: nico@nicosaueressig.de nico@nicosaueressig.de')
  end
  	
end
