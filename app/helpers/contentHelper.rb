module ContentHelper
  def self.get_content(str)

  	puts ContentHelper.get_content("#{str}")
  	response = RestClient.post('http://localhost:8080/onecms/security/token?format=json',
  			{'username' => 'sysadmin',
  			 'password' => 'sysadmin'
  			}.to_json,
			:content_type => 'application/json')

  	puts response.inspect
  	paresed_response = JSON(response)
  	token = paresed_response["token"]
  	puts token

  	major = params[:id]
  	minor = params[:format]


  	url = "http://localhost:8080/onecms/content/contentid/#{str}?format=json"
  	puts url

  	response = RestClient.get(url,
		:x_auth_token => token)


    return response
  end

  def get_content(str)
    return ContentHelper.get_content(str)
  end
end