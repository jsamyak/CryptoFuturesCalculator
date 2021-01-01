library(shiny)
library(shinyWidgets)

#source("my_ui.R")
source("my_server.R")

my_ui <- shinyUI(
  fluidPage(
    h1("Crypto Futures Calculator"),
    sidebarLayout(
      sidebarPanel(
        numericInput("entry_price", "Entry Price", NA),
        numericInput("exit_price", "Exit Price", NA),
        numericInput("leverage", "Leverage", NA),
        numericInput("asset_quantity", "Asset Quantity", NA),
        
        prettyRadioButtons(
          "trading_level",
          p("Trading Level"),
          choices = list("VIP 0" = 0,
                         "VIP 1" = 1,
                         "VIP 2" = 2,
                         "VIP 3" = 3,
                         "VIP 4" = 4,
                         "VIP 5" = 5,
                         "VIP 6" = 6,
                         "VIP 7" = 7,
                         "VIP 8" = 8,
                         "VIP 9" = 9),
          inline = TRUE
        ),
        
        prettyRadioButtons(
          "maker_or_taker",
          p("Maker / Taker"),
          choices = list("Yes" = 0,
                         "No" = 1),
          inline = TRUE
        )
      ),
      mainPanel(
        h4("Initial Margin Required", style = "text-align:center;color:black;
          background-color:lavender;padding:15px;border-radius:10px"),
        fluidRow(
          textOutput("initial_margin"), 
          style = "text-align:center"  
        ),
        
        h4("Net profit (without fees)", style = "text-align:center;color:black;
          background-color:lavender;padding:15px;border-radius:10px"),
        fluidRow(
          textOutput("net_profit"), 
          style = "text-align:center"  
        ),

        h4("Net return percentage", style = "text-align:center;color:black;
          background-color:lavender;padding:15px;border-radius:10px"),
        fluidRow(
          textOutput("net_return_percentage"), 
          style = "text-align:center"  
        ),
      )
    ),
    hr(style = "border-top: 2px solid #000000;")
  )
)

shinyApp(ui = my_ui, server = my_server)
