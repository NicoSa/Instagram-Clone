module PostsHelper

	def user_likes?(post)
		!user_likes_for(post).nil?
	end

	def user_likes_for(post)
		current_user.likes.select{|like| like.post == post }.first
	end

end
