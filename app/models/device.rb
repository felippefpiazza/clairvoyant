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
