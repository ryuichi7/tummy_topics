class Recipe < ActiveRecord::Base
	belongs_to :user
	has_many :recipe_ingredients, dependent: :destroy
	has_many :ingredients, through: :recipe_ingredients
	has_many :comments, dependent: :destroy
	has_many :ratings, dependent: :destroy
	validates_presence_of :name, :description, :directions
	extend Concerns::Sortable

	def ingredients_attributes=(ingredients)
		recipe_ingredients.destroy_all if persisted?

		ingredients.each do |ingredient|
			unless ingredient[:name].blank?
				ingr_name = ingredient[:name]
				measurement = ingredient[:measurement]

				i = Ingredient.find_or_create_by(name: ingr_name.downcase.singularize)
					
				if !ingredients.include?(i)
					recipe_ingredients.build(ingredient: i, measurement: measurement, name: ingr_name)
				end
			end
		end
	end

	def directions_to_list
		directions.split(/\r\n/)
	end

	def self.search(params)
		joins(:ingredients).where("ingredients.name like :params OR recipes.name like :params", params: "%#{params.singularize}%").uniq 
	end

	def self.rating_search(params)
		joins(:ratings).where(ratings: {score: params})
	end

	def rating_avg
		ratings.average(:score).round(2) unless ratings.average(:score).nil?
	end

	def user_name
		user.email_name.humanize
	end
	
end


