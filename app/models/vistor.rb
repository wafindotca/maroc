class Vistor < ApplicationRecord
	validates_presence_of :username
	validates_presence_of :email
	validates_presence_of :contact_number
	validates_uniqueness_of :username
	validates_uniqueness_of :email
	validates_uniqueness_of :contact_number
end
