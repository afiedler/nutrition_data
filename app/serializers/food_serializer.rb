class FoodSerializer < ActiveModel::Serializer
  attributes :id, :short_desc, :vitamins, :macronutrients

  VITAMIN_FIELDS = [:calcium, :iron, :magnesium, :phosphorus, :sodium, :zinc, :copper, :manganese,
    :selenium, :vitamin_c, :thiamin, :riboflavin, :niacin, :panto_acid, :vitamin_b6, :total_folate,
    :folic_acid, :food_folate, :folate, :choline, :vitamin_b12, :vitamin_a_iu, :vitamin_a_rae,
    :retinol, :alpha_carot, :beta_carot, :lycopene, :lutein, :vitamin_e, :vitamin_d_mcg,
    :vitamin_d_iu, :vitamin_k]

  MACRO_FIELDS = [:kcal, :protein, :total_fat, :carbs, :total_fiber, :sugar, :cholesterol]

  FAT_FIELDS = [:saturated_fat, :monounsaturated_fat, :polyunsaturated_fat]

  def vitamins
    grouped_attributes(VITAMIN_FIELDS)
  end

  def macronutrients
    grouped_attributes(MACRO_FIELDS)
  end

  def fats
    grouped_attributes(MACRO_FIELDS)
  end

  protected

  def grouped_attributes(list)
    list.map do |v|
      r = {}
      r[v] = object.send(v) unless (object.send(v).nil? || object.send(v) == 0.0)
      r
    end.reduce(:merge)
  end

end
