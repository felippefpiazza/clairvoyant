class Api::UserController < ApplicationController
  
  before_filter :restrict_access , :except => [ :auth, :create_user ]
  
  def auth
    username = params[:username]
    password = params[:password]
    device_signature = params[:device_signature]
     if (u = User.where(:username => username ,  :password => password).first)
       generate_token(u, device_signature)
     elsif
       response = {:error => {:response => true, :error_msgs => ["Bad username or password"]}}
       send_response(response)
     end
  end
  
  def generate_token(u,device_signature)
    (key = ApiKey.new(:user => u, :device_signature => device_signature)).generate_key
    key.save
    response = {:userinfo => u.as_json("full")  ,:token => key.access_token  , :error => {:response => false, :error_msgs => []} }
    send_response(response)
    
  end
  
  def create_user
    device_signature = params[:device_signature]
    username = params[:username]
    password = params[:password]
    title = params[:title]
    first_name = params[:first_name]
    middle_name = params[:middle_name]
    last_name = params[:last_name]
    nickname = params[:nickname]
    tel_1 = params[:tel_1]
    tel_2 = params[:tel_2]
    email = params[:email]
    birthday = params[:birthday]
    gender = params[:gender]

    u = User.create(
                :username => username,
                :password => password,
                :title => title,
                :first_name => first_name,
                :middle_name => middle_name,
                :last_name => last_name,
                :nickname => nickname,
                :tel_1 => tel_1,
                :tel_2 => tel_2,
                :email => email,
                :birthday => birthday,
                :gender => gender)
      #binding.pry
      if u.errors.count == 0
        generate_token(u, device_signature)
      else
        messages = []
        u.errors.messages.each do |what,msg|
          messages << msg[0]
          #binding.pry
        end
        response = {:error => {:response => true, :error_msgs => messages}}
        send_response(response)        
      end

  end
  
  def get_user
    id = params["id"]
    kind = params["kind"]
    return_obj("User",id,kind)
  end
  
  def nothing
    response = {:data_received => {:name => params[:name], :password => params[:password]}, :error => {:response => false, :error_msgs => []}}
    send_response(response)
  end
  
  
end
