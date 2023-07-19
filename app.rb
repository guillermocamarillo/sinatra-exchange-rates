require "sinatra"
require "sinatra/reloader"
require "open-uri"
require "json"
require "http"


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

get("/:convertFrom/:convertTo") do
  @convertFrom = params.fetch("convertFrom")
  @convertTo = params.fetch("convertTo")

  exhange_url = "https://api.exchangerate.host/convert?from=#{@convertFrom}&to=#{@convertTo}"

  exchange_data = URI.open(exhange_url).read

  exhange_data_json = JSON.parse(exchange_data)
  
  @exhangeResult = exhange_data_json.fetch("result")

  erb(:exchange)
end
