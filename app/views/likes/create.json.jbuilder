json.user current_user.email
json.post @post.id
json.unlike (link_to "Unlike", post_like_path(@post, user_likes_for(@post)), method: :delete, class:'btn btn-info unlike')