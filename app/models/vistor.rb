class Vistor < ApplicationRecord
	validates_presence_of :username
	validates_presence_of :arrival_date
	validates_presence_of :arrival_time

	VISITOR_TYPE = ["Vistor", "Meeting", "Interview", "Friend/Family Visit"]
	HOST = ["CEO", "CTO", "Designer", "Project Manager"]
	def self.to_csv
    CSV.generate do |csv|
      csv << ["id", "location_name", "signed_in_time_utc", "signed_in_time_local", "signed_out_time_utc",
      	"signed_out_time_local", "your_full_name", "nda_pdf_url", "photo_url", "private_notes"
      ]
      all.each do |vistor|
        csv << [vistor.id, vistor.username ]
      end
    end
  end
end
