class Device < ActiveRecord::Base
  belongs_to  :clairvoyant
  has_many  :deviceparameters
  
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
  
end
