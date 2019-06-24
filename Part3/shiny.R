library(shiny)
library(ggplot2)

####### UI Logic #######
ui <- fluidPage(
  
  ####### App title ######
  titlePanel("DIC Lab 1 Rakshit Viswanatham, Tannu Priya"),
  
  ####### Sidebar with the dropdown options ######
  sidebarLayout(
    sidebarPanel(
      h3("Heatmaps"),
      selectInput("keyword", "CDC vs Twitter", choices=c("all",
                                                        "Keyword: flu",
                                                        "Keyword: pneumonia"))
    ),
    
    ####### Main Panel with CDC vs Twitter ######
    mainPanel(
      h1("Please check the boxes for the heatmaps"),
      h3("CDC MAP"),
      imageOutput("CDCHeatmap"),
      br(),
      br(),
      htmlOutput("value"),
      imageOutput("twitterHeatmap"),
      textOutput("analysis")
      
    )
  )
)

####### Server logic ####### 
server <- function(input, output) {
  
  ####### Dynamic Titles ######
  output$value <- renderUI({ 
    if(input$keyword == 'all') {
      HTML("<h3>All the tweets/state</h3>")
    } else if (input$keyword == 'Keyword: flu') {
      HTML("<h3>Tweets/state with keyword 'flu'</h3>")
    } else {
      HTML("<h3>Tweets/state with keyword 'pneumonia'</h3>")
    }
  })

  ####### Dynamic show of maps based on dropdown ######
  output$twitterHeatmap <- renderImage({
    if(input$keyword == 'all') {
      list(
        src = "images/total_tweets_per_state.png",
        contentType = "image/png",
        alt = "Twitter Heatmap"
      )
    } else if (input$keyword == 'Keyword: flu') {
      list(
        src = "images/flu_tweets_per_state.png",
        contentType = "image/png",
        alt = "Flu Heatmap"
      )
    } else {
      list(
        src = "images/pneumonia_tweets_per_state.png",
        contentType = "image/png",
        alt = "Pneumonia Heatmap"
      )
    }
    }, deleteFile = FALSE)
  
  output$CDCHeatmap <- renderImage({
    return(list(
      src = "images/cdc_heatmap.png",
      contentType = "image/png",
      alt = "CDC Heatmap"
    ))
  }, deleteFile = FALSE)
  
  
  ####### Dynamic show analysis ######
  output$value <- renderUI({ 
    if(input$keyword == 'all') {
      "This shows all the tweets/state. We can see that the regions where there is a flu problem right now
      is where the discussion is also happenning."
    } else if (input$keyword == 'Keyword: flu') {
      "With flu being the main keyword we can see that this heatmap looks very relevant to the CDC Heatmap and
      because most of tweets contain the keyword, we can see a similar trend. "
    } else {
      "Pneumonia is the serious part of flu and therefore we consider it importang to show how that the discussion of it is 
      similar to the CDC heatmap."
    }
  })
}

###### Run the app ######
shinyApp(ui = ui, server = server)
