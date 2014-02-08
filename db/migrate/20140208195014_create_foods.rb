class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|

      # Add the USDA fields
      Food::USDA_ABBRIV_FIELDS.each do |k,v|
        t.send(v, k)
      end

      t.timestamps
    end

    reversible do |t|
      t.up do
        change_column :foods, :ndb_number, :string, null: false
        add_index :foods, [:ndb_number], unique: true
      end
    end

  end

end
