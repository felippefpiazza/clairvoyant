class Api::DeviceController < Api::ApplicationController
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
    send_response(response)
end

  def send_params
    device_data = params[:device]
    serial = device_data[:serial]
    device = Device.where(:serial_hex => serial).first
    p = device_data[:parameters]
    f = device_data[:faults]
    i = device_data[:deviceinfo]    

    param_return = []
    if p != nil
      p.each do |parameter|
        dp = device.setvalues(parameter["Parameter_Index"],parameter["Display_Value"])
        dp.each do |d|
          param_return << d.as_json(include: :parameter)
        end
      end
    end
    
    fault_return = []
    if f != nil
      f.each do |fault|      
        df = device.setvalues(fault["Fault_Index"],fault["Display_Value"])
        df.each do |d|
          fault_return << d.as_json(include: :parameter)
        end
      end
    end
    
    deviceinfo_return = []
    if i != nil
      i.each do |deviceinfo|      
        di = device.setvalues(deviceinfo["DeviceInfo_Index"],deviceinfo["Display_Value"])
        di.each do |d|
          deviceinfo_return << d.as_json(include: :parameter)
        end
      end
    end  
    
    response = {:device => device, :parameters => param_return.as_json, :faults => fault_return.as_json, :deviceinfos => deviceinfo_return.as_json , :error => {:response => false, :error_msgs => []}}
    send_response(response)
  end
  
  def send_faults
    device_data = params[:device]
    serial = device_data[:SerialNumber]
    device = Device.where(:serial_hex => serial).first
    p = device_data[:parameters]

    param_return = []

    p.each do |parameter|
      df = device.setfaults_by_name(parameter.keys.first,parameter[parameter.keys.first])
      param_return << df.as_json
    end
    
    response = {:device => device, :parameters => param_return.as_json , :error => {:response => false, :error_msgs => []}}
    send_response(response)
    
  end


end

