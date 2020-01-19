#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


set.seed(1)

n = 100
X = runif(n, -1, 3)



# Define UI for application that draws a histogram
ui <- fluidPage(

    numericInput("true.deg", "Degree of True Relationship", 1),
    numericInput('fit.deg', "Degree of Fitted Relationship", 1),
    
    plotOutput('fitted.plot')
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    

    output$fitted.plot = renderPlot({
        
        set.seed(2)
        
        coefs = rnorm(input$true.deg + 1)
        
        terms = rep(1, times = n)
        for(i in seq_len(input$true.deg)){
            terms = cbind(terms, X^i)
        }
        
        mu = terms %*% coefs
        sigma = sd(mu)/input$true.deg
        
        Y = mu + rnorm(n, 0, sd = sigma)
        
        fit = lm(Y ~ poly(X, input$fit.deg))
        
        Y.hat = predict(fit, poly(X, input$fit.deg))
        
        plot(X, Y)
        lines(X[order(X)], Y.hat[order(X)])
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
