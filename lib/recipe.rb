class Recipe
  attr_reader :name, :description, :prep_time, :done

  def initialize(attrs = {})
    @name = attrs[:name]
    @description = attrs[:description]
    @prep_time = attrs[:prep_time]
    @done = ( attrs[:done] == "true" ? true : false)
  end


  def mark_as_done!
    @done = true
  end


  def done?
    @done
  end

end
