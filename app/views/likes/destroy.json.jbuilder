json.post @post.id
json.user current_user
json.like (link_to "Like", post_likes_path(@post), method: :post, class:'btn btn-info like')