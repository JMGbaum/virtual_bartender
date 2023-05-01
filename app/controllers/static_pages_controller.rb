class StaticPagesController < ApplicationController
  def home
    @recommendation = []
    if logged_in? 
      if current_user.user_recipes.where(liked: true).count > 2 && current_user.user_recipes.where(liked: false).count > 2
        u = current_user
        Recipe.where.not(id: u.recipes.ids).each do |recipe|
          break if @recommendation.length() >= 5
            if u.predict_recipe(recipe) == "recommended"
              @recommendation.append(recipe)
            end
          end 
      end  
    end  
  end
end
