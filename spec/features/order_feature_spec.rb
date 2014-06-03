require 'spec_helper'

describe 'order page' do


  context 'logged in as admin' do

    before do
      @admin = Admin.new(email: "nico@nicosaueressig.de", password:"12345678", password_confirmation:"12345678")
      login_as @admin, scope: :admin
    end

    it 'says no orders when there are no orders' do
      visit('/orders')
      expect(page).to have_content "Currently no orders!"
    end

  end

  context 'not logged in as admin' do

    it 'shows admin signup when trying to see orders' do
      visit('/orders')
      expect(current_path).to eq('/admins/sign_in')
    end
  end
end
