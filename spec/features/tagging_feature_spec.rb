require 'spec_helper'

describe 'Tags' do

	context 'are displayed on the homepage' do

		before do
			user = User.create(email: 'nico@nicosaueressig.de' password:'12345678', password_confirmation:)
			login_as user
		end

		it 'NOT if no tags are there' do
			visit('/posts')
			add_post
		end

		it 'ONE tag if one tag is added' do
		end

		it 'TWO tags if two tags are added' do
		end

	end
end
	