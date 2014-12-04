module ContentHelper
  def self.get_content(str)
  	puts "getContent"
  	response = RestClient.post('http://localhost:8080/onecms/security/token?format=json',
  			{'username' => 'sysadmin',
  			 'password' => 'sysadmin'
  			}.to_json,
			:content_type => 'application/json')

  	paresed_response = JSON(response)
  	token = paresed_response["token"]


  	url = "http://localhost:8080/onecms/content/contentid/#{str}?format=json"
  	puts url

  	response = RestClient.get(url,
		:x_auth_token => token)


    return response
  end

  def self.get_content2(str)
    puts "getContent22"

    puts "test"
    str = str.slice(10,str.length)
    puts "string slice: " + str

    response = RestClient.post('http://localhost:8080/onecms/security/token?format=json',
        {'username' => 'sysadmin',
         'password' => 'sysadmin'
        }.to_json,
      :content_type => 'application/json')

    paresed_response = JSON(response)
    token = paresed_response["token"]


    url = "http://localhost:8080/onecms/content/contentid/#{str}?format=json"
    puts url

    response = RestClient.get(url,
    :x_auth_token => token)


    return response
  end

  def self.get_value_from_json(str, key)
    paresed_str = JSON(str)
    return paresed_str[key]

  end


  def get_content(str)
    return ContentHelper.get_content(str)
  end

  def get_content2(str)
    return ContentHelper.get_content2(str)
  end

  def get_value_from_json(str, key)
    return ContentHelper.get_value_from_json(str, key)
  end


  def getHelp()
  	return "HELP"
  end
end