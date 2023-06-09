class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    # @recipes = policy_scope(Recipe)
    @recipes = Recipe.all
    @meal_days = user_signed_in? ? current_user.meal_days : []
  end
end
