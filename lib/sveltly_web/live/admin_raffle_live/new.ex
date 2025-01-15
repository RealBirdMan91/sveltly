defmodule SveltlyWeb.AdminRaffleLive.New do
  use SveltlyWeb, :live_view
  alias Sveltly.Admin
  alias Sveltly.Raffles.Raffle

  def mount(_params, _session, socket) do
    changeset = Raffle.changeset(%Raffle{}, %{})

    socket =
      socket
      |> assign(:page_title, "New Raffle")
      |> assign(:form, changeset)

    {:ok, socket}
  end

  def handle_event("create_raffle", %{"raffle" => raffle_params}, socket) do
    case Admin.create_raffle(raffle_params) do
      {:ok, _raffle} ->
        socket =
          socket
          |> put_flash(:info, "Raffle created successfully.")
          |> push_navigate(to: ~p"/admin/raffles")

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = _changeset} ->
        put_flash(socket, :error, "Error creating raffle.")
        {:noreply, socket}
    end
  end

  def render(assigns) do
    ~H"""
    <.svelte
      name="pages/admin/raffles/new/Page"
      socket={@socket}
      props={
        %{
          defaultFormValues: @form.data
        }
      }
    />
    """
  end
end
