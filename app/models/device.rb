class Device < ActiveRecord::Base
  has_paper_trail
  belongs_to  :clairvoyant
  has_many  :deviceparameters
  has_many  :devicefaults
  has_many  :deviceinfos

  def setvalues(param,value)
    p = Parameter.where(:cob_id => param)
    dv_return = []
    
    if p.length > 0
      
      if value.start_with?("0x")
        value_hexa = value
        value = value.to_i(16)
        value_bin = value.to_s(2).rjust(8, '0')
      else
        value = value
        value_hexa = nil
        value_bin = nil
      end
      
      p.each do |pb|
        if pb.bit_select > -1
          dv_return << self.setvalue(pb, value_bin[pb.bit_select], value_hexa)
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
      dv.value = value
      dv.value_hexa = value_hexa
      dv.save
    else
      dv = resource.create(:device => self, :parameter => param, :value => value, :value_hexa => value_hexa)
    end
    return dv
  end


#LIXO!!!!!!!
  def setfaults_by_name(param,value)
    if !Parameter.exists?(:name => param)
      Devicefault.new(:name=> param).save
    end

    p = Devicefault.where(:name => param).first

    if Devicefault.exists?(:device => self , :fault => p)
      df = Devicefault.where(:device => self , :fault => p).first
      df.hexa_value = value
      df.value= value.to_i(16)
      df.save
    else
      df = Devicefault.create(:device => self, :fault => p, :hexa_value => value, :value => value.to_i(16))
    end

    return df
  end 
    
end
