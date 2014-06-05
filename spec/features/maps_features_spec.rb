require 'spec_helper'

describe 'Maps' do

  before do
    @user = User.new(email: "user@nicosaueressig.de", password:"12345678", password_confirmation:"12345678")
    login_as @user
  end

  it 'posts can hold a location' do
    post = Post.create(comment: "Found amazing Pizza here", longitude: 1, latitude: 2)

    expect(post.longitude).to eq 1
    expect(post.latitude).to eq 2
  end

  it 'shows a map button for a post with location' do
    post = Post.create(comment: "Found amazing Pizza here", longitude: 1, latitude: 2)
    visit('/')
    expect(page).to have_link('Map')
  end

  it 'doesn´t show a map button for a post WITHOUT location' do
    visit('/')
    expect(page).to_not have_link('Map')
  end

  it 'goes to a map when you click on map' do
    post = Post.create(comment: "Found amazing Pizza here", longitude: 1, latitude: 2)
    visit('/')
    click_link('Map')
    expect(page).to have_content('This is the location of this picture!')
    expect(current_path).to eq post_map_path(post)
  end
end
