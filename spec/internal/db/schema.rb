ActiveRecord::Schema.define do
  create_table :authors do |t|
    t.string :first_name, null: false
    t.string :last_name, null: false
  end

  create_table :posts do |t|
    t.integer :author_id, null: false
    t.string  :title
    t.text    :body
    t.boolean :published, default: true
  end

  create_table :tags do |t|
    t.string :name
  end

  create_table :post_tags do |t|
    t.integer :post_id
    t.integer :tag_id
  end
end
