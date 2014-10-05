class Devicedeviceinfo < ActiveRecord::Base
  has_paper_trail  
  belongs_to  :device
  belongs_to  :deviceinfo  
end
