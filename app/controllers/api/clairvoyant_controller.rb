class Api::ClairvoyantController < ApplicationController
    before_filter :restrict_access , :except => [ :create_clairvoyant ]
  
  def create_clairvoyant
    serial = params[:serial]
    c = Clairvoyant.create(:serial_hex => serial, :serial => serial.to_i(16))
    generate_token(c)
  end
  
  
  def generate_token(clairvoyant)
    (key = ApiKey.new(:clairvoyant => clairvoyant)).generate_key
    key.save
    response = {:claivoyant => clairvoyant.as_json  ,:token => key.access_token  , :error => {:response => false, :error_msgs => []} }
    send_response(response)
    
  end
end
