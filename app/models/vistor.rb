class Vistor < ApplicationRecord
	validates_presence_of :username
	validates_presence_of :email
	validates_presence_of :contact_number
	validates_uniqueness_of :username
	validates_uniqueness_of :email
	validates_uniqueness_of :contact_number

	def self.to_csv
    CSV.generate do |csv|
      csv << ["Id", "Recipient Email" , "Via" , "Status" , "Date"]
      all.each do |vistor|
        csv << [vistor.id, vistor.username ]
      end
    end
  end
end
