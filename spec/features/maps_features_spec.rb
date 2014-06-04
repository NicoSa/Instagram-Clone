require 'spec_helper'

describe 'Maps' do

  before do
    @user = User.new(email: "user@nicosaueressig.de", password:"12345678", password_confirmation:"12345678")
    login_as @user
  end

  it 'writes geolocation into post' do

  end

end
