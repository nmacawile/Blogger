class ArticlesController < ApplicationController
	include ArticlesHelper

	before_action :require_login, except: [:show, :index, :month, :year, :feed]

	def index
		@articles = Article.order('created_at DESC').all
	end

	def create
	  @article = Article.new(article_params)
	  @article.save

	  flash.notice = "Article '#{@article.title}' Created!"

	  redirect_to article_path(@article)
	end

	def new
		@article = Article.new
	end 

	def edit
		@article = Article.find(params[:id])
	end

	def show
		@article = Article.find(params[:id])
		@comment = Comment.new
		@comment.article_id = @article.id
		#@article.increment!(:hits)
		@article.increment_hits
	end

	def update
		@article = Article.find(params[:id])

		if(@article.protect == true)
			flash.notice = "Sorry, but this article is protected. You can create a new article to test the edit function."
		else
		  
		  @article.update(article_params)

	  	  flash.notice = "Article '#{@article.title}' Updated!"
	  	end
		  redirect_to article_path(@article)
		 
	end

	def year
		@year = params[:year]
		#sqlite3
		#@articles = Article.where("cast(strftime('%Y', created_at) as int) = ?",params[:year])
		#postgres
		@articles = Article.where("extract(year from created_at) = ?",params[:year])
	end

	def month
		@monthyear = Date::MONTHNAMES[params[:month].to_i] + " " + params[:year]
		@year = params[:year]
		#sqlite3
		#@articles = Article.where("cast(strftime('%Y', created_at) as int) = ? and cast(strftime('%m', created_at) as int) = ?", params[:year], params[:month])
		#postgres
		@articles = Article.where("extract(year from created_at) = ? and extract(month from created_at) = ?", params[:year], params[:month])
	end

	def destroy
		@article = Article.find(params[:id])
		if(@article.protect == true)
			flash.notice = "Sorry, but this article is protected. You can create a new article to test the delete function."
		else		
			@article.destroy
			flash.notice = "Article '#{@article.title}' Deleted!"			
		end

		redirect_to articles_path
		
	end

	def feed
	    @articles = Article.all
	    respond_to do |format|
	      format.rss { render :layout => false }
	    end
  	end
end
