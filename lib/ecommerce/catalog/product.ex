defmodule Ecommerce.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  # Added to alias Category in for the many_to_many function.
  alias Ecommerce.Catalog.Category

  schema "products" do
    field :description, :string
    field :title, :string
    field :price, :decimal
    field :views, :integer

    # Set up the relationship from within the schema.
    many_to_many :categories, Category, join_through: "product_categories", on_replace: :delete


    timestamps(type: :utc_datetime)
  end

  # @doc false specifies that while the following function is publically availab,e it's not part of the public context API and needs to be accessed through the parent conext (Catalog in this case).
  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:title, :description, :price, :views])
    # Removed views from the validate_required argument.
    |> validate_required([:title, :description, :price])
  end
end
