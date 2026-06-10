defmodule EcohabitsWeb.HabitLive.Index do
  use EcohabitsWeb, :live_view

  alias Ecohabits.Habits

  @categories [
    "alimentação",
    "transporte",
    "energia",
    "água",
    "resíduos"
  ]

  def mount(_params, _session, socket) do
    user_id = socket.assigns.current_scope.user.id

    {:ok,
     socket
     |> assign(:categories, @categories)
     |> assign(:selected_category, "")
     |> assign(:habits, Habits.list_habits(user_id))}
  end

  def handle_event("filter", %{"category" => ""}, socket) do
    user_id = socket.assigns.current_scope.user.id

    {:noreply,
     socket
     |> assign(:selected_category, "")
     |> assign(:habits, Habits.list_habits(user_id))}
  end

  def handle_event("filter", %{"category" => category}, socket) do
    user_id = socket.assigns.current_scope.user.id

    {:noreply,
     socket
     |> assign(:selected_category, category)
     |> assign(
       :habits,
       Habits.list_habits_by_category(user_id, category)
     )}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    user_id = socket.assigns.current_scope.user.id

    habit =
      Habits.get_habit!(id, user_id)

    {:ok, _} =
      Habits.delete_habit(habit)

    habits =
      if socket.assigns.selected_category == "" do
        Habits.list_habits(user_id)
      else
        Habits.list_habits_by_category(
          user_id,
          socket.assigns.selected_category
        )
      end

    {:noreply,
     assign(socket, :habits, habits)}
  end
end
