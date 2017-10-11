module ApplicationHelper
	def inline_svg(path)
	  file = File.open("app/assets/images/#{path}", "rb")
	  raw file.read
	end

	def create_hours(parameters)
	  start_time = parameters[:start_time] ? parameters[:start_time] : 0
	  end_time = parameters[:end_time] ? parameters[:end_time] : 24.hours
	  increment = parameters[:increment] ? parameters[:increment] : 15.minutes
	  Array.new(1 + (end_time - start_time)/increment) do |i|
	    (Time.now.midnight + (i*increment) + start_time).strftime("%I:%M %p")
	  end
	end

	def show_errors(object, field_name)
	  if object.errors.any?
	    if !object.errors.messages[field_name].blank?
	      object.errors.messages[field_name].join(", ")
	    end
	  end
	end 

end
