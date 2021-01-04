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
    temp_matrix <- matrix(c(input$expected_return,returnExitPriceCalculator(input$expected_return, input$entry_price, input$leverage),
                            10,returnExitPriceCalculator(10, input$entry_price, input$leverage),
                            25,returnExitPriceCalculator(25, input$entry_price, input$leverage),
                            50,returnExitPriceCalculator(50, input$entry_price, input$leverage),
                            75,returnExitPriceCalculator(75, input$entry_price, input$leverage),
                            100,returnExitPriceCalculator(100, input$entry_price, input$leverage),
                            125,returnExitPriceCalculator(125, input$entry_price, input$leverage),
                            150,returnExitPriceCalculator(150, input$entry_price, input$leverage),
                            175,returnExitPriceCalculator(175, input$entry_price, input$leverage),
                            200,returnExitPriceCalculator(200, input$entry_price, input$leverage)
                            ),ncol=2,byrow=TRUE)
    colnames(temp_matrix) <- c("Return Percentage (in %)",
                               "Exit Price Required (in USDT)")
    return(temp_matrix)
  })
  
  output$return_exit_price_with_fees <- renderTable({
    temp_matrix <- matrix(c(input$expected_return, returnExitPriceCalculatorWithFees(input$expected_return,
                                                                 input$entry_price,
                                                                 input$asset_quantity,
                                                                 input$leverage,
                                                                 input$trading_level,
                                                                 input$entry_maker_or_taker,
                                                                 input$exit_maker_or_taker,
                                                                 input$bnb_fees),
                            10, returnExitPriceCalculatorWithFees(10,
                                                                  input$entry_price,
                                                                  input$asset_quantity,
                                                                  input$leverage,
                                                                  input$trading_level,
                                                                  input$entry_maker_or_taker,
                                                                  input$exit_maker_or_taker,
                                                                  input$bnb_fees),
                            25, returnExitPriceCalculatorWithFees(25,
                                                                  input$entry_price,
                                                                  input$asset_quantity,
                                                                  input$leverage,
                                                                  input$trading_level,
                                                                  input$entry_maker_or_taker,
                                                                  input$exit_maker_or_taker,
                                                                  input$bnb_fees),
                            50, returnExitPriceCalculatorWithFees(50,
                                                                  input$entry_price,
                                                                  input$asset_quantity,
                                                                  input$leverage,
                                                                  input$trading_level,
                                                                  input$entry_maker_or_taker,
                                                                  input$exit_maker_or_taker,
                                                                  input$bnb_fees),
                            75, returnExitPriceCalculatorWithFees(75,
                                                                  input$entry_price,
                                                                  input$asset_quantity,
                                                                  input$leverage,
                                                                  input$trading_level,
                                                                  input$entry_maker_or_taker,
                                                                  input$exit_maker_or_taker,
                                                                  input$bnb_fees),
                            100, returnExitPriceCalculatorWithFees(100,
                                                                  input$entry_price,
                                                                  input$asset_quantity,
                                                                  input$leverage,
                                                                  input$trading_level,
                                                                  input$entry_maker_or_taker,
                                                                  input$exit_maker_or_taker,
                                                                  input$bnb_fees),
                            125, returnExitPriceCalculatorWithFees(125,
                                                                  input$entry_price,
                                                                  input$asset_quantity,
                                                                  input$leverage,
                                                                  input$trading_level,
                                                                  input$entry_maker_or_taker,
                                                                  input$exit_maker_or_taker,
                                                                  input$bnb_fees),
                            150, returnExitPriceCalculatorWithFees(150,
                                                                  input$entry_price,
                                                                  input$asset_quantity,
                                                                  input$leverage,
                                                                  input$trading_level,
                                                                  input$entry_maker_or_taker,
                                                                  input$exit_maker_or_taker,
                                                                  input$bnb_fees),
                            175, returnExitPriceCalculatorWithFees(175,
                                                                  input$entry_price,
                                                                  input$asset_quantity,
                                                                  input$leverage,
                                                                  input$trading_level,
                                                                  input$entry_maker_or_taker,
                                                                  input$exit_maker_or_taker,
                                                                  input$bnb_fees),
                            200, returnExitPriceCalculatorWithFees(200,
                                                                  input$entry_price,
                                                                  input$asset_quantity,
                                                                  input$leverage,
                                                                  input$trading_level,
                                                                  input$entry_maker_or_taker,
                                                                  input$exit_maker_or_taker,
                                                                  input$bnb_fees)),
                          ncol = 2, byrow = TRUE)
    colnames(temp_matrix) <- c("Return Percentage (in %)",
                               "Exit Price Required (in USDT)")
    return(temp_matrix)
  })
}