defmodule OfertasCursoWeb.HomeController do
  use OfertasCursoWeb, :controller

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, params) do
    conn
    |> json(%{"message": "Offers Sample Rest API"})
  end
end
