defmodule Ecohabits.Habits do
  import Ecto.Query

  alias Ecohabits.Repo
<<<<<<< HEAD
  alias Ecohabits.Habits.Habit

  def list_habits(user_id) do
    Repo.all(
      from h in Habit,
      where: h.user_id == ^user_id
    )
  end

  def list_habits_by_category(user_id, category) do
    Repo.all(
      from h in Habit,
      where:
        h.user_id == ^user_id and
        h.category == ^category
    )
  end

  def get_habit!(id, user_id) do
    Repo.get_by!(
      Habit,
      id: id,
      user_id: user_id
    )
  end

  def create_habit(attrs) do
    %Habit{}
    |> Habit.changeset(attrs)
    |> Repo.insert()
  end

  def update_habit(habit, attrs) do
    habit
    |> Habit.changeset(attrs)
    |> Repo.update()
  end

  def delete_habit(habit) do
    Repo.delete(habit)
=======
  alias Ecohabits.Habits.CheckIn

  def create_check_in(user) do
    today = Date.utc_today()

    %CheckIn{}
    |> CheckIn.changeset(%{
      date: today,
      user_id: user.id
    })
    |> Repo.insert()
  end

  def list_user_check_ins(user) do
    Repo.all(
      from(c in CheckIn,
        where: c.user_id == ^user.id,
        order_by: [desc: c.date]
      )
    )
  end

  def weekly_points(user) do
    start_of_week =
      Date.beginning_of_week(Date.utc_today())

    Repo.aggregate(
      from(c in CheckIn,
        where:
          c.user_id == ^user.id and
            c.date >= ^start_of_week
      ),
      :count
    ) * 10
>>>>>>> c2ac2f3ca016be063c061f27fd4a1625f9654a36
  end
end
