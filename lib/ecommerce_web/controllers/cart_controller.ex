# Custom module for handling dispatch of cart actions.

defmodule EcommerceWeb.CartController do
  use EcommerceWeb, :controller

  alias Ecommerce.ShoppingCart

  # Handler for the show action on the cart, which we've specified will be called by GET on /cart.
  def show(conn, _params) do
    render(conn, :show, changeset: ShoppingCart.change_cart(conn.assigns.cart))
  end

  def update(conn, %{"cart" => cart_params}) do
    case ShoppingCart.update_cart(conn.assigns.cart, cart_params) do
      {:ok, _cart} ->
        redirect(conn, to: ~p"/cart")

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "There was an error updating your cart")
        |> redirect(to: ~p"/cart")
    end
  end
end
