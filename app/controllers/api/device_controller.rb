class Api::DeviceController < Api::ApplicationController
  before_filter :restrict_access , :except => [ :destroy_all, :controller_data ]

  def controller_data
    
    if (d = Device.find_by_id(params[:device_id])) != nil
      d_params = []
      d_faults = []
      d_infos = []
      d_faulthistory = []
      d.deviceparameters.each do |dp|
        d_params << {name: dp.parameter.display_name, value: dp.value_normalized}
      end
      d.deviceinfos.each do |di|
        d_infos << {name: di.parameter.display_name, value: di.value_normalized}
      end
      has_fault = false
      d.devicefaults.where(value:  1).each do |df|
        d_faults << {name: df.parameter.display_name, value: df.value_normalized}
        has_fault = true
      end
      d.faulthistories.each do |dfh|
        d_faulthistory << {name: dfh.description, started: dfh.created_at.strftime("%d-%m-%Y %H:%M"), ended: dfh.active == 0 ? dfh.updated_at.strftime("%d-%m-%Y %H:%M") : nil}

      end
        
      response = {
                  device: d, 
                  d_params: d_params, 
                  d_infos: d_infos, 
                  d_faults: d_faults, 
                  has_fault: has_fault, 
                  d_faultshistory: d_faulthistory
                  }

      send_response(response)
    else
      send_response(nil)
    end
    
  end

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

