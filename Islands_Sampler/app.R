library(shiny)



# Define UI for application
ui <- fluidPage(

    fluidRow(column(6, offset = 3, h1("Islands Sampler"))),
    fluidRow(h3("Please select your sample size and population.")),

    fluidRow(class = "text-center", column(4, offset = 1, 
                    fluidRow(radioButtons(inputId = "selection", 
                                          label = "Population",
                                             choiceNames = c("All Islands",
                                                             "North Island",
                                                             "East Island",
                                                             "South Island"),
                                             choiceValues = c("All", "N", "E", "S")
                                          )
                             ),
                    fluidRow(numericInput("n", "Sample Size", 1))
                    ),
             column(4, offset = 7))
    ,
    
    
    
    # textOutput("text")
    
    downloadButton("output.data", "Download")
)

# Define server logic
server <- function(input, output) {
    
    source("Generate_List_of_Houses.R")
    
    # output$text = renderText(input$selection)
    
    data = reactive({ get.sample(input$n, input$selection) })
    
    
    output$output.data = downloadHandler(
        filename = "Islands Sample.csv",
        content = function(file){
            write.csv(data(), file, row.names = F)
        }
    )
}

# Run the application 
shinyApp(ui = ui, server = server)
