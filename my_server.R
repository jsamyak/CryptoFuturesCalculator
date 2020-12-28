library(shiny)

my_server <- function(input, output) {
  output$initial_margin <- renderText({
    input$entry_price * input$asset_quantity / input$leverage
  })
}

# input parameters

entry_price <- 100000
exit_price <- 120

leverage <- 20

asset_quantity <- 1

maintenance_margin_rate <- 0.02 #(https://www.binance.com/en/support/faq/360033162192 refer this website for rate brackets)

#~~~~~~~~~~~~~~~

#output parameters

initial_margin <- entry_price * asset_quantity / leverage

net_profit <- (exit_price - entry_price) * asset_quantity

net_return_percentage <- (net_profit / initial_margin) * 100

initial_liquidation_price <- entry_price - (entry_price / leverage)

maintenance_margin <- entry_price * maintenance_margin_rate

# liquidation price includes other factors as well. The below price is slightly higher than actual
final_liquidation_price <- initial_liquidation_price + maintenance_margin
