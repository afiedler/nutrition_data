# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

foods = []
File.open(Rails.root.to_s + "/db/ABBREV.txt", "r:iso-8859-1").each_line do |line|
  cols = line.split('^')
  food = {}
  Food::USDA_ABBRIV_FIELDS.each_with_index do |(k,v), i|
    val = cols[i].gsub('~','')
    case v
      when :string
        food[k] = val
      when :decimal
        if val.strip.empty?
          val = nil
        else
          val = val.to_d
        end
        food[k] = val
    end
  end
  foods << food
end

Food.create!(foods)

puts "Seeded #{foods.length} food(s)."

