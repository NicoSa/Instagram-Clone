require 'spec_helper'

describe 'Hate' do

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
  	expect(page).to have_content('Login')
  end

  # it 'can´t be added to a post twice' do
  # 	add_post('DIIIIE')
  # 	click_on('Hate')
  # 	click_on('Hate')
  # 	expect(page).to_not have_content('Hated by: nico@nicosaueressig.de nico@nicosaueressig.de')
  # end
  	
  it 'can be unHated' do
  	add_post('DIIIIE')
  	click_on('Hate')
  	click_on('Unhate')
  	expect(current_path).to eq ('/')
  	expect(page).to_not have_content('Who hated this? nico@nicosaueressig.de')
  end

  it 'can only be unhated by the Hater' do
  	add_post('DIIIIE')
  	click_on('Hate')
  	logout
  	login_as @sroop
  	click_on('Unhate')
  	expect(page).to have_content('Can´t delete a hate that is not yours!')
  end

  it 'hides Hate button when picture is hated for a user' do
  	add_post('DIIIIE')
  	click_on('Hate')
  	expect(page).to have_content('Unhate')
  	expect(page).to_not have_content('Hate')
  end
end

