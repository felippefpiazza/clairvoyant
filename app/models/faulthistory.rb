class Faulthistory < ActiveRecord::Base
  belongs_to  :parameter
  belongs_to  :device
end
