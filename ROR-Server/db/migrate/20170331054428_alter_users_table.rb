class AlterUsersTable < ActiveRecord::Migration[5.0]
  def change
  	execute "alter table users ADD CONSTRAINT unique_email UNIQUE(email)"
  	execute "alter table users ADD COLUMN gender varchar(8),ADD COLUMN city varchar(20),ADD COLUMN state varchar(20),ADD COLUMN nationality varchar(20)"
  end
end
