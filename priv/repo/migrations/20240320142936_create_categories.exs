defmodule Ecommerce.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :title, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:categories, [:title])
  end
end

defmodule Ecommerce.Repo.Migrations.CreateProductCategories do
  use Ecto.Migration

  def change do
    create table(:product_categories, primary_key: false) do
      add :product_id, references(:products, on_delete: :delete_all)
      add :category_id, references(:categories, on_delete: :delete_all)
    end
  end
end
