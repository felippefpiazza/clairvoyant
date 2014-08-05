class Api::DeviceController < ApplicationController
  before_filter :restrict_access , :except => [ :destroy_all ]

  def create_device
    serial = params[:serial]
    d = Device.create(:serial_hex => serial, :serial => serial.to_i(16), :clairvoyant => @clairvoyant)
    response = {:device => d.as_json,  :error => {:response => false, :error_msgs => []}}
    send_response(response)
  end

def destroy_all
  Clairvoyant.destroy_all
  Device.destroy_all
  ApiKey.destroy_all
  Deviceparameter.destroy_all
  response = {:error => {:response => false, :error_msgs => []}}
end

  def send_params
    device_data = params[:device]
    serial = device_data[:serial]
    device = Device.where(:serial_hex => serial).first
    p = device_data[:parameters]

    param_return = []

    p.each do |parameter|
      dp = device.setparams(parameter["Parameter_Index"],parameter["Display_Value"])
      param_return << dp.as_json(include: :parameter)
    end
    
    response = {:device => device, :parameters => param_return.as_json , :error => {:response => false, :error_msgs => []}}
    send_response(response)
    
  end
  

end

