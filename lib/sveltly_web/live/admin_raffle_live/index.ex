defmodule SveltlyWeb.AdminRaffleLive.Index do
  use SveltlyWeb, :live_view
  alias Sveltly.Admin

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:page_title, "Listing Raffles")
      |> assign(:raffles, Admin.list_raffles())

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.svelte
      name="pages/admin/raffles/Page"
      socket={@socket}
      props={
        %{
          raffles: @raffles
        }
      }
    />
    """
  end
end
