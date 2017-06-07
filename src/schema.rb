require 'sequel'

# Creates the Schema for the sqlite database
# Stores it into the file ./frommers.sqlite3

DB = Sequel.connect('sqlite://frommers.sqlite3')

DB.create_table :user_profiles do
  String :key
  String :name
  String :email
  String :image_url
  String :about_me
  String :sex
  String :date_of_birth
  String :location
end
