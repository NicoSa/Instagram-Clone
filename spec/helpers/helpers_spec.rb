def add_post(comment="",image="")
  visit('/')
  fill_in 'Comment', with: "#{comment}"
  fill_in 'Image', with: "#{image}"
  click_on('Add')
  expect(page).to have_content("#{comment}")
end
