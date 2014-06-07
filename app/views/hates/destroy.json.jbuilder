json.post @post.id
json.user current_user
json.hate (link_to "Hate", post_hates_path(@post), method: :post, class:'btn btn-warning hate')