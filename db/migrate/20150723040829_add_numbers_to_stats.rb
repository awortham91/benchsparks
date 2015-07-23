class AddNumbersToStats < ActiveRecord::Migration
  def change
    add_column :userquestionstats, :onecorrect, :integer, :default => 0
    add_column :userquestionstats, :onetotal, :integer, :default => 0
    add_column :userquestionstats, :twocorrect, :integer, :default => 0
    add_column :userquestionstats, :twototal, :integer, :default => 0
    add_column :userquestionstats, :threecorrect, :integer, :default => 0
    add_column :userquestionstats, :threetotal, :integer, :default => 0
    add_column :userquestionstats, :fourcorrect, :integer, :default => 0
    add_column :userquestionstats, :fourtotal, :integer, :default => 0
    add_column :userquestionstats, :fivecorrect, :integer, :default => 0
    add_column :userquestionstats, :fivetotal, :integer, :default => 0
    add_column :userquestionstats, :sixcorrect, :integer, :default => 0
    add_column :userquestionstats, :sixtotal, :integer, :default => 0
    add_column :userquestionstats, :sevencorrect, :integer, :default => 0
    add_column :userquestionstats, :seventotal, :integer, :default => 0
    add_column :userquestionstats, :eightcorrect, :integer, :default => 0
    add_column :userquestionstats, :eighttotal, :integer, :default => 0
    add_column :userquestionstats, :ninecorrect, :integer, :default => 0
    add_column :userquestionstats, :ninetotal, :integer, :default => 0
  end
end
