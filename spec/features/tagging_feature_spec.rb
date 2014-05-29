require 'spec_helper'

describe 'Tags' do

	context 'are displayed on the homepage' do

		before do
			user = User.create(email: 'nico@nicosaueressig.de', password:'12345678', password_confirmation:'12345678')
			login_as user
		end

		it 'ONE tag if one tag is added' do
			visit('/posts')
			add_post_with_tags("Herro","yolohafte")
			expect(page).to have_content('Herro')
			expect(page).to have_link('#yolohafte')
		end

		it 'TWO tags if two tags are added' do
			visit('/posts')
			add_post_with_tags("Herro","yolohafte, swagnachten")
			expect(page).to have_content('Herro')
			expect(page).to have_link('#yolohafte')
			expect(page).to have_link('#swagnachten')
		end

	end

	context 'have their own page' do

		before do
			user = User.create(email: 'nico@nicosaueressig.de', password:'12345678', password_confirmation:'12345678')
			login_as user
		end

		it 'that only shows pictures tagged with a certain tag' do
			add_post_with_tags("Herro", "yolohafte")
			add_post_with_tags("Rehho", "swagnachten")
			click_link('#yolohafte')
			expect(page).to_not have_content('Rehho')
			expect(page).to have_content('Herro')
		end

		it 'and the URL is tags/tag_name' do
			add_post_with_tags("Herro", "yolohafte")
			click_link('#yolohafte')
			expect(current_path).to eq('/tags/yolohafte')
		end
	end
end
	