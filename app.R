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
    
    h4("Initial Margin Required", style = "text-align:left;color:black;
       background-color:lavender;padding:15px;border-radius:10px"),
    textOutput("initial_margin"),
    
    h4("Net profit (without fees)", style = "text-align:left;color:black;
       background-color:lavender;padding:15px;border-radius:10px"),
    textOutput("net_profit"),
    
    h4("Net return percentage", style = "text-align:left;color:black;
       background-color:lavender;padding:15px;border-radius:10px"),
    textOutput("net_return_percentage"),
    
    h4("Initial Liquidation Price", style = "text-align:left;color:black;
       background-color:lavender;padding:15px;border-radius:10px"),
    textOutput("initial_liquidation_price"),
    
    h4("Maintenance Margin", style = "text-align:left;color:black;
       background-color:lavender;padding:15px;border-radius:10px"),
    textOutput("maintenance_margin"),
    
    h4("Final Liquidation Price", style = "text-align:left;color:black;
       background-color:lavender;padding:15px;border-radius:10px"),
    textOutput("final_liquidation_price")
  )
)

shinyApp(ui = my_ui, server = my_server)
