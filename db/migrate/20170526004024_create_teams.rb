class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.text :mission
      t.text :vision

      t.timestamps
    end
  end
end
