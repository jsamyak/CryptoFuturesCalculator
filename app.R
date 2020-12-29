library(shiny)
library(shinyWidgets)

#source("my_ui.R")
source("my_server.R")

my_ui <- shinyUI(
  fluidPage(
    h1("Crypto Futures Calculator"),
    sidebarLayout(
      sidebarPanel(
        prettyRadioButtons(
          "max_leverage",
          p("Asset Maximum leverage"),
          choices = list("125x" = 1, "100x" = 2, "75x" = 3, "50x" = 4, "20x" = 5),
          inline = TRUE
        ),
        numericInput("entry_price", "Entry Price", NA),
        numericInput("exit_price", "Exit Price", NA),
        numericInput("leverage", "Leverage", NA),
        numericInput("asset_quantity", "Asset Quantity", NA),
        numericInput("maintenance_margin_rate", "Maintenance Margin Rate", NA)
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
        
        h4("Initial Liquidation Price", style = "text-align:center;color:black;
          background-color:lavender;padding:15px;border-radius:10px"),
        fluidRow(
          textOutput("initial_liquidation_price"), 
          style = "text-align:center"  
        ),
        
        h4("Maintenance Margin", style = "text-align:center;color:black;
          background-color:lavender;padding:15px;border-radius:10px"),
        fluidRow(
          textOutput("maintenance_margin"), 
          style = "text-align:center"  
        ),
        
        h4("Final Liquidation Price", style = "text-align:center;color:black;
          background-color:lavender;padding:15px;border-radius:10px"),
        fluidRow(
          textOutput("final_liquidation_price"), 
          style = "text-align:center"  
        ),
      )
    )
  )
)

shinyApp(ui = my_ui, server = my_server)
