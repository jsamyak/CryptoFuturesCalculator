library(shiny)

my_ui <- shinyUI(
  fluidPage(
    h1("Greetings"),
    numericInput("entry_price", "Entry Price", NA),
    numericInput("exit_price", "Exit Price", NA),
    numericInput("leverage", "Leverage", NA),
    numericInput("asset_quantity", "Asset Quantity", NA),
    numericInput("maintenance_margin_rate", "Maintenance Margin Rate", NA)
  )
)
