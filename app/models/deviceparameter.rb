class Deviceparameter < ActiveRecord::Base
  belongs_to  :device
  belongs_to  :parameter
  

end
