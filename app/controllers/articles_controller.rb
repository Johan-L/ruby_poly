class ArticlesController < ApplicationController
	#include ::ContentHelper

	require 'ContentHelper'
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
		require 'json'

		

	  	a = Article.new()
	  	a.title = "Title"
	  	a.text = "Text"

	  	response2 = RestClient.post('http://localhost:8080/onecms/security/token?format=json',
  			{'username' => 'sysadmin',
  			 'password' => 'sysadmin'
  			}.to_json,
			:content_type => 'application/json')

	  	puts response2.inspect
	  	paresed_response = JSON(response2)
	  	token = paresed_response["token"]
	  	puts token

	  	major = params[:id]
	  	minor = params[:format]
	  	puts ContentHelper.get_content("#{major}.#{minor}")

	  	url = "http://localhost:8080/onecms/content/contentid/#{major}.#{minor}?format=json"
	  	puts url

	  	response2 = RestClient.get(url,
			:x_auth_token => token)

	  	#puts JSON(response2)
	  	paresed_response = JSON(response2)

	  	puts "TEST"
	  	puts paresed_response["contentData"]["title"]

	  	#response = RestClient.get 'http://sunet.se'
	  	#puts response.inspect

		
		@element = {:title => "Title", :text => "Text"}
		@article = Article.new
		@article.title = paresed_response["contentData"]["title"]
		@article.text = paresed_response
		#@article.content = paresed_response
		puts a.inspect


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

