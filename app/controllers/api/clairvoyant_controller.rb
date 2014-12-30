class Api::ClairvoyantController < Api::ApplicationController
    before_filter :restrict_access , :except => [ :create_clairvoyant , :all_clairvoyants, :clairvoyant_devices]

    def clairvoyant_devices
      c = Clairvoyant.includes([:device]).where(:id => params[:clairvoyant_id]).first
      devices = []
      
      c.device.each do |d|
        d_params = []
        d_faults = []
        d_infos = []

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
        dev_array = {device: d, d_params: d_params, d_infos: d_infos, d_faults: d_faults, has_fault: has_fault}
        devices << dev_array
        
      end
      response = {clairvoyant: c, devices: devices}
      send_response(response)

    end

    def all_clairvoyants
      select_creator = []
      select_creator << " 1=1 "
      if params[:client_id] != nil and params[:client_id] != ""
        select_creator << " client_id = " + params[:client_id] 
      end
      if params[:serial] != nil and params[:serial] != ""
        select_creator << "( serial like '%" + params[:serial] + "%' or serial_hex like '%" + params[:serial] + "%') "
      end
      
      @clairvoyants =  Clairvoyant.where( select_creator.join(" and "))
      
      response = []
      @clairvoyants.each do |c|
        device = []
        c.device.each do |d|
          device << {device: d, has_fault: d.has_fault?}
        end
        response << {clairvoyant: c, client: c.client, devices: device, equipment: c.equipment, manufacturer: c.equipment.manufacturer}
      end
      send_response(response)
      #send_response(@clairvoyants.as_json(include: :device))
    end
  
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
