# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email, null: false, index: true
      t.string :password_digest, null: false
      t.string :avatar

      t.timestamps
    end
  end
end
