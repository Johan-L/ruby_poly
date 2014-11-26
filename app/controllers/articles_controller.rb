class ArticlesController < ApplicationController

	require 'ContentHelper'
	require 'json'	


    def new
    	puts "NEW"	  	
    	a = Article.new()
	  	a.title = "Title"
	  	a.text = "Text"
	  	puts a.inspect
    end


	def show
require 'rest_client'
		puts "SHOW"	

		major = params[:id]
	  	minor = params[:format]

     	response = ContentHelper.get_content("#{major}.#{minor}")

	  	paresed_response = JSON(response)

		@article = Article.new
		@article.title = paresed_response["contentData"]["title"]
		@article.text = paresed_response
	end

	def create
		puts "CREATE"	
	  @article = Article.new(article_params)
	 
	  @article.save
	  redirect_to @article
	end
	 
	private
	  	def article_params
	    	params.require(:article).permit(:title, :text)
  		end




end

