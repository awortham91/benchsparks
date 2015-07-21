class CreateJoinTableUserGroup < ActiveRecord::Migration
  def change
    create_table 'usergroups' do |t|
      t.column 'user_id', :integer
      t.column 'group_id', :integer
    end
  end
end
