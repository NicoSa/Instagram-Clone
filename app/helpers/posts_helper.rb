module PostsHelper

	def user_likes?(post)
		!user_likes_for(post).nil?
	end

	def user_likes_for(post)
		current_user.likes.select{|like| like.post == post }.first
	end

	def user_hates?(post)
		!user_hates_for(post).nil?
	end

	def user_hates_for(post)
		current_user.hates.select{|hate| hate.post == post }.first
	end
end
