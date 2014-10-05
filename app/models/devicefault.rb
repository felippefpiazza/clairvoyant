class Devicefault < ActiveRecord::Base
  has_paper_trail  
  belongs_to  :device
  belongs_to  :fault  
end
