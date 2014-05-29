def add_post(comment="")
  visit('/posts/new')
  fill_in 'Comment', with: "#{comment}"
  attach_file 'Picture', Rails.root.join('public/images/trollface.png')
  click_on('Add')
  expect(page).to have_content("#{comment}")
end

def add_comment(comment="")
  visit('/')
  fill_in 'Comment', with: "#{comment}"
  click_on('Add Comment')
  expect(page).to have_content("#{comment}")
end

def add_post_with_tags(comment="",tags="")
  visit('/posts/new')
  fill_in 'Comment', with: "#{comment}"
  fill_in 'Tags', with:
  attach_file 'Picture', Rails.root.join('public/images/trollface.png')

  click_on('Add')
  expect(page).to have_content("#{comment}")
end
