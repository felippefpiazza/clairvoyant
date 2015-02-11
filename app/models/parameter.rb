class Parameter < ActiveRecord::Base
  belongs_to  :faulthistory


def display_value(raw_value)
	if (self.bit_select < 0)
		if (self.min == self.max or self.display_min == self.display_max) 
			val = raw_value.to_f
			
		else 
    		val = self.display_min.to_f + (self.step_size.to_f * self.steps_on_value(raw_value))
    		
    	end

    	if self.decimal_shift != nil
    		val = sprintf("%.#{self.decimal_shift.to_i}f", (val  / (10**self.decimal_shift.to_i)).round(self.decimal_shift.to_i))
    		
    	end

    	

		return val.to_s + " " + (self.unit ? self.unit : "")
	else
		
		if raw_value == 1
			return "On"
		else
			return "Off"
		end
	end
end

def steps_on_value(raw_value)
	return (raw_value.to_f - self.min.to_f)/self.raw_step_size
end


def raw_step_size
	return (self.max.to_f - self.min.to_f)/self.disp_step_qtd
end

def disp_step_qtd
	return (self.display_max.to_f - self.display_min.to_f)/self.step_size.to_f
end



end
