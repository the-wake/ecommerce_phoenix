defmodule EcommerceWeb.ProductHTML do
  use EcommerceWeb, :html

  embed_templates "product_html/*"

  @doc """
  Renders a product form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def product_form(assigns)

  # Added to tie our categories to the product front-end.
  def category_opts(changeset) do
    existing_ids =
      changeset
      |> Ecto.Changeset.get_change(:categories, [])
      |> Enum.map(& &1.data.id)

    for cat <- Ecommerce.Catalog.list_categories(),
        do: [key: cat.title, value: cat.id, selected: cat.id in existing_ids]
  end
end
