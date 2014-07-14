class MapsController < ApplicationController

	def show
		@post = Post.find_by title: params[:post_id]
	end

end
