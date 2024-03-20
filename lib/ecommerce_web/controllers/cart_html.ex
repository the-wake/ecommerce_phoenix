# Custom module set up to embed the carat HEEx templates.

defmodule EcommerceWeb.CartHTML do
  use EcommerceWeb, :html

  alias Ecommerce.ShoppingCart

  embed_templates "cart_html/*"

  def currency_to_str(%Decimal{} = val), do: "$#{Decimal.round(val, 2)}"
end
