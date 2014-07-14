class PostsController < ApplicationController

	before_action :authenticate_user!, except: [:index, :show]

	def index
		@posts = Post.all.order(created_at: :desc)
	end

	def show
		@post = Post.find_by title: params[:id]
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(params[:post].permit(:title, :description, :image, :tag_names, :address ))
		@post.user = current_user
		@post.save!

		redirect_to posts_path
	end

end
