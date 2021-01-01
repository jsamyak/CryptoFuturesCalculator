
initialMarginCalculator <- function(entryPrice, assetQuantity, leverage) {
  return (entryPrice * assetQuantity / leverage)
}

netProfitCalculator <- function(entryPrice, exitPrice, assetQuantity) {
  return ((exitPrice - entryPrice) * assetQuantity)
}