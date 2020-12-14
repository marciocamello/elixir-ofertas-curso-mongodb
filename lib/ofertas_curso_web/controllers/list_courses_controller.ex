defmodule OfertasCursoWeb.ListCoursesController do
  use OfertasCursoWeb, :controller

  def encode(id) do
    BSON.ObjectId.encode!(id)
  end

  def index(conn, params) do
    response =
      Mongo.find(:mongo, "courses", params)
      |> Enum.to_list()
      |> Enum.map(fn course ->
        course
        |> Map.put("_id", course["_id"] |> encode)
      end)

    conn
    |> json(response)
  end
end
