defmodule Mix.Tasks.Gen.Types do
  use Mix.Task

  @shortdoc "Generiert TypeScript-Interfaces aus Ecto-Schemas"
  @moduledoc """
  Diese Task durchsucht alle Ecto-Schemas in deinem Projekt
  und erstellt für jedes eine passende TypeScript-Datei
  mit Interfaces.
  """

  def run(_args) do
    {:ok, modules} = :application.get_key(:sveltly, :modules)

    ecto_modules =
      modules
      |> Enum.filter(fn mod ->
        Code.ensure_loaded?(mod) and function_exported?(mod, :__schema__, 1)
      end)

    if ecto_modules == [] do
      Mix.shell().info("no ecto schemas found")
      System.halt(0)
    end

    base_output_path = "assets/svelte/types"
    File.mkdir_p!(base_output_path)

    for schema <- ecto_modules do
      schema_name = Module.split(schema) |> List.last()
      fields = schema_fields(schema)

      ts_code = to_ts_interface(schema_name, fields)
      file_name = Macro.underscore(schema_name) <> ".ts"
      file_path = Path.join(base_output_path, file_name)

      File.write!(file_path, ts_code)

      Mix.shell().info("Generiert: #{file_path}")
    end
  end

  defp schema_fields(schema) do
    schema.__schema__(:fields)
    |> Enum.map(fn field_name ->
      ecto_type = schema.__schema__(:type, field_name)
      {field_name, ecto_type_to_ts(ecto_type)}
    end)
  end

  defp ecto_type_to_ts(:string), do: "string"
  defp ecto_type_to_ts(:text), do: "string"
  defp ecto_type_to_ts(:binary), do: "string"
  defp ecto_type_to_ts(:integer), do: "number"
  defp ecto_type_to_ts(:float), do: "number"
  defp ecto_type_to_ts(:decimal), do: "number"
  defp ecto_type_to_ts(:id), do: "number"
  defp ecto_type_to_ts(:boolean), do: "boolean"
  defp ecto_type_to_ts(:utc_datetime), do: "string"
  defp ecto_type_to_ts(:naive_datetime), do: "string"
  defp ecto_type_to_ts(:utc_datetime_usec), do: "string"
  defp ecto_type_to_ts(:naive_datetime_usec), do: "string"

  defp ecto_type_to_ts({:parameterized, {Ecto.Enum, enum_opts}}) do
    case enum_opts[:mappings] do
      mappings when is_list(mappings) ->
        mappings |> Enum.map(fn {_atom, value} -> "'#{value}'" end) |> Enum.join(" | ")

      nil ->
        "string"

      _ ->
        "string"
    end
  end

  defp ecto_type_to_ts(_other), do: "any"

  defp to_ts_interface(name, fields) do
    # Wir bauen den Body aus Zeilen zusammen wie `title: string;`
    fields_text =
      Enum.map(fields, fn {field_name, ts_type} ->
        "  #{field_name}: #{ts_type};"
      end)
      |> Enum.join("\n")

    """
    /* Dies ist eine automatisch generierte Datei.
       Änderungen an diesem File könnten beim nächsten
       `mix gen.types` überschrieben werden!
    */
    export interface #{name} {
    #{fields_text}
    }
    """
  end
end
