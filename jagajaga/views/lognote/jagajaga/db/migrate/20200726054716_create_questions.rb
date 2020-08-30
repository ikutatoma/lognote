class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
     create_table :questions do |t|
      t.string :title
      t.string :content
      t.string :date
      t.references :user
      t.references :course
      t.timestamps null: false
    end
  end
end
