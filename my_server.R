library(shiny)

source("calculations.R")

my_server <- function(input, output) {
  output$initial_margin <- renderText({
    c(initialMarginCalculator(input$entry_price, input$asset_quantity, input$leverage),
      "USDT")
  })
  
  output$profit_without_fees <- renderText({
    c(profitCalculator(input$entry_price, input$exit_price, input$asset_quantity),
      "USDT")
  })
  
  output$return_percentage <- renderText({
    c(profitCalculator(input$entry_price, input$exit_price, input$asset_quantity) /
      initialMarginCalculator(input$entry_price, input$asset_quantity, input$leverage) * 100,
      "%")
  })
  
  output$net_return_with_fees <- renderText({
    c((profitCalculator(input$entry_price, input$exit_price, input$asset_quantity) - 
         (individualFeeCalculator(input$trading_level,
                                  input$entry_maker_or_taker,
                                  input$entry_price,
                                  input$asset_quantity,
                                  input$bnb_fees) +
            individualFeeCalculator(input$trading_level,
                                    input$exit_maker_or_taker,
                                    input$exit_price,
                                    input$asset_quantity,
                                    input$bnb_fees))) / 
        initialMarginCalculator(input$entry_price, input$asset_quantity, input$leverage) * 
        100, 
      "%")
  })
  
  output$entry_fees <- renderText({
    c(individualFeeCalculator(input$trading_level,
                            input$entry_maker_or_taker,
                            input$entry_price,
                            input$asset_quantity,
                            input$bnb_fees),
      "USDT")
  })
  
  output$exit_fees <- renderText({
    c(individualFeeCalculator(input$trading_level,
                              input$exit_maker_or_taker,
                              input$exit_price,
                              input$asset_quantity,
                              input$bnb_fees),
      "USDT")
  })
  
  output$total_fees <- renderText({
    c(individualFeeCalculator(input$trading_level,
                              input$entry_maker_or_taker,
                              input$entry_price,
                              input$asset_quantity,
                              input$bnb_fees) +
        individualFeeCalculator(input$trading_level,
                              input$exit_maker_or_taker,
                              input$exit_price,
                              input$asset_quantity,
                              input$bnb_fees), 
      "USDT")
  })
  
  output$net_profit_with_fees <- renderText({
    c(profitCalculator(input$entry_price, input$exit_price, input$asset_quantity) - 
        (individualFeeCalculator(input$trading_level,
                                 input$entry_maker_or_taker,
                                 input$entry_price,
                                 input$asset_quantity,
                                 input$bnb_fees) +
           individualFeeCalculator(input$trading_level,
                                   input$exit_maker_or_taker,
                                   input$exit_price,
                                   input$asset_quantity,
                                   input$bnb_fees)), 
      "USDT")
  })
  
  output$return_exit_price <- renderTable({
    temp_matrix <- matrix(c(10,43,
                            25,92,
                            50,21,
                            75,22,
                            100,1,
                            125,1,
                            150,1),ncol=2,byrow=TRUE)
    colnames(temp_matrix) <- c("Return Percentage (in %)",
                               "Exit Price Required (in USDT)")
    return(temp_matrix)
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
