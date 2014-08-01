class Clairvoyant < ActiveRecord::Base
  
  has_many  :api_key
  has_many  :device
  

end
