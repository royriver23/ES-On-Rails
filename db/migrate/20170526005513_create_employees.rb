class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :identification
      t.boolean :active
      t.text :description
      t.datetime :birthday
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
