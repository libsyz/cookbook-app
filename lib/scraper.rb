require 'open-uri'
require 'nokogiri'
require 'pry-byebug'

class Scraper
  attr_reader :recipes

    RECIPES_PATH = ".node.node-recipe.node-teaser-item.clearfix"
    ATTR_PATHS = {
      name: ".teaser-item__title",
      description: '.field-item.even',
      prep_time: '.teaser-item__info-item.teaser-item__info-item--total-time'
    }

  def initialize
    @base_url = "https://www.bbcgoodfood.com/search/recipes?query="
    @recipes = nil
    @selected_recipe = nil
  end


  def fetch_recipes(keyword)
    @recipes = call(keyword).search(RECIPES_PATH)
    @recipes
  end

  def fetch_titles
    @recipes.search(ATTR_PATHS[:name]).first(5)
  end

  def select_recipe(index)
    @selected_recipe = @recipes[index]
  end

  def recipe_attributes
    attr_hash = {}
    ATTR_PATHS.each_pair do |prop, path|
      attr_hash[prop] = @selected_recipe.search(path).text.strip
    end
    attr_hash
  end

  private

  def call(keyword)
    Nokogiri::HTML(open(@base_url + keyword))
  end
end
