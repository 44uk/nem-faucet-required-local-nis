Hanami::Model.migration do
  change do
    create_table :drawings do
      primary_key :id
      column :address, String , null: false
      column :amount , Integer, null: false
      column :message, String
      column :tx     , String , null: false
      column :ip     , String , null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
