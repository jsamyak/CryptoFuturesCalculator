library(shiny)

my_server <- function(input, output) {
  output$initial_margin <- renderText({
    c(initialMarginCalculator(input$entry_price, input$asset_quantity, input$leverage),
      "USDT")
  })
  
  output$net_profit <- renderText({
    c(netProfitCalculator(input$entry_price, input$exit_price, input$asset_quantity),
      "USDT")
  })
  
  output$net_return_percentage <- renderText({
    c(netProfitCalculator(input$entry_price, input$exit_price, input$asset_quantity) /
      initialMarginCalculator(input$entry_price, input$asset_quantity, input$leverage) *100,
      "%")
  })
  
  output$initial_liquidation_price <- renderText({
    c(initialLiquidationPriceCalculator(input$entry_price, input$leverage),
      "USDT")
  })
}

initialMarginCalculator <- function(entryPrice, assetQuantity, leverage) {
  return (entryPrice * assetQuantity / leverage)
}

netProfitCalculator <- function(entryPrice, exitPrice, assetQuantity) {
  return ((exitPrice - entryPrice) * assetQuantity)
}

initialLiquidationPriceCalculator <- function(entryPrice, leverage){
  return(entryPrice - (entryPrice / leverage))
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
