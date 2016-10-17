class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
	before_filter :get_top_articles

	def get_top_articles
	  @top_articles = Article.all.order('hits DESC').limit(5)
	end
end
