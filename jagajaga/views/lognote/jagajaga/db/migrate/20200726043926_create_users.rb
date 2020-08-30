class CreateUsers < ActiveRecord::Migration[5.2]
  def change
       create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :password
      t.string :password_confirmation
      t.string :email
      t.string :simple_word
      t.string :color
      t.string :place
      t.references :task
      t.references :course
      t.timestamps null: false
    end
  end
end
