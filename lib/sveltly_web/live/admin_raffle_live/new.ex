defmodule SveltlyWeb.AdminRaffleLive.New do
  use SveltlyWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.svelte name="pages/admin/raffles/new/Page" socket={@socket} />
    """
  end
end
