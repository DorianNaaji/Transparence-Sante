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
                column(4, plotOutput("plotAvecR")),
                column(4, colourpicker::colourInput("colR", "Couleur graphique R", "black",allowTransparent = T),
                       sliderInput("cex", "Taille",
                                   min = 0.5, max = 3,
                                   value = 1,step = 0.2
                       )),
                column(4, selectInput(inputId = "pch", choices = 1:20, label = "Type de points",selected = 1),
                       textInput("title", "Titre", "Sepal length vs Petal length (R)") )
              ),
              tags$br(), 
              fluidRow(
                column(4, plotOutput("plotAvecGgplot2")),
                column(4, plotlyOutput("plotAvecPlotly")),
                column(4, htmlOutput("plotAvecGoogle"))
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
      
      updateTabItems(session, "tabs", selected = "visualization")
    }
    
  })
  
  #=============================================================================
  # Exploration du tableau
  #=============================================================================
  
  output$dataTable = DT::renderDataTable({
    print(is)
    if(!is.null(data$table)){
      datatable(data$table, filter = 'top') %>% 
        formatStyle('remu_montant_ttc', 
                    background = styleColorBar(data$table$remu_montant_ttc, 'lightcoral'),
                    backgroundSize = '100% 90%',
                    backgroundRepeat = 'no-repeat',
                    backgroundPosition = 'center'
        )
    }else {
      NULL
    }
  })

  
}

shinyApp(ui, server)