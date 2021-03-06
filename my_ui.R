library(shiny)
library(shinyWidgets)

my_ui <- shinyUI(
  fluidPage(
    h1("Crypto Futures Calculator"),
    sidebarLayout(
      sidebarPanel(
        numericInput("entry_price", "Entry Price", NA),
        numericInput("exit_price", "Exit Price", NA),
        numericInput("leverage", "Leverage", NA),
        numericInput("asset_quantity", "Asset Quantity", NA),
        numericInput("expected_return", "Return expected (in %)", NA),
        
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
          inline = TRUE,
          selected = 0
        ),
        
        prettyRadioButtons(
          "entry_maker_or_taker",
          p("Entry - Maker / Taker"),
          choices = list("Maker" = 0,
                         "Taker" = 1),
          inline = TRUE,
          selected = 1
        ),
        
        prettyRadioButtons(
          "exit_maker_or_taker",
          p("Exit - Maker / Taker"),
          choices = list("Maker" = 0,
                         "Taker" = 1),
          inline = TRUE,
          selected = 1
        ),
        
        prettyRadioButtons(
          "bnb_fees",
          p("Are you using BNB for fee payments? (Saves 10% of fees)"),
          choices = list("Yes" = 0,
                         "No" = 1),
          inline = TRUE,
          selected = 1
        )
      ),
      mainPanel(
        h4("Initial Margin Required", style = "text-align:center;color:black;
          background-color:lavender;padding:15px;border-radius:10px"),
        fluidRow(
          textOutput("initial_margin"), 
          style = "text-align:center"  
        ),
        
        fluidRow(
          column(2),
          column(3, 
                 h4("Profit"),
                 h4("(without fees)")
          ),
          column(2),
          column(3, 
                 h4("Net profit"),
                 h4("(with fees deduction)")
          ),
          column(2),
          style = "text-align:center;color:black;
          background-color:lavender;border-radius:10px"
        ),
        fluidRow(
          column(2),
          column(3, 
                 textOutput("profit_without_fees")
          ),
          column(2),
          column(3, 
                 textOutput("net_profit_with_fees")
          ),
          column(2),
          style = "text-align:center;color:black"
        ),
        
        fluidRow(
          column(2),
          column(3, 
                 h4("Return Percentage"),
                 h4("(without fees)")
          ),
          column(2),
          column(3, 
                 h4("Net return percentage"),
                 h4("(with fees deduction)")
          ),
          column(2),
          style = "text-align:center;color:black;
          background-color:lavender;border-radius:10px"
        ),
        fluidRow(
          column(2),
          column(3, textOutput("return_percentage")
          ),
          column(2),
          column(3, textOutput("net_return_with_fees")
          ),
          column(2),
          style = "text-align:center;color:black"
        ),
        
        fluidRow(
          column(2),
          column(2,
                 h4("Entry Fee")
          ),
          column(1),
          column(2,
                 h4("Exit Fee")
          ),
          column(1),
          column(2,
                 h4("Total Fee")
          ),
          column(2),
          style = "text-align:center;color:black;
          background-color:lavender;border-radius:10px"
        ),
        fluidRow(
          column(2),
          column(2,
                 textOutput("entry_fees")
          ),
          column(1),
          column(2,
                 textOutput("exit_fees")
          ),
          column(1),
          column(2,
                 textOutput("total_fees")
          ),
          column(2),
          style = "text-align:center;color:black"
        ),
        
        hr(style = "border-top: 2px solid #000000;"),
        
        fluidRow(
          column(1),
          column(3,
                 h4("Target (exit) price"),
                 h4("without fee deduction")),
          column(4),
          column(3, 
                 h4("Target (exit) price"),
                 h4("with fee deduction")),
          column(1),
          style = "text-align:center;color:black;
          background-color:lavender;border-radius:10px"
        ),
        
        fluidRow(
          column(5,
                 tableOutput("return_exit_price")),
          column(2),
          column(5,
                 tableOutput("return_exit_price_with_fees"))
        )
      )
    ),
    hr(style = "border-top: 2px solid #000000;")
  )
)
