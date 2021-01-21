install.packages("anyLib")
anyLib::anyLib(c("shiny", "shinydashboard", "shinyWidgets", "DT", "plotly", "ggplot2", "googleVis", "colourpicker"))

library(shiny)
library(shinydashboard)

# Pour autoriser le chargement de très gros fichiers
options(shiny.maxRequestSize=2000*1024^2)


################################################################################
# UI
################################################################################

ui <- dashboardPage(
  dashboardHeader(title = "Transparence santé"),
  dashboardSidebar(
    sidebarMenu(id = "tabs",
                menuItem("Lecture des données", tabName = "readData", icon = icon("readme")),
                menuItem("Visualisation des données", tabName = "visualization", icon = icon("line-chart")),
                menuItem("Graphiques rémunérations", tabName = "remunerationsGraphs", icon = icon("poll")),
                menuItem("Graphiques conventions", tabName = "conventionsGraphs", icon = icon("poll")),
                menuItem("Graphiques avantages", tabName = "avantagesGraphs", icon = icon("poll")),
                menuItem("Comparaison", tabName = "comparaisonGraphs", icon = icon("poll"))
    )
  ),
  dashboardBody(
    
    tabItems(
      tabItem(tabName = "readData",
              h1("Prévisualisation des fichiers", align = "center"),
              h2("Prévisualisation du fichier rémunération.csv :"),
              dataTableOutput(outputId = "previewRem"),
              h2("Prévisualisation du fichier conventions.csv :"),
              dataTableOutput(outputId = "previewConv"),
              h2("Prévisualisation du fichier avantages.csv :"),
              dataTableOutput(outputId = "previewAv"),
              div(actionButton(inputId = "actBtnVisualisation", label = "Visualisation des fichiers",icon = icon("play") ), align = "center")
              
      ),
      
      
      # visualization
      tabItem(tabName = "visualization",
              h1("Exploration des tableaux"),
              h2("Tableau rémunérations :"),
              dataTableOutput('remDataTable'),
              h2("Tableau conventions :"),
              dataTableOutput('convDataTable'),
              h2("Tableau avantages :"),
              dataTableOutput('avDataTable')
      ),
      
      # remunerationsGraphs
      tabItem(tabName = "remunerationsGraphs",
              h1("Graphiques concernant le fichier rémunérations.csv"),
              fluidRow(
                plotOutput("plotCountryAmountRem"),
                plotOutput("plotIdTypeAmountRem"),
                plotOutput("plotQualiteAmountRem")
                #plotOutput("plotPaysMeanAmountRem")
                
              )
      ),
      
      # conventionsGraphs
      tabItem(tabName = "conventionsGraphs",
              h1("Graphiques concernant le fichier conventions.csv"),
              fluidRow(
                plotOutput("plotCountryAmountConv"),
                plotOutput("plotIdTypeAmountConv"),
                plotOutput("plotQualiteAmountConv")
                #plotOutput("plotPaysMeanAmountConv")
                
              )
      ),
      
      # avantagesGraphs
      tabItem(tabName = "avantagesGraphs",
              h1("Graphiques concernant le fichier avantages.csv"),
              fluidRow(
                plotOutput("plotCountryAmountAv"),
                plotOutput("plotIdTypeAmountAv"),
                plotOutput("plotQualiteAmountAv")
                #plotOutput("plotPaysMeanAmountAv")
                
              )
      ),
      
      # comparaisonGraphs
      tabItem(tabName = "comparaisonGraphs",
              h1("Graphiques"),
              fluidRow(
                plotOutput("plotPaysMeanAmountRem"),
                plotOutput("plotPaysMeanAmountConv"),
                plotOutput("plotPaysMeanAmountAv")
                
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
  
  #---------------------------PREVIEW REMUNERATIONS-----------------------------
  
  output$previewRem <-  renderDataTable({
    
    #req(input$dataFile)
    
    df <- read.csv("../data/data.gouv/remunerations.csv",
                   header = as.logical(TRUE),
                   sep = ";",
                   quote = '"',
                   nrows=10,
                   encoding="UTF-8"
    )
    
  },  options = list(scrollX = TRUE , dom = 't'))
  
  
  #----------------------------PREVIEW CONVENTIONS------------------------------
  
  output$previewConv <-  renderDataTable({
    
    #req(input$dataFile)
    
    df <- read.csv("../data/data.gouv/conventions.csv",
                   header = as.logical(TRUE),
                   sep = ";",
                   quote = '"',
                   nrows=10,
                   encoding="UTF-8"
    )
    
  },  options = list(scrollX = TRUE , dom = 't'))
  
  #----------------------------PREVIEW CONVENTIONS------------------------------
  
  output$previewAv <-  renderDataTable({
    
    #req(input$dataFile)
    
    df <- read.csv("../data/data.gouv/avantages.csv",
                   header = as.logical(TRUE),
                   sep = ";",
                   quote = '"',
                   nrows=10,
                   encoding="UTF-8"
    )
    
  },  options = list(scrollX = TRUE , dom = 't'))
  
  
  #=============================================================================
  # Lecture
  #=============================================================================
  
  #-------------------LECTURE REMUNERATIONS & CONVENTIONS-----------------------
  
  observeEvent(input$actBtnVisualisation, {
    
    if(!is.null("../data/data.gouv/remunerations.csv")){
      data$remtable = read.csv("../data/data.gouv/remunerations.csv",
                            header = as.logical(TRUE),
                            sep = ";",
                            quote = '"',
                            nrows = 50000,
                            encoding="UTF-8")
      sendSweetAlert(
        session = session,
        title = "Done !",
        text = "Le fichier remunerations.csv a bien été lu !",
        type = "success"
      )
      
      options = list(scrollX = TRUE , dom = 't')
      
      updateTabItems(session, "tabs", selected = "visualization")
    }
    
    if(!is.null("../data/data.gouv/conventions.csv")){
      data$convtable = read.csv("../data/data.gouv/conventions.csv",
                                header = as.logical(TRUE),
                                sep = ";",
                                quote = '"',
                                nrows = 50000,
                                encoding="UTF-8")
      
      for (i in 1:length(data$convtable$conv_montant_ttc)) {
        
        if (is.na(data$convtable$conv_montant_ttc[i])) {
          data$convtable$conv_montant_ttc[i] <- 0
        }
      }
      
      
      sendSweetAlert(
        session = session,
        title = "Done !",
        text = "Le fichier conventions.csv a bien été lu !",
        type = "success"
      )
      
      options = list(scrollX = TRUE , dom = 't')
      
      updateTabItems(session, "tabs", selected = "visualization")
      
      
    }
    
    if(!is.null("../data/data.gouv/avantages.csv")){
      data$avtable = read.csv("../data/data.gouv/avantages.csv",
                               header = as.logical(TRUE),
                               sep = ";",
                               quote = '"',
                               nrows = 50000,
                               encoding="UTF-8")
      sendSweetAlert(
        session = session,
        title = "Done !",
        text = "Le fichier avantages.csv a bien été lu !",
        type = "success"
      )
      
      options = list(scrollX = TRUE , dom = 't')
      
      updateTabItems(session, "tabs", selected = "visualization")
    }
    
  })

  
  #=============================================================================
  # Exploration des tableaux
  #=============================================================================
  
  #--------------------EXPLORATION DU FICHIER REMUNERATIONS---------------------
  
  output$remDataTable = DT::renderDataTable({
    if(!is.null(data$remtable)){
      datatable(data$remtable, filter = 'top', options = list(scrollX = TRUE , dom = 't')) %>% 
        formatStyle(
          'identifiant_type',
          backgroundColor = styleEqual(
            unique(data$remtable$identifiant_type), c('lightblue', 'lightgreen', 'lavender', 'red', 'green')
          )
        )
    }else {
      NULL
    }
    
})

  #---------------------EXPLORATION DU FICHIER CONVENTIONS----------------------
  
  output$convDataTable = DT::renderDataTable({
    if(!is.null(data$convtable)){
      datatable(data$convtable, filter = 'top', options = list(scrollX = TRUE , dom = 't')) %>% 
        formatStyle(
          'identifiant_type',
          backgroundColor = styleEqual(
            unique(data$convtable$identifiant_type), c('lightblue', 'lightgreen', 'lavender', 'red', 'green')
          )
        )
      
    }else {
      NULL
    }
  })
  
  #----------------------EXPLORATION DU FICHIER AVANTAGES-----------------------
  
  output$avDataTable = DT::renderDataTable({
    if(!is.null(data$avtable)){
      datatable(data$avtable, filter = 'top', options = list(scrollX = TRUE , dom = 't')) %>% 
        formatStyle(
          'identifiant_type',
          backgroundColor = styleEqual(
            unique(data$avtable$identifiant_type), c('lightblue', 'lightgreen', 'lavender', 'red', 'green')
          )
        )
      
    }else {
      NULL
    }
  })
  
  #=============================================================================
  # Graphiques
  #=============================================================================
  
  #--------------------GRAPHIQUES DU FICHIER REMUNERATIONS----------------------
  
  output$plotCountryAmountRem <- renderPlot({
      
      if(!is.null(data$remtable)){
        
        list_country_amount_rem <- aggregate(data$remtable$remu_montant_ttc, by=list(Pays = data$remtable$benef_pays_code), FUN=sum)
        
        list_country_amount_rem[14, 2] <- 0 # Montant du pays "[FR]" mis à 0 car trop elevée et nous ne voyons pas la reste (Premier)
        
        ggplot(data = list_country_amount_rem, 
               aes(x=Pays, y=x,  fill=factor(Pays))) + 
          geom_bar(position = "dodge", stat = "identity") + ylab("Montant (en Euros)") + 
          xlab("Pays") + theme(legend.position="bottom" 
                               ,plot.title = element_text(size=15, face="bold")) + 
          ggtitle("Montant de la rémunération en fonction pays") + labs(fill = "Pays")
        
      }else {
        NULL
      }
    
  })
  
  output$plotIdTypeAmountRem <- renderPlot({
      
      if(!is.null(data$remtable)){
        
        list_idtype_amount_rem <- aggregate(data$remtable$remu_montant_ttc, by=list(Type = data$remtable$identifiant_type), FUN=sum)
        
        ggplot(data = list_idtype_amount_rem, 
               aes(x=Type, y=x,  fill=factor(Type))) + 
          geom_bar(position = "dodge", stat = "identity") + ylab("Montant (en Euros)") + 
          xlab("Type") + theme(legend.position="bottom" 
                               ,plot.title = element_text(size=15, face="bold")) + 
          ggtitle("Montant de la rémunération en fonction du type de l'identifiant du bénéficiaire") + labs(fill = "Type")
        
      }else {
        NULL
      }
    
    
  })
  
  output$plotQualiteAmountRem <- renderPlot({
      
      if(!is.null(data$remtable)){
        
        list_qualite_amount_rem <- aggregate(data$remtable$remu_montant_ttc, by=list(Qualite = data$remtable$qualite), FUN=sum)
        
        list_qualite_amount_rem[1, 2] <- 0 # Qualité "" mise à 0 car trop elevée et nous ne voyons pas la reste (Premier)
        list_qualite_amount_rem[13, 2] <- 0 # Qualité "Médecin" mise à 0 car trop elevée et nous ne voyons pas la reste (Deuxième)
        
        ggplot(data = list_qualite_amount_rem, 
               aes(x=Qualite, y=x,  fill=factor(Qualite))) + 
          geom_bar(position = "dodge", stat = "identity") + ylab("Montant (en Euros)") + 
          xlab("Qualite") + theme(legend.position="bottom" 
                                  ,plot.title = element_text(size=15, face="bold")) +
          ggtitle("Montant de la rémunération en fonction de la qualité du bénéficiaire") + labs(fill = "Qualite")
        
      }else {
        NULL
      }
    
  })
  
  output$plotPaysMeanAmountRem <- renderPlot({
      
      if(!is.null(data$remtable)){
        
        list_qualite_amount_rem <- aggregate(data$remtable$remu_montant_ttc, by=list(Pays = data$remtable$benef_pays_code), FUN=mean)
        
        ggplot(data = list_qualite_amount_rem, 
               aes(x=Pays, y=x,  fill=factor(Pays))) + 
          geom_bar(position = "dodge", stat = "identity") + ylab("Montant (en Euros)") + 
          xlab("Pays") + theme(legend.position="bottom" 
                               ,plot.title = element_text(size=15, face="bold")) +
          ggtitle("Moyenne du montant de la rémunération en fonction du pays") + labs(fill = "Pays")
        
      }else {
        NULL
      }
    
  })
  
  #---------------------GRAPHIQUES DU FICHIER CONVENTIONS-----------------------
  
  output$plotCountryAmountConv <- renderPlot({
    
    if(!is.null(data$convtable)){
      
      list_country_amount_conv <- aggregate(data$convtable$conv_montant_ttc, by=list(Pays = data$convtable$benef_pays_code), FUN=sum)
      
      #list_country_amount_conv[14, 2] <- 0 # Montant du pays "[FR]" mis à 0 car trop elevée et nous ne voyons pas la reste (Premier)
      
      ggplot(data = list_country_amount_conv, 
             aes(x=Pays, y=x,  fill=factor(Pays))) + 
        geom_bar(position = "dodge", stat = "identity") + ylab("Montant (en Euros)") + 
        xlab("Pays") + theme(legend.position="bottom" 
                             ,plot.title = element_text(size=15, face="bold")) + 
        ggtitle("Montant de la convention en fonction pays") + labs(fill = "Pays")
      
    }else {
      NULL
    }
    
  })
  
  output$plotIdTypeAmountConv <- renderPlot({
    
    if(!is.null(data$convtable)){
      
      list_idtype_amount_conv <- aggregate(data$convtable$conv_montant_ttc, by=list(Type = data$convtable$identifiant_type), FUN=sum)

      ggplot(data = list_idtype_amount_conv, 
             aes(x=Type, y=x,  fill=factor(Type))) + 
        geom_bar(position = "dodge", stat = "identity") + ylab("Montant (en Euros)") + 
        xlab("Type") + theme(legend.position="bottom" 
                             ,plot.title = element_text(size=15, face="bold")) + 
        ggtitle("Montant de la convention en fonction du type de l'identifiant du bénéficiaire") + labs(fill = "Type")
      
    }else {
      NULL
    }
    
    
  })
  
  output$plotQualiteAmountConv <- renderPlot({
    
    if(!is.null(data$convtable)){
      
      list_qualite_amount_conv <- aggregate(data$convtable$conv_montant_ttc, by=list(Qualite = data$convtable$qualite), FUN=sum)
      
      #list_qualite_amount_conv[1, 2] <- 0 # Qualité "" mise à 0 car trop elevée et nous ne voyons pas la reste (Premier)
      #list_qualite_amount_conv[13, 2] <- 0 # Qualité "Médecin" mise à 0 car trop elevée et nous ne voyons pas la reste (Deuxième)
      
      ggplot(data = list_qualite_amount_conv, 
             aes(x=Qualite, y=x,  fill=factor(Qualite))) + 
        geom_bar(position = "dodge", stat = "identity") + ylab("Montant (en Euros)") + 
        xlab("Qualite") + theme(legend.position="bottom" 
                                ,plot.title = element_text(size=15, face="bold")) +
        ggtitle("Montant de la convention en fonction de la qualité du bénéficiaire") + labs(fill = "Qualite")
      
    }else {
      NULL
    }
    
  })
  
  output$plotPaysMeanAmountConv <- renderPlot({
    
    if(!is.null(data$convtable)){
      
      list_qualite_amount_conv <- aggregate(data$convtable$conv_montant_ttc, by=list(Pays = data$convtable$benef_pays_code), FUN=mean)
      
      ggplot(data = list_qualite_amount_conv, 
             aes(x=Pays, y=x,  fill=factor(Pays))) + 
        geom_bar(position = "dodge", stat = "identity") + ylab("Montant (en Euros)") + 
        xlab("Pays") + theme(legend.position="bottom" 
                             ,plot.title = element_text(size=15, face="bold")) +
        ggtitle("Moyenne du montant de la convention en fonction du pays") + labs(fill = "Pays")
      
    }else {
      NULL
    }
    
  })
  
  #----------------------GRAPHIQUES DU FICHIER AVANTAGES------------------------
  
  output$plotCountryAmountAv <- renderPlot({
    
    if(!is.null(data$avtable)){
      
      list_country_amount_av <- aggregate(data$avtable$avant_montant_ttc, by=list(Pays = data$avtable$benef_pays_code), FUN=sum)
      
      #list_country_amount_av[14, 2] <- 0 # Montant du pays "[FR]" mis à 0 car trop elevée et nous ne voyons pas la reste (Premier)
      
      ggplot(data = list_country_amount_av, 
             aes(x=Pays, y=x,  fill=factor(Pays))) + 
        geom_bar(position = "dodge", stat = "identity") + ylab("Montant (en Euros)") + 
        xlab("Pays") + theme(legend.position="bottom" 
                             ,plot.title = element_text(size=15, face="bold")) + 
        ggtitle("Montant de l'avantage en fonction pays") + labs(fill = "Pays")
      
    }else {
      NULL
    }
    
  })
  
  output$plotIdTypeAmountAv <- renderPlot({
    
    if(!is.null(data$avtable)){
      
      list_idtype_amount_av <- aggregate(data$avtable$avant_montant_ttc, by=list(Type = data$avtable$identifiant_type), FUN=sum)
      
      ggplot(data = list_idtype_amount_av, 
             aes(x=Type, y=x,  fill=factor(Type))) + 
        geom_bar(position = "dodge", stat = "identity") + ylab("Montant (en Euros)") + 
        xlab("Type") + theme(legend.position="bottom" 
                             ,plot.title = element_text(size=15, face="bold")) + 
        ggtitle("Montant de l'avantage en fonction du type de l'identifiant du bénéficiaire") + labs(fill = "Type")
      
    }else {
      NULL
    }
    
    
  })
  
  output$plotQualiteAmountAv <- renderPlot({
    
    if(!is.null(data$avtable)){
      
      list_qualite_amount_av <- aggregate(data$avtable$avant_montant_ttc, by=list(Qualite = data$avtable$qualite), FUN=sum)
      
      #list_qualite_amount_av[1, 2] <- 0 # Qualité "" mise à 0 car trop elevée et nous ne voyons pas la reste (Premier)
      #list_qualite_amount_av[13, 2] <- 0 # Qualité "Médecin" mise à 0 car trop elevée et nous ne voyons pas la reste (Deuxième)
      
      ggplot(data = list_qualite_amount_av, 
             aes(x=Qualite, y=x,  fill=factor(Qualite))) + 
        geom_bar(position = "dodge", stat = "identity") + ylab("Montant (en Euros)") + 
        xlab("Qualite") + theme(legend.position="bottom" 
                                ,plot.title = element_text(size=15, face="bold")) +
        ggtitle("Montant de l'avantage en fonction de la qualité du bénéficiaire") + labs(fill = "Qualite")
      
    }else {
      NULL
    }
    
  })
  
  output$plotPaysMeanAmountAv <- renderPlot({
    
    if(!is.null(data$avtable)){
      
      list_qualite_amount_av <- aggregate(data$avtable$avant_montant_ttc, by=list(Pays = data$avtable$benef_pays_code), FUN=mean)
      
      ggplot(data = list_qualite_amount_av, 
             aes(x=Pays, y=x,  fill=factor(Pays))) + 
        geom_bar(position = "dodge", stat = "identity") + ylab("Montant (en Euros)") + 
        xlab("Pays") + theme(legend.position="bottom" 
                             ,plot.title = element_text(size=15, face="bold")) +
        ggtitle("Moyenne du montant de l'avantage en fonction du pays") + labs(fill = "Pays")
      
    }else {
      NULL
    }
    
  })
  
  #--------------------------------COMPARAISONS---------------------------------
  
  output$plotComp <- renderPlot({
    
    if(!is.null(data$remtable) && !is.null(data$convtable) && !is.null(data$avtable)){

      list_rem <- aggregate(data$remtable$remu_montant_ttc, by=list(Pays = data$remtable$benef_pays_code), FUN=mean)
      list_conv <- aggregate(data$convtable$conv_montant_ttc, by=list(Pays = data$convtable$benef_pays_code), FUN=mean)
      list_av <- aggregate(data$avtable$avant_montant_ttc, by=list(Pays = data$avtable$benef_pays_code), FUN=mean)
          
      ggplot(data = c(list_rem, list_conv,list_av), 
             aes(x=Pays, y=x,  fill=factor(Pays))) + 
        geom_bar(position = "dodge", stat = "identity") + ylab("Montant (en Euros)") + 
        xlab("Pays") + theme(legend.position="bottom" 
                             ,plot.title = element_text(size=15, face="bold")) + 
        ggtitle("Montant de l'avantage en fonction pays") + labs(fill = "Pays")
      
    }else {
      NULL
    }
    
  })
  
  
}

shinyApp(ui, server)