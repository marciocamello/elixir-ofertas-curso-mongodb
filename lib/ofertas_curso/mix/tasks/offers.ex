defmodule Mix.Tasks.Offers do
  use Mix.Task

  @spec run(any) :: nil | Mongo.InsertManyResult.t()
  def run(_) do
    Application.ensure_all_started(:ofertas_curso)
    offers =
      "db.json"
      |> File.read!()
      |> Jason.decode!()
    Mongo.insert_many!(:mongo, "offers", offers)
  end
end
