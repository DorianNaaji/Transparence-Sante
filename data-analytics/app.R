install.packages("anyLib")
anyLib::anyLib(c("shiny", "shinydashboard", "shinyWidgets", "DT", "plotly", "ggplot2", "googleVis", "colourpicker"))

library(shiny)
library(shinydashboard)


options(shiny.maxRequestSize=1000*1024^2)


################################################################################
# UI
################################################################################

ui <- dashboardPage(
  dashboardHeader(title = "Transparence santé"),
  dashboardSidebar(
    sidebarMenu(id = "tabs",
                menuItem("Lecture des données", tabName = "readData", icon = icon("readme")),
                menuItem("Visualisation des données", tabName = "visualization", icon = icon("poll"))
    )
  ),
  dashboardBody(
    
    tabItems(
      # Read data
      tabItem(tabName = "readData",
              h1("Lecture des données"),
              fileInput("dataFile",label = NULL,
                        buttonLabel = "Browse...",
                        placeholder = "No file selected"),
              
              fluidRow(
                column(3,
                       h3("Parameters"),
                       
                       # Input: Checkbox if file has header
                       radioButtons(inputId = "header", 
                                    label = "Header",
                                    choices = c("Yes" = TRUE,
                                                "No" = FALSE),
                                    selected = TRUE, inline=T),
                       
                       # Input: Select separator ----
                       radioButtons(inputId = "sep", 
                                    label = "Separator",
                                    choices = c(Comma = ",",
                                                Semicolon = ";",
                                                Tab = "\t"),
                                    selected = "\t", inline=T),
                       
                       # Input: Select quotes ----
                       radioButtons(inputId = "quote", 
                                    label= "Quote",
                                    choices = c(None = "",
                                                "Double Quote" = '"',
                                                "Single Quote" = "'"),
                                    selected = "", inline=T)
                ),
                column(9,
                       h3("File preview"),
                       dataTableOutput(outputId = "preview")
                )
              ), 
              tags$br(),
              
              div(actionButton(inputId = "actBtnVisualisation", label = "Visualisation",icon = icon("play") ), align = "center")
              
              
              
      ),
      
      # visualization
      tabItem(tabName = "visualization",
              h1("Visualisation des données"),
              h2("Exploration du tableau"),
              dataTableOutput('dataTable'),
              h2("Graphiques"),
              fluidRow(
                plotOutput("plotAvecGgplot2"),
                plotOutput("plotIdType")

              )
      )
    )
  )
)

################################################################################
# Server
################################################################################

server <- function(input, output, session) {
  
  data <- reactiveValues()
  
  #=============================================================================
  # Preview
  #=============================================================================
  output$preview <-  renderDataTable({
    
    req(input$dataFile)
    
    df <- read.csv(input$dataFile$datapath,
                   header = as.logical(input$header),
                   sep = input$sep,
                   quote = input$quote,
                   nrows=10
    )
  },  options = list(scrollX = TRUE , dom = 't'))
  
  #=============================================================================
  # Lecture
  #=============================================================================
  observeEvent(input$actBtnVisualisation, {
    
    if(!is.null(input$dataFile$datapath)){
      data$table = read.csv(input$dataFile$datapath,
                            header = as.logical(input$header),
                            sep = input$sep,
                            quote = input$quote)
      sendSweetAlert(
        session = session,
        title = "Done !",
        text = "Le fichier a bien été lu !",
        type = "success"
      )
      
      options = list(scrollX = TRUE , dom = 't')
      
      updateTabItems(session, "tabs", selected = "visualization")
    }
    
  })
  
  #=============================================================================
  # Exploration du tableau
  #=============================================================================
  
  output$dataTable = DT::renderDataTable({
    if(!is.null(data$table)){
      datatable(data$table, filter = 'top', options = list(scrollX = TRUE , dom = 't')) %>% 
        formatStyle(
          'identifiant_type',
          backgroundColor = styleEqual(
            unique(data$table$identifiant_type), c('lightblue', 'lightgreen', 'lavender', 'red', 'green')
          )
        )
    }else {
      NULL
    }
  })
  
  #=============================================================================
  # Graphiques
  #=============================================================================
  output$plotAvecGgplot2 <- renderPlot({
    if(!is.null(data$table)){

      list_country_amount <- aggregate(data$table$remu_montant_ttc, by=list(Pays = data$table$benef_pays_code), FUN=sum)

        ggplot(data = list_country_amount, 
               aes(x=Pays, y=x,  fill=factor(Pays))) + 
          geom_bar(position = "dodge", stat = "identity") + ylab("Montant (en Euros)") + 
          xlab("Pays") + theme(legend.position="bottom" 
                               ,plot.title = element_text(size=15, face="bold")) + 
          ggtitle("Montant de la rémunération par pays") + labs(fill = "Pays")
      
    }else {
      NULL
    }
  })
  
  output$plotIdType <- renderPlot({
    if(!is.null(data$table)){
      
      list_idtype_amount <- aggregate(data$table$remu_montant_ttc, by=list(Type = data$table$identifiant_type), FUN=sum)

      ggplot(data = list_idtype_amount, 
             aes(x=Type, y=x,  fill=factor(Type))) + 
        geom_bar(position = "dodge", stat = "identity") + ylab("Montant (en Euros)") + 
        xlab("Type") + theme(legend.position="bottom" 
                             ,plot.title = element_text(size=15, face="bold")) + 
        ggtitle("Montant de la rémunération par type de l'identifiant") + labs(fill = "Type")
      
    }else {
      NULL
    }
  })

  
}

shinyApp(ui, server)