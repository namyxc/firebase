Ha(/^megadom az ételt: "([^"]*)"$/) do |food|
clear_text_in("android.widget.EditText id:'foodName'")
enter_text("android.widget.EditText id:'foodName'", food)
hide_soft_keyboard
end

Ha(/^rendelek ételt$/) do
  touch("android.widget.Button id:'buyFood'")
end

Ha(/^megadom az italt: "([^"]*)"$/) do |drink|
clear_text_in("android.widget.EditText id:'drinkName'")
enter_text("android.widget.EditText id:'drinkName'", drink)
hide_soft_keyboard
end

Ha(/^rendelek italt$/) do
  touch("android.widget.Button id:'buyDrink'")
end

Ha(/^megrendelek (\d+) ételt és (\d+) italt a lentiek közül$/) do |db_food, db_drink, table|
  # table is a Cucumber::Core::Ast::DataTable
  items = table.hashes

  count_food = db_food.to_i
  for i in 1..count_food
    food = items.sample
      steps %Q{
        És megadom az ételt: #{food['food']}
        És rendelek ételt
      }
    puts "Rendelt étel: #{food['food']}"
  end


  count_drink = db_drink.to_i
  for i in 1..count_drink
    drink = items.sample
      steps %Q{
        És megadom az italt: #{drink['drink']}
        És rendelek italt
      }
    puts "Rendelt ital: #{drink['drink']}"
  end
end
