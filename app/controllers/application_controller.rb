class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
	before_action :get_top_articles, :past_six_months

	def get_top_articles
	  @top_articles = Article.all.order('hits DESC').limit(3)
		#@top_articles = Article.limit(3).order('hits DESC').all
	end

	def past_six_months
	@months=[]
		5.downto(0).each do |n|
		  @months.push ((Time.now - n.month).at_beginning_of_month)
		end
	end
	
	
end
