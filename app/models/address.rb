class Address < ActiveRecord::Base
  validates :city, :presence => {message: 'City is required'}
  validates :country, :presence => {message: 'Country is invalid'}
  belongs_to :addressable, :polymorphic => true
  belongs_to :country
  

  def as_json(kind)
    case kind
    when "main"
      json_output = { 
                    :address_type => self.address_type,
                    :name => self.name,
                    :address_1 => self.address_1,
                    :address_2 => self.address_2,
                    :address_3 => self.address_3,
                    :address_4 => self.address_4,
                    :city => self.city,
                    :state => self.state,
                    :country_id => self.country_id,
                    :country => self.country ? self.country.name : nil,
                    :zip => self.zipcode
                     }
    when "full"
      json_output = { 
                    :address_type => self.address_type,
                    :name => self.name,
                    :address_1 => self.address_1,
                    :address_2 => self.address_2,
                    :address_3 => self.address_3,
                    :address_4 => self.address_4,
                    :city => self.city,
                    :state => self.state,
                    :country_id => self.country_id,
                    :country => self.country.name,
                    :zip => self.zipcode,
                    :lat_degree => self.lat_degree,
                    :lat_hour => self.lat_hour,
                    :lat_minute => self.lat_minute,
                    :lat_second => self.lat_second,
                    :lon_degree => self.lon_degree,
                    :lon_hour => self.lon_hour,
                    :lon_minute => self.lon_minute,
                    :lon_second => self.lon_second,
                     }
    end
                     
  end
  

end
