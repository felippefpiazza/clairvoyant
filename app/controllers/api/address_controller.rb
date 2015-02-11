class Api::AddressController < ApplicationController
    before_filter :restrict_access , :except => [ ]
  
  
  def get_countries
    c = Country.all
    response = {:countries => c.as_json("main"), :error => {:response => false, :error_msgs => []} }
    respond_to do |format|
      format.json { render json: response }
      format.xml { render xml: response }
    end
  end  
  
  def add_address
    case params["type"]
      when "User"
        if params["id"]
          p = Person.where(:id => params["id"]).first
        else
          p = @user
        end

      when "Establishment"
        p = Establishment.where(:id => params["id"]).first

      when "Ibeacon"
        p = Ibeacon.where(:id => params["id"]).first

    end
      
    if address = p.addresses.new(address_params) and address.save
      response = {:error => {:response => false, :error_msgs => []} }
    else
      messages = []
      address.errors.messages.each do |what,msg|
        messages << msg[0]
        #binding.pry
      end      
      response = {:error => {:response => true, :error_msgs => messages}}      
    end
    #binding.pry
    send_response(response)
  end

  def get_address
    id = params["id"]
    kind = params["kind"]
    return_obj("Address",id,kind)
  end

  private 
  
  def address_params
    params.require(:address).permit(:address_type,
                                    :name,
                                    :address_1,
                                    :address_2,
                                    :address_3,
                                    :address_4,
                                    :neighborhood,
                                    :reference,
                                    :city,
                                    :state,
                                    :country_id,
                                    :lat_degree,
                                    :lat_hour,
                                    :lat_minute,
                                    :lat_second,
                                    :lon_degree,
                                    :lon_hour,
                                    :lon_minute,
                                    :lon_second,
                                    :zipcode)
    
  end


end
