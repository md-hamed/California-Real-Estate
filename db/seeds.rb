require 'csv'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Parse and seed real estates in California CSV file
puts " >> Seeding real estates .."

csv_text = File.read(Rails.root.join('lib', 'seeds', 'Sacramentorealestatetransactions.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')

csv.each do |row|
  r = RealEstate.new

  r.street = row['street']
  r.city = row['city']
  r.zip = row['zip']
  r.state = row['state']
  r.beds = row['beds']
  r.baths = row['baths']
  r.sq_ft = row['sq__ft']
  # building type is an enum
  r.building_type = row['type'].try(:downcase).try(:gsub, /-/, '_')
  r.sale_date = row['sale_date']
  r.price = row['price']
  r.latitude = row['latitude']
  r.longitude = row['longitude']
  
  r.save ? print('.') : print('F')
end

puts "\n>> Finished creating #{RealEstate.count} real estate."
