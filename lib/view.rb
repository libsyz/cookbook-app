class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      done = recipe.done? ? "[X]" : "[ ]"
      puts "#{done} #{recipe.name}: #{recipe.description} --- #{recipe.prep_time}"
    end
  end

  def ask_user_for(stuff)
    puts "#{stuff.capitalize}?"
    print "> "
    return gets.chomp
  end

  def ask_user_for_index
    puts "Index?"
    print "> "
    return gets.chomp.to_i - 1
  end


  def display_results(results)
    results.each_with_index do |noko_element, index|
      puts "#{index + 1}: #{noko_element.text.strip}"
    end
  end
end
