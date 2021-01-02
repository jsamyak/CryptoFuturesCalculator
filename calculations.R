library(dplyr)

initialMarginCalculator <- function(entryPrice, assetQuantity, leverage) {
  return (entryPrice * assetQuantity / leverage)
}

profitCalculator <- function(entryPrice, exitPrice, assetQuantity) {
  return ((exitPrice - entryPrice) * assetQuantity)
}

trading_fee <- read.csv("docs/feeStructure/USDTFuturesTradingFeeRate.csv",
                        stringsAsFactors = FALSE)

individualFeeCalculator <- function(trading_level,
                                    maker_or_taker,
                                    asset_price,
                                    asset_quantity,
                                    bnb_fees){
  temp_table <- filter(trading_fee, Level == trading_level)
  
  if (maker_or_taker == 0) {
    temp_table <- select(temp_table, "Maker...")
  } else {
    temp_table <- select(temp_table, "Taker...")
  }
  
  final_fee_rate <- temp_table[1,1]
  if (bnb_fees == 0) {
    final_fee_rate <- final_fee_rate * 0.9
  }
  
  total_fee <- asset_price * asset_quantity * final_fee_rate / 100
  return(total_fee)
}

returnExitPriceCalculator <- function(return_percentage,
                                      entry_price,
                                      leverage) {
  return((entry_price * (return_percentage / 100) / leverage) + entry_price)
}

returnExitPriceCalculatorWithFees <- function(expected_return,
                                              entry_price,
                                              asset_quantity,
                                              leverage,
                                              trading_level,
                                              entry_maker_or_taker,
                                              exit_maker_or_taker){
  
}