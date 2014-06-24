require 'spec_helper'

describe 'Hate', js: true do

  before do
    nico = User.create(email: 'nico@nicosaueressig.de', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa')
    login_as nico
    @sroop = User.create(email: 'sroop@sroop.com', password: 'bbbbbbbb', password_confirmation: 'bbbbbbbb')
  end

  it 'can be added to a post' do
    add_post('DIIIIE')
    click_on('Hate')
    expect(page).to have_content('Who hated this? nico@nicosaueressig.de ')
  end

  it 'doesn´t die when you log out' do
  	logout
  	visit('/')
  	expect(page).to have_button('Login')
  end
  	
  it 'can be unHated' do
  	add_post('DIIIIE')
  	click_on('Hate')
  	click_on('Unhate')
  	expect(page).to_not have_content('Who hated this? nico@nicosaueressig.de')
  end

  it 'hides Hate button when picture is hated for a user' do
    add_post('DIIIIE')
  	click_on('Hate')
  	expect(page).to have_content('Unhate')
  	expect(page).to_not have_content('Hate')
  end
end

