require 'spec_helper'

describe 'Comments' do

	before do
      user = User.create(email: 'alex@a.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa')
      login_as user
      # post = Post.create(picture: 'spec/images/trollface.png', comment:'It´s ein beautiful Chitter')
  	end

  	it 'are not present is shown by putting No Comments on the screen' do
  		visit('/')
  		add_post("Hello")
  		expect(page).to have_content('No Comments')
  	end

  	it 'can be added to a post' do
  		visit('/')
  		add_post("Hello")
  		add_comment("This is a beautiful Chitter!")
  		expect(page).to have_content("This is a beautiful Chitter!")
  	end

end