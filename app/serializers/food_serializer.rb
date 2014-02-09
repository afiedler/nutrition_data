class FoodSerializer < ActiveModel::Serializer
  attributes :id, :short_desc, :vitamins, :macronutrients, :weights

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

  def weights
    r = []
    unless object.weight_1_desc.empty?
      r << { id: 1, name: object.weight_1_desc }
    end
    unless object.weight_2_desc.empty?
      r << { id: 2, name: object.weight_2_desc }
    end
    r
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
