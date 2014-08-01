class Contact < Person
  validates :first_name, :presence => true
  validates :tel_1, :presence => true
  
  
end