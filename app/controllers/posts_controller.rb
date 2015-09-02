class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :authorized_user, only: [:edit, :update, :destroy]
	def index
		@posts = Post.all.order('created_at DESC')
	end
	
	def new 
		@post = current_user.posts.build
	end

	def create 
		@post = current_user.posts.build(post_params)

		if @post.save
			redirect_to @post 
		else 
			render 'new'
		end	
	end

	def show
		@post = Post.find(params[:id])
	end	

	def edit
		@post = Post.find(params[:id]) 
	end	

	def update
		@post = Post.find(params[:id])

		if @post.update(params[:post].permit(:title, :body))
			redirect_to @post 
		else 
			render 'edit'
		end		
	end

	def destroy 
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to posts_path

	end

	def authorized_user
  		@post = current_user.posts.find_by(id: params[:id])
  		redirect_to posts_path, notice: "Não esta autorizado a clicar nesse link" if @post.nil?
	end

	private 
		def post_params
			params.require(:post).permit(:title, :body)
		end	 	
end
