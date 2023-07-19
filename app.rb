require "sinatra"
require "sinatra/reloader"
require "open-uri"
require "json"
require "http"


currency_exchange_url = "https://api.exchangerate.host/convert?from=USD&to=INR"

all_symbols_url = "https://api.exchangerate.host/symbols"

symbols_data = URI.open(all_symbols_url).read

parse_symbols_data = JSON.parse(symbols_data)

filtered_symbolds_data = parse_symbols_data.fetch("symbols")

get("/") do
  @keys = filtered_symbolds_data.keys

  erb(:homepage)
end

get("/:symbol") do
  @symbol = params.fetch("symbol")
  @keys = filtered_symbolds_data.keys
  

  erb(:symbol)
end
