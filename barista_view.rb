class BaristaView

  def display_name
    puts ""
    puts "Welcome to BaristaMatic! Happy Brewing :)"
    puts "-"*100
  end

  def display_inventory(inventory)
    sleep(0.4)
    puts "Inventory:"
    inventory.each do |name, quantity|
      puts "  #{name},#{quantity}"
    end
  end

  def display_menu(generate_menu)
    sleep(0.4)
    puts "Menu:"
    generate_menu.each do |drink|
      puts "  #{drink}"
    end
  end

  def get_user_input
    sleep(0.4)
    puts ""
    puts "Please enter a drink number displayed, 'R' to restock, or 'Q' to quit BaristaMatic"
    puts ""
    gets.chomp
  end

  def display_invalid_command(command)
    puts ""
    puts "Invalid Selection: #{command}"
    puts ""
  end

  def display_drink_selection(name)
    puts ""
    puts "Dispensing: #{name}"
    puts ""
    sleep(0.2)
  end

  def display_out_of_stock(name)
    puts ""
    puts "Out of stock: #{name}"
    puts ""
    sleep(0.6)
  end

  def display_restock_inventory
    puts "*"*100
    puts "You have successfully restocked inventory."
    puts "*"*100
  end

  def quit_screen
    puts ""
    puts "*"*100
    puts "Thank you for using BaristaMatic. Have a great day!"
    puts "*"*100
  end

end
