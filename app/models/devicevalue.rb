class Devicevalue < ActiveRecord::Base
  has_paper_trail  
  belongs_to  :device
  belongs_to  :parameter
  
  def value_normalized
    self.value
  end
end
