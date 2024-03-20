defmodule Ecommerce.ShoppingCart.CartItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cart_items" do
    field :price_when_carted, :decimal
    field :quantity, :integer
    # Replaced with the join below.
    # field :cart_id, :id
    # field :product_id, :id

    # This gives each cart item access to both its cart through its (native) ShoppingCart context, AND to the product data by calling the Catalog context.
    belongs_to :cart, Ecommerce.ShoppingCart.Cart
    belongs_to :product, Ecommerce.Catalog.Product

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cart_item, attrs) do
    cart_item
    |> cast(attrs, [:price_when_carted, :quantity])
    |> validate_required([:price_when_carted, :quantity])
    # Added a new validator to constrain the quantity.
    |> validate_number(:quantity, greater_than_or_equal_to: 0, less_than: 100)
  end
end
