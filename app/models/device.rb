class Device < ActiveRecord::Base
  has_paper_trail
  belongs_to  :clairvoyant
  has_many  :deviceparameters
  has_many  :devicefaults
  has_many  :deviceinfos
  has_many  :faulthistories


  def process_params(parameters)
    par_ar = parameters.split(/,/)
    par_ar.each do |p|
      if p != ""
        par = self.decode_canopen_string(p)
        self.setvalues(par[:index_hex] , par[:data_hex])
      end
    end
  end

  def decode_canopen_string(s)
    ind_hex = "0x" + s[4..5] + s[2..3] + s[6..7]
    data_hex = "0x" + s[14..15] + s[12..13] + s[10..11] + s[8..9]
    result = {index_hex: ind_hex, data_hex: data_hex , data: data_hex.to_i(16)}
  end

  def has_fault?
    if self.devicefaults.where(value: 1).length > 0
      return true
    else
      return false
    end
  end

  def setvalues(param,value)
    p = Parameter.where(:cob_id => param, :equipment_id => self.clairvoyant.equipment_id, :node_id => self.node_id) 
    dv_return = []
    
    if p.length > 0
      
      if value.start_with?("0x")
        value_hexa = value
        value = value.to_i(16)
        value_bin = value.to_s(2).rjust(8, '0')
        
      else
        value = value
        value_hexa = nil
      end
      
      

      p.each do |pb|
        if pb.bit_select > -1
      
          dv_return << self.setvalue(pb, value_bin[7 - pb.bit_select], value_hexa)

        else
          dv_return << self.setvalue(pb,value,value_hexa)
        end
      end
    end
    
    return dv_return
  end

  def  setvalue(param, value, value_hexa)
    resource = "Device".concat(param.type_param.downcase).constantize
    if resource.exists?(:device => self , :parameter => param)
      dv = resource.where(:device => self , :parameter => param).first
      if param.type_param.downcase == "fault" and dv.value != value.to_i
        if value.to_i == 1
          Faulthistory.create(:device => self, :active => true, :description => dv.parameter.display_name, :parameter => dv.parameter)
        else
          fh = Faulthistory.where(:device => self, :active => true, :parameter_id => dv.parameter.id).first
          if fh != nil
            fh.active = false;
            fh.save
          end
        end
      end
      dv.value = value
      dv.value_hexa = value_hexa
      dv.save
    else
      dv = resource.create(:device => self, :parameter => param, :value => value, :value_hexa => value_hexa)
      if param.type_param.downcase == "fault" and value.to_i == 1
        Faulthistory.create(:device => self, :active => true, :description => dv.parameter.display_name, :parameter => dv.parameter)      
      end
    end
    return dv
  end
    
end
