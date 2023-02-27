require "test_helper"

class IngredientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup 
    @ingredient = Ingredient.new(name: "Liquor1", is_alcoholic: 1, size:"1", purchase_url:"aaa.com")
  end

  test "should be valid" do
    assert @ingredient.valid?
  end

  test "name should be present" do
    @ingredient.name = "     "
    assert_not @ingredient.valid?
  end
end
