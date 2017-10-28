first_name = ["Elizabeth", "Karen", "Michael", "Elesa", "Kevin"]

last_name = ["Blackwell", "Smith", "Mengesha", "Holly"]

20.times do |i|
  Doctor.create(first_name: first_name.sample, last_name: last_name.sample, street: "#{i} Main Street")
end
