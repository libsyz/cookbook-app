require_relative "view"
require_relative "recipe"
require 'pry-byebug'
require_relative 'scraper'

class Controller

  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
    @scraper = Scraper.new
  end

  # USER ACTIONS

  def list
    display_recipes
  end

  def create
    name = @view.ask_user_for("name")
    description = @view.ask_user_for("description")
    prep_time = @view.ask_user_for("prep time?")
    recipe = Recipe.new(name: name, description: description, prep_time: prep_time)
    @cookbook.add(recipe)
    display_recipes
  end

  def destroy
    display_recipes
    index = @view.ask_user_for_index
    @cookbook.remove_at(index)
    display_recipes
  end

  def import
    search_for_recipes
    index = @view.ask_user_for_index
    selected_recipe = @scraper.select_recipe(index)
    attrs_hash = @scraper.recipe_attributes
    new_recipe = Recipe.new(attrs_hash)
    @cookbook.add(new_recipe)
  end

  def mark_as_done
    display_recipes
    index = @view.ask_user_for_index
    @cookbook.mark_recipe_as_done(index)
  end

  private

  def search_for_recipes
    keyword = @view.ask_user_for("please give me a keyword")
    @scraper.fetch_recipes(keyword)
    @view.display_results(@scraper.fetch_titles)

  end

  def display_recipes
    recipes = @cookbook.all
    @view.display(recipes)
  end
end
