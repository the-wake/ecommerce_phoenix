defmodule EcommerceWeb.ProductController do
  use EcommerceWeb, :controller

  alias Ecommerce.Catalog
  alias Ecommerce.Catalog.Product

  def index(conn, _params) do
    products = Catalog.list_products()
    render(conn, :index, products: products)
  end

  def new(conn, _params) do
    changeset = Catalog.change_product(%Product{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"product" => product_params}) do
    case Catalog.create_product(product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: ~p"/products/#{product}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  # Default version of function.
  # def show(conn, %{"id" => id}) do
  #   product = Catalog.get_product!(id)
  #   render(conn, :show, product: product)
  # end

  # New version of function, updated to encapsulate the product queried and send it as an argument to the inc_page_views/1 function. We pipe the value into get product, and pipe that into inc_page_views.
  def show(conn, %{"id" => id}) do
    product =
      id
      |> Catalog.get_product!()
      |> Catalog.inc_page_views()

    render(conn, :show, product: product)
  end


  def edit(conn, %{"id" => id}) do
    product = Catalog.get_product!(id)
    changeset = Catalog.change_product(product)
    render(conn, :edit, product: product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Catalog.get_product!(id)

    case Catalog.update_product(product, product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: ~p"/products/#{product}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, product: product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Catalog.get_product!(id)
    {:ok, _product} = Catalog.delete_product(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: ~p"/products")
  end
end
