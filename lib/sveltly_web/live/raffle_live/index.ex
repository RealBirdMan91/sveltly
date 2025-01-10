defmodule SveltlyWeb.RaffleLive.Index do
  use SveltlyWeb, :live_view
  alias Sveltly.Raffles

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(params, _uri, socket) do
    socket = socket |> assign(:raffles, Raffles.filter_raffles(params)) |> assign(:params, params)

    {:noreply, socket}
  end

  def handle_event("filter", params, socket) do
    params =
      params
      |> Map.take(~w(query status sort_by))
      |> Map.reject(fn {_, v} -> v in ["", nil] end)

    socket = push_patch(socket, to: ~p"/raffles?#{params}")
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <.svelte
      name="pages/raffles/Page"
      props={
        %{
          raffles: @raffles,
          params: %{
            query: @params["query"] || "",
            status: @params["status"] || "",
            sort_by: @params["sort_by"] || ""
          }
        }
      }
      socket={@socket}
    />
    """
  end
end
