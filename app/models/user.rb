class User < Person
  #attr_accessible :username, :first_name, :middle_name, :last_name, :password
  has_many :api_key
  validates :first_name, :presence => {message: 'First name is required'}
  validates_uniqueness_of :email , :message => 'E-mail already in use'
  validates_uniqueness_of  :username  , :message => 'Username already in use'
  validate :establishment_is_already_set
  

  def establishment_is_already_set
    c = self.changes["establishment_id"]
    #binding.pry
    if c and c[0] != nil
      self.errors.add("establishment" , "User is already associated with a establishment")
    end
  end
  

  

  
  def as_json(kind)
    case kind
    when "main"
      json_output = { :username => self.username,  
                    :title => self.title, 
                    :first_name => self.first_name,
                    :middle_name => self.middle_name,
                    :last_name => self.last_name,
                    :nickname => self.nickname
                     }
    when "full"
      json_output = { :username => self.username,  
                    :title => self.title, 
                    :first_name => self.first_name,
                    :middle_name => self.middle_name,
                    :last_name => self.last_name,
                    :nickname => self.nickname,
                    :tel_1 => self.tel_1,
                    :tel_2 => self.tel_2,
                    :email => self.email,
                    :birthday => self.birthday,
                    :gender => self.gender
                     }
    end
                     
  end
  
end