library(shiny)

#source("my_ui.R")
source("my_server.R")

my_ui <- shinyUI(
  fluidPage(
    h1("Crypto Futures Calculator"),
    numericInput("entry_price", "Entry Price", NA),
    numericInput("exit_price", "Exit Price", NA),
    numericInput("leverage", "Leverage", NA),
    numericInput("asset_quantity", "Asset Quantity", NA),
    numericInput("maintenance_margin_rate", "Maintenance Margin Rate", NA),
    h4("Initial Margin Required", style = "text-align:left;color:black;background-color:lavender;padding:15px;border-radius:10px"),
    textOutput("initial_margin")
  )
)

shinyApp(ui = my_ui, server = my_server)
