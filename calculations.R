library(dplyr)

initialMarginCalculator <- function(entryPrice, assetQuantity, leverage) {
  return (entryPrice * assetQuantity / leverage)
}

netProfitCalculator <- function(entryPrice, exitPrice, assetQuantity) {
  return ((exitPrice - entryPrice) * assetQuantity)
}

trading_fee <- read.csv("docs/feeStructure/USDTFuturesTradingFeeRate.csv", stringsAsFactors = FALSE)

temppp <- select(trading_fee, "Maker...")

totalFeesCalculator <- function(trading_level,
                                maker_or_taker,
                                entry_price,
                                exit_price,
                                asset_quantity) {
  temp_table <- filter(trading_fee, Level == trading_level)
  
  if (maker_or_taker == 0) {
    temp_table <- select(temp_table, "Maker...")
  } else {
    temp_table <- select(temp_table, "Taker...")
  }
  
  final_fee_rate <- temp_table[1,1]
  total_fee <- (entry_price + exit_price) * asset_quantity * final_fee_rate / 100
  return(total_fee)
}