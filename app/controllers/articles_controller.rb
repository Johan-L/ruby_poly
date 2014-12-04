class ArticlesController < ApplicationController 
	require 'ContentHelper'
	helper ContentHelper

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

     	article_resp = ContentHelper.get_content("#{major}.#{minor}")

	  	paresed_article = JSON(article_resp)

		@article = Article.new
		@article.title = paresed_article["contentData"]["title"]
		@article.text = paresed_article



	end

	def create
		puts "CREATE"	
	  @article = Article.new(article_params)
	 
	  @article.save
	  redirect_to @article
	end
	
	def renderActionInOtherController(controller,action,params)
	  controller.class_eval{
	    def params=(params); @params = params end
	    def params; @params end
	  }
	  c = controller.new
	  c.request = @_request
	  c.response = @_response
	  c.params = params
	  c.send(action)
	  c.response.body
	end


	private
	  	def article_params
	    	params.require(:article).permit(:title, :text)
  		end




end

