class CreateUniversities < ActiveRecord::Migration[6.0]
  def change
    create_table :universities do |t|
      t.string :name
      t.string :description
      t.string :city
      t.timestamps
    end

    add_reference :groups, :university, index: true
  end
end
