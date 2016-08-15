require_relative 'barista_view'

class BaristaMatic
  attr_accessor :inventory
  attr_reader :costs, :ingredients, :display

  def initialize
    @inventory = {
                  "Cocoa" => 10,
                  "Coffee" => 10,
                  "Cream" => 10,
                  "Decaf Coffee" => 10,
                  "Espresso" => 10,
                  "Foamed Milk" => 10,
                  "Steamed Milk" => 10,
                  "Sugar" => 10,
                  "Whipped Cream" => 10
    }

    @costs = {
              "Coffee" => 0.75,
              "Decaf Coffee" => 0.75,
              "Sugar" => 0.25,
              "Cream" => 0.25,
              "Steamed Milk" => 0.35,
              "Foamed Milk" => 0.35,
              "Espresso" => 1.1,
              "Cocoa" => 0.9,
              "Whipped Cream" => 1.0
    }

    @ingredients = {
                    "Coffee" => [["Coffee", 3], ["Sugar", 1], ["Cream", 1]],
                    "Decaf Coffee" => [["Decaf Coffee", 3], ["Sugar", 1], ["Cream", 1]],
                    "Caffe Latte" => [["Espresso", 2], ["Steamed Milk", 1]],
                    "Caffe Americano" => [["Espresso", 3]],
                    "Caffe Mocha" => [["Espresso", 1], ["Cocoa", 1], ["Steamed Milk", 1], ["Whipped Cream", 1]],
                    "Cappuccino" => [["Espresso", 2], ["Steamed Milk", 1], ["Foamed Milk", 1]]
    }

    @display = BaristaView.new
  end

  def update_inventory(name, quantity)
    inventory[name] -= quantity
  end

  def calculate_price(drink)
    total = 0
    ingredients[drink].each do |ingredient|
      total += (costs[ingredient[0]] * ingredient[1])
    end
    total.round(2)
  end

  def in_stock?(drink)
    ingredients[drink].each do |ingredient|
      return false if inventory[ingredient[0]] < ingredient[1]
    end
    return true
  end

  def restock_inventory
    inventory.each do |name, quantity|
      inventory[name] = 10
    end
  end

  def generate_menu
    menu = []
    drinks = ingredients.keys
    for i in 0..(drinks.length-1)
      menu[i] = "#{i+1},#{drinks[i]},$#{calculate_price(drinks[i])},#{in_stock?(drinks[i])}"
    end
    menu
  end

  def drink_selection(number)
    drinks = ingredients.keys
    drinks[number.to_i-1]
  end

  def dispense_drink(drink)
    ingredients[drink].each do |ingredient|
      update_inventory(ingredient[0], ingredient[1])
    end
  end

  def define_commands(command)
    if command == "Q" || command == "q"
      display.quit_screen
      exit
    elsif command == "R" || command == "r"
      display.display_restock_inventory
      restock_inventory
    elsif ["1", "2", "3", "4", "5", "6"].include?(command)
      drink = drink_selection(command)
      if in_stock?(drink)
        display.display_drink_selection(drink)
        dispense_drink(drink)
      else
        display.display_out_of_stock(drink)
      end
    end
  end

  def valid_command?(command)
    ["1", "2", "3", "4", "5", "6", "R", "r", "Q", "q"].include?(command)
  end

  def get_user_selection
    valid_command = false
    until valid_command
      selection = display.get_user_input
      valid_command = valid_command?(selection)
      display.display_invalid_command(selection) if valid_command == false
    end
    selection
  end

  def begin_brewing
    display.display_name
    display.display_inventory(inventory)
    display.display_menu(generate_menu)
    while true
      selection = get_user_selection
      define_commands(selection)
      display.display_inventory(inventory)
      display.display_menu(generate_menu)
    end
  end

end