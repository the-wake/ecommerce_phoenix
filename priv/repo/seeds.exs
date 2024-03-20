# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ecommerce.Repo.insert!(%Ecommerce.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Custom seeds for the Category schema in our Catalog context.
for title <- ["Home Improvement", "Power Tools", "Gardening", "Books", "Education"] do
  {:ok, _} = Ecommerce.Catalog.create_category(%{title: title})
end
