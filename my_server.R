library(shiny)

my_server <- function(input, output) {}

# input parameters

entry_price <- 11000
exit_price <- 120

leverage <- 20

asset_quantity <- 1

maintenance_margin_rate <- 0.0065 #(https://www.binance.com/en/support/faq/360033162192 refer this website for rate brackets)

#~~~~~~~~~~~~~~~

#output parameters

initial_margin <- entry_price * asset_quantity / leverage

net_profit <- (exit_price - entry_price) * asset_quantity

net_return_percentage <- (net_profit / initial_margin) * 100

# liquidation price includes other factors as well.
initial_liquidation_price <- entry_price - (entry_price / leverage)

maintenance_margin <- entry_price * maintenance_margin_rate

final_liquidation_price <- initial_liquidation_price + maintenance_margin