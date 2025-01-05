defmodule SveltlyWeb.RaffleLive.Index do
  use SveltlyWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.svelte name="pages/raffles/Page" props={%{}} socket={@socket} />
    """
  end
end
