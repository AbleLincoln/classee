class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :major
      t.string :class1
      t.string :class2
      t.string :class3
      t.string :class4
      t.string :class5
      
      t.timestamps null: false
    end
  end
end
