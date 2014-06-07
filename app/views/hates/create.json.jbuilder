json.user @hate.user.email
json.post @post.id
json.unhate (link_to "Unhate", post_hate_path(@post, user_hates_for(@post)), method: :delete, class:'btn btn-warning unhate')
