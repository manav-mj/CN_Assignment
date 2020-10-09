class AddSolutionToDoubts < ActiveRecord::Migration[5.1]
  def change
    add_column :doubts, :solution, :text
  end
end
