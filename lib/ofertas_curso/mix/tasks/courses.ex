defmodule Mix.Tasks.Courses do
  use Mix.Task

  @spec run(any) :: nil | Mongo.InsertManyResult.t()
  def run(_) do
    Application.ensure_all_started(:ofertas_curso)
    courses =
      "db.json"
      |> File.read!()
      |> Jason.decode!()
      |> Enum.map(fn offer ->
        offer["course"]
        |> Map.put("university", offer["university"])
        |> Map.put("campus", offer["campus"])
      end)
    Mongo.insert_many!(:mongo, "courses", courses)
  end
end
