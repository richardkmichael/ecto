defmodule Ecto.Integration.IntervalTest do
  use Ecto.Integration.Case

  alias Ecto.Integration.Post
  alias Ecto.Integration.TestRepo
  import Ecto.Query

  @posted %Ecto.Date{year: 2014, month: 1, day: 1}
  @inserted_at %Ecto.DateTime{year: 2014, month: 1, day: 1,
                              hour: 2, min: 0, sec: 0, usec: 0}

  setup do
    TestRepo.insert!(%Post{posted: @posted, inserted_at: @inserted_at})
    :ok
  end

  test "date_add with year" do
    dec = Decimal.new(1)
    assert [{2015, 1, 1}] = TestRepo.all(from p in Post, select: date_add(p.posted, 1, "year"))
    assert [{2015, 1, 1}] = TestRepo.all(from p in Post, select: date_add(p.posted, 1.0, "year"))
    assert [{2015, 1, 1}] = TestRepo.all(from p in Post, select: date_add(p.posted, ^1, "year"))
    assert [{2015, 1, 1}] = TestRepo.all(from p in Post, select: date_add(p.posted, ^1.0, "year"))
    assert [{2015, 1, 1}] = TestRepo.all(from p in Post, select: date_add(p.posted, ^dec, "year"))
  end

  test "date_add with month" do
    dec = Decimal.new(3)
    assert [{2014, 4, 1}] = TestRepo.all(from p in Post, select: date_add(p.posted, 3, "month"))
    assert [{2014, 4, 1}] = TestRepo.all(from p in Post, select: date_add(p.posted, 3.0, "month"))
    assert [{2014, 4, 1}] = TestRepo.all(from p in Post, select: date_add(p.posted, ^3, "month"))
    assert [{2014, 4, 1}] = TestRepo.all(from p in Post, select: date_add(p.posted, ^3.0, "month"))
    assert [{2014, 4, 1}] = TestRepo.all(from p in Post, select: date_add(p.posted, ^dec, "month"))
  end

  test "date_add with week" do
    dec = Decimal.new(3)
    assert [{2014, 1, 22}] = TestRepo.all(from p in Post, select: date_add(p.posted, 3, "week"))
    assert [{2014, 1, 22}] = TestRepo.all(from p in Post, select: date_add(p.posted, 3.0, "week"))
    assert [{2014, 1, 22}] = TestRepo.all(from p in Post, select: date_add(p.posted, ^3, "week"))
    assert [{2014, 1, 22}] = TestRepo.all(from p in Post, select: date_add(p.posted, ^3.0, "week"))
    assert [{2014, 1, 22}] = TestRepo.all(from p in Post, select: date_add(p.posted, ^dec, "week"))
  end

  test "date_add with day" do
    dec = Decimal.new(5)
    assert [{2014, 1, 6}] = TestRepo.all(from p in Post, select: date_add(p.posted, 5, "day"))
    assert [{2014, 1, 6}] = TestRepo.all(from p in Post, select: date_add(p.posted, 5.0, "day"))
    assert [{2014, 1, 6}] = TestRepo.all(from p in Post, select: date_add(p.posted, ^5, "day"))
    assert [{2014, 1, 6}] = TestRepo.all(from p in Post, select: date_add(p.posted, ^5.0, "day"))
    assert [{2014, 1, 6}] = TestRepo.all(from p in Post, select: date_add(p.posted, ^dec, "day"))
  end

  test "date_add with hour" do
    dec = Decimal.new(48)
    assert [{2014, 1, 3}] = TestRepo.all(from p in Post, select: date_add(p.posted, 48, "hour"))
    assert [{2014, 1, 3}] = TestRepo.all(from p in Post, select: date_add(p.posted, 48.0, "hour"))
    assert [{2014, 1, 3}] = TestRepo.all(from p in Post, select: date_add(p.posted, ^48, "hour"))
    assert [{2014, 1, 3}] = TestRepo.all(from p in Post, select: date_add(p.posted, ^48.0, "hour"))
    assert [{2014, 1, 3}] = TestRepo.all(from p in Post, select: date_add(p.posted, ^dec, "hour"))
  end

  test "date_add with dynamic" do
    posted = @posted
    assert [{2015, 1, 1}]  = TestRepo.all(from p in Post, select: date_add(^posted, ^1, ^"year"))
    assert [{2014, 4, 1}]  = TestRepo.all(from p in Post, select: date_add(^posted, ^3, ^"month"))
    assert [{2014, 1, 22}] = TestRepo.all(from p in Post, select: date_add(^posted, ^3, ^"week"))
    assert [{2014, 1, 6}]  = TestRepo.all(from p in Post, select: date_add(^posted, ^5, ^"day"))
    assert [{2014, 1, 3}]  = TestRepo.all(from p in Post, select: date_add(^posted, ^48, ^"hour"))
  end

  test "date_add with negative interval" do
    dec = Decimal.new(-1)
    assert [{2013, 1, 1}] = TestRepo.all(from p in Post, select: date_add(p.posted, -1, "year"))
    assert [{2013, 1, 1}] = TestRepo.all(from p in Post, select: date_add(p.posted, -1.0, "year"))
    assert [{2013, 1, 1}] = TestRepo.all(from p in Post, select: date_add(p.posted, ^-1, "year"))
    assert [{2013, 1, 1}] = TestRepo.all(from p in Post, select: date_add(p.posted, ^-1.0, "year"))
    assert [{2013, 1, 1}] = TestRepo.all(from p in Post, select: date_add(p.posted, ^dec, "year"))
  end

  test "datetime_add with year" do
    dec = Decimal.new(1)
    assert [{{2015, 1, 1}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, 1, "year"))
    assert [{{2015, 1, 1}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, 1.0, "year"))
    assert [{{2015, 1, 1}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^1, "year"))
    assert [{{2015, 1, 1}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^1.0, "year"))
    assert [{{2015, 1, 1}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^dec, "year"))
  end

  test "datetime_add with month" do
    dec = Decimal.new(3)
    assert [{{2014, 4, 1}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, 3, "month"))
    assert [{{2014, 4, 1}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, 3.0, "month"))
    assert [{{2014, 4, 1}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^3, "month"))
    assert [{{2014, 4, 1}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^3.0, "month"))
    assert [{{2014, 4, 1}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^dec, "month"))
  end

  test "datetime_add with week" do
    dec = Decimal.new(3)
    assert [{{2014, 1, 22}, _}] =
            TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, 3, "week"))
    assert [{{2014, 1, 22}, _}] =
            TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, 3.0, "week"))
    assert [{{2014, 1, 22}, _}] =
            TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^3, "week"))
    assert [{{2014, 1, 22}, _}] =
            TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^3.0, "week"))
    assert [{{2014, 1, 22}, _}] =
            TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^dec, "week"))
  end

  test "datetime_add with day" do
    dec = Decimal.new(5)
    assert [{{2014, 1, 6}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, 5, "day"))
    assert [{{2014, 1, 6}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, 5.0, "day"))
    assert [{{2014, 1, 6}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^5, "day"))
    assert [{{2014, 1, 6}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^5.0, "day"))
    assert [{{2014, 1, 6}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^dec, "day"))
  end

  test "datetime_add with hour" do
    dec = Decimal.new(60)
    assert [{{2014, 1, 3}, {14, 0, 0, 0}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, 60, "hour"))
    assert [{{2014, 1, 3}, {14, 0, 0, 0}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, 60.0, "hour"))
    assert [{{2014, 1, 3}, {14, 0, 0, 0}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^60, "hour"))
    assert [{{2014, 1, 3}, {14, 0, 0, 0}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^60.0, "hour"))
    assert [{{2014, 1, 3}, {14, 0, 0, 0}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^dec, "hour"))
  end

  test "datetime_add with minute" do
    dec = Decimal.new(90)
    assert [{{2014, 1, 1}, {3, 30, 0, 0}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, 90, "minute"))
    assert [{{2014, 1, 1}, {3, 30, 0, 0}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, 90.0, "minute"))
    assert [{{2014, 1, 1}, {3, 30, 0, 0}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^90, "minute"))
    assert [{{2014, 1, 1}, {3, 30, 0, 0}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^90.0, "minute"))
    assert [{{2014, 1, 1}, {3, 30, 0, 0}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^dec, "minute"))
  end

  test "datetime_add with second" do
    dec = Decimal.new(90)
    assert [{{2014, 1, 1}, {2, 1, 30, 0}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, 90, "second"))
    assert [{{2014, 1, 1}, {2, 1, 30, 0}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, 90.0, "second"))
    assert [{{2014, 1, 1}, {2, 1, 30, 0}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^90, "second"))
    assert [{{2014, 1, 1}, {2, 1, 30, 0}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^90.0, "second"))
    assert [{{2014, 1, 1}, {2, 1, 30, 0}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^dec, "second"))
  end

  @tag :uses_usec
  test "datetime_add with millisecond" do
    dec = Decimal.new(1500)
    assert [{{2014, 1, 1}, {2, 0, 1, 500_000}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, 1500, "millisecond"))
    assert [{{2014, 1, 1}, {2, 0, 1, 500_000}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, 1500.0, "millisecond"))
    assert [{{2014, 1, 1}, {2, 0, 1, 500_000}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^1500, "millisecond"))
    assert [{{2014, 1, 1}, {2, 0, 1, 500_000}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^1500.0, "millisecond"))
    assert [{{2014, 1, 1}, {2, 0, 1, 500_000}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^dec, "millisecond"))
  end

  @tag :uses_usec
  test "datetime_add with microsecond" do
    dec = Decimal.new(1500)
    assert [{{2014, 1, 1}, {2, 0, 0, 1500}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, 1500, "microsecond"))
    assert [{{2014, 1, 1}, {2, 0, 0, 1500}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, 1500.0, "microsecond"))
    assert [{{2014, 1, 1}, {2, 0, 0, 1500}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^1500, "microsecond"))
    assert [{{2014, 1, 1}, {2, 0, 0, 1500}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^1500.0, "microsecond"))
    assert [{{2014, 1, 1}, {2, 0, 0, 1500}}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^dec, "microsecond"))
  end

  test "datetime_add with dynamic" do
    inserted_at = @inserted_at
    assert [{{2015, 1, 1}, _}]  =
           TestRepo.all(from p in Post, select: datetime_add(^inserted_at, ^1, ^"year"))
    assert [{{2014, 4, 1}, _}]  =
           TestRepo.all(from p in Post, select: datetime_add(^inserted_at, ^3, ^"month"))
    assert [{{2014, 1, 22}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(^inserted_at, ^3, ^"week"))
    assert [{{2014, 1, 6}, _}]  =
           TestRepo.all(from p in Post, select: datetime_add(^inserted_at, ^5, ^"day"))
    assert [{{2014, 1, 3}, {14, 0, 0, 0}}] =
           TestRepo.all(from p in Post, select: datetime_add(^inserted_at, ^60, ^"hour"))
    assert [{{2014, 1, 1}, {3, 30, 0, 0}}] =
           TestRepo.all(from p in Post, select: datetime_add(^inserted_at, ^90, ^"minute"))
    assert [{{2014, 1, 1}, {2, 1, 30, 0}}] =
           TestRepo.all(from p in Post, select: datetime_add(^inserted_at, ^90, ^"second"))
  end

  test "datetime_add with negative interval" do
    dec = Decimal.new(-1)
    assert [{{2013, 1, 1}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, -1, "year"))
    assert [{{2013, 1, 1}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, -1.0, "year"))
    assert [{{2013, 1, 1}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^-1, "year"))
    assert [{{2013, 1, 1}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^-1.0, "year"))
    assert [{{2013, 1, 1}, _}] =
           TestRepo.all(from p in Post, select: datetime_add(p.inserted_at, ^dec, "year"))
  end
end
