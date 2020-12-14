defmodule OfertasCursoWeb.ListOffersController do
  use OfertasCursoWeb, :controller

  def encode(id) do
    BSON.ObjectId.encode!(id)
  end

  def index(conn, params) do
    price_discount =
      params["price_discount"]

    order_by = (price_discount === nil && []) || [
      sort: %{
        price_with_discount: price_discount
          |> String.to_integer()
      }
    ]

    params =
      params
      |> Map.delete("price_discount")

    response =
      Mongo.find(:mongo, "offers", params, order_by)
      |> Enum.to_list()
      |> Enum.map(fn offer ->
        offer
        |> Map.put("_id", offer["_id"] |> encode)
      end)

    conn
    |> json(response)
  end
end
