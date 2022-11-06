puts "🌱 Seeding data... 😎"

# place your seeds here

# create categories
Category.create(name: "Work")
Category.create(name: "Personal")
Category.create(name: "Chores")
Category.create(name: "Errands")
Category.create(name: "Hobbies")

# create todolists
Category.all.each do |category|
  5.times do
    TodoList.create(
      title: Faker::Lorem.sentence(word_count: 3),
      description: Faker::Lorem.paragraph(sentence_count: 2),
      category_id: category.id,
      status: false
    )
  end
end

puts "🌱 Done seeding! 😃"
