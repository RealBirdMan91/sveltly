defmodule SveltlyWeb.RaffleLive.Show do
  use SveltlyWeb, :live_view
  alias Sveltly.Raffles

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _uri, socket) do
    raffle = Raffles.get_raffle!(id)

    socket =
      socket
      |> assign(:raffle, raffle)
      |> assign(:page_title, raffle.prize)
      |> assign_async(:featured_raffles, fn ->
        {:ok, %{featured_raffles: Raffles.featured_raffles(raffle)}}
      end)

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <.svelte
      name="pages/raffles/id/Page"
      socket={@socket}
      props={
        %{
          raffle: @raffle,
          featured_raffles: %{
            loading: @featured_raffles.loading,
            failed: @featured_raffles.failed,
            result: @featured_raffles.result
          }
        }
      }
    />
    """
  end
end
