class Vistor < ApplicationRecord
	validates_presence_of :username
	validates_presence_of :arrival_date
	validates_presence_of :arrival_time

	VISITOR_TYPE = ["Vistor", "Meeting", "Interview", "Friend/Family Visit"]
	HOST = ["CEO", "CTO", "Designer", "Project Manager"]
	def self.to_csv
    CSV.generate do |csv|
      csv << ["id", "location_name", "signed_in_time_utc", "signed_in_time_local", "signed_out_time_utc",
      	"signed_out_time_local", "your_full_name", "nda_pdf_url", "photo_url", "private_notes","vistor_type" ,"here_for","host"
      ]
      all.each do |vistor|
        csv << [vistor.id, "Said Hq", Vistor.get_arrival_time_local_time(vistor.arrival_time, vistor.arrival_date),
                Vistor.get_arrival_time_utc_time(vistor.arrival_time, vistor.arrival_date),  
                 Vistor.get_utc_time(vistor.checkout_time), Vistor.get_local_time(vistor.checkout_time), 
                 vistor.username, "", "", vistor.note, vistor.visitor_type, vistor.here_for, vistor.host]
      end
    end
  end

  def self.get_local_time(checkout)
    checkout.present? ? checkout.localtime.strftime("%m/%d/%Y %I:%M %p") : "Signed In Now"
  end

  def self.get_utc_time(checkout)
    checkout.present? ? checkout.utc.strftime("%m/%d/%Y %I:%M %p") : "Signed In Now"
  end

  def self.get_arrival_time_local_time(time, date)
    d = Date.new(date.year, date.month, date.day)
    t = time
    dt = DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec, t.zone)
    dt.present? ?  dt.localtime.strftime("%m/%d/%Y %I:%M %p"): ""
  end

  def self.get_arrival_time_utc_time(time, date)
    d = Date.new(date.year, date.month, date.day)
    t = time
    dt = DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec, t.zone)
    dt.present? ?  dt.utc.strftime("%m/%d/%Y %I:%M %p"): ""
  end

end
