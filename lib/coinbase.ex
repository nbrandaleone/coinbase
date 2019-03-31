defmodule Coinbase do
  @moduledoc """
  Documentation for Coinbase.
  """

  @coinbase_url "https://api.pro.coinbase.com"

  @doc """
  get_price.
  
  ## Examples

      iex> Coinbase.get_price("BTC-USD")
      "3847.32000000"

  """
  def get_price(product_id) do
    url = "#{@coinbase_url}/products/#{product_id}/ticker"

    %{"price" => price} =
      HTTPoison.get!(url).body
      |> Jason.decode!()

    price
  end

  @doc """
  print_price.

  ## Examples

      iex> ["BTC-USD", "ETH-USD", "LTC-USD", "BCH-USD"] \
           |> Enum.each( &Coinbase.print_price/1 )

      iex> ["BTC-USD", "ETH-USD", "LTC-USD", "BCH-USD"] \
           |> Enum.map(fn product_id->  
	     spawn(fn -> Coinbase.print_price(product_id) end)
           end)

  """
  def print_price(product_id) do
    start = System.monotonic_time(:millisecond)

    price = get_price(product_id)

    stop = System.monotonic_time(:millisecond)
    time = (stop - start) / 1000
    IO.puts("#{product_id}: #{price}\ttime: #{time}s")
  end

end
