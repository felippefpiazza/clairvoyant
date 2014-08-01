class ApiKey < ActiveRecord::Base
  before_create :generate_access_token
  belongs_to :clairvoyant
  
  def generate_key
    self.class.where(:clairvoyant => self.clairvoyant).each do |old_key|
      old_key.revoke
    end
    self.expires_at = 1.month.from_now
    self.revoked = false
  end

  
  def revoke
      self.revoked = true
      self.save
  end
    
  private
  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end
  

  
end
