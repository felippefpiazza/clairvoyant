class Client < Person
  validates :first_name, :presence => {message: 'First name is required'}
  validates_uniqueness_of :email , :message => 'E-mail already in use'
  validates_uniqueness_of  :nickname  , :message => 'Nickname already in use'  
  
  
  
end
