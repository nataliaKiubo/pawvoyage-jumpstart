# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'faker'

puts 'Creating addresses...'
# Create addresses
10.times do
  address = Address.create!(
    city: Faker::Nation.capital_city,
    country: Faker::Space.galaxy,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude
  )
  puts "Address created: #{address.city}, #{address.country}"
end

puts 'Creating vehicles...'
# Create vehicles
%w[car train plane].each do |name|
  vehicle = Vehicle.create!(name: name)
  puts "Vehicle created: #{vehicle.name}"
end

puts 'Creating pet types...'
# Create pet types
%w[dog cat hamster].each do |name|
  pet_type = PetType.create!(name: name)
  puts "Pet type created: #{pet_type.name}"
end

puts 'Creating admin users...'
# Create admin users
admin_users = [
  { name: 'Natalia', email: 'natalia@email.com', password: 'nat123' },
  { name: 'Aleks', email: 'aleks@email.com', password: 'ale123' }
]

admin_users.each do |admin|
  user = User.create!(
    first_name: admin[:name],
    email: admin[:email],
    password: admin[:password],
    admin: true
  )
  puts "Admin user created: #{user.first_name} (#{user.email})"
end

puts 'Creating pets for admin users...'
# Create pets for admin users
admin_users.each do |admin|
  user = User.find_by(email: admin[:email])
  pet = Pet.create!(
    name: Faker::Creature::Dog.name,
    user_id: user.id,
    pet_type_id: PetType.find_by(name: 'dog').id
  )
  puts "Pet created for admin user #{user.first_name}: #{pet.name}"
end

puts 'Creating regular users...'
# Create regular users
regular_users = [
  { name: 'John', email: 'john@example.com', password: 'password' },
  { name: 'Jane', email: 'jane@example.com', password: 'password' },
  { name: 'David', email: 'david@example.com', password: 'password' }
]

regular_users.each do |user|
  created_user = User.create!(
    first_name: user[:name],
    email: user[:email],
    password: user[:password]
  )
  puts "Regular user created: #{created_user.first_name} (#{created_user.email})"
end

puts 'Creating pets for regular users...'
# Create pets for regular users
regular_users.each do |user|
  user = User.find_by(email: user[:email])
  pet = Pet.create!(
    name: Faker::Creature::Dog.name,
    user_id: user.id,
    pet_type_id: PetType.find_by(name: 'dog').id
  )
  puts "Pet created for regular user #{user.first_name}: #{pet.name}"
end

puts 'Creating trips for all users...'
# Create trips for all users
User.all.each do |user|
  3.times do
    trip = user.trips.create!
    puts "Trip created for user #{user.first_name}: #{trip.id}"

    # Create legs for each trip
    3.times do
      leg = Leg.create!(
        description: Faker::Quotes::Chiquito.joke,
        provider: Faker::Games::Pokemon.name,
        vehicle_id: Vehicle.all.sample.id,
        trip_id: trip.id,
        origin_id: Address.all.sample.id,
        destination_id: Address.all.sample.id
      )
      puts "Leg created for trip #{trip.id}: #{leg.id}"
    end
  end
end

puts 'Seed data generation completed successfully.'
