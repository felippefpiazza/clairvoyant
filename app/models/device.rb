class Device < ActiveRecord::Base
  has_paper_trail
  belongs_to  :clairvoyant
  has_many  :deviceparameters
  has_many  :devicefaults  
  
  def setparams(param,value)
    p = Parameter.where(:cob_id => param).first
    if Deviceparameter.exists?(:device => self , :parameter => p)
      dp = Deviceparameter.where(:device => self , :parameter => p).first
      dp.value = value
      dp.save
    else
      dp = Deviceparameter.create(:device => self, :parameter => p, :value => value)
    end
    
    return dp
  end
  
  def setfaults(param,value)
    if !Fault.exists?(:cob_id => param)
      Fault.new(:cob_id=> param).save
    end

    p = Fault.where(:cob_id => param).first

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
  
  def setdeviceinfos(param,value)
    if !Deviceinfo.exists?(:cob_id => param)
      Deviceinfo.new(:cob_id=> param).save
    end

    p = Deviceinfo.where(:cob_id => param).first

    if Devicedeviceinfo.exists?(:device => self , :deviceinfo => p)
      di = Devicedeviceinfo.where(:device => self , :deviceinfo => p).first
      di.hexa_value = value
      di.value= value.to_i(16)
      di.save
    else
      di = Devicedeviceinfo.create(:device => self, :deviceinfo => p, :hexa_value => value, :value => value.to_i(16))
    end

    return di
  end
  

  def setfaults_by_name(param,value)
    if !Fault.exists?(:name => param)
      Fault.new(:name=> param).save
    end

    p = Fault.where(:name => param).first

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
