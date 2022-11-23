library(shiny)

selectRandom <- function(listInput){
  
  return(
    listInput[ceiling(runif(1)*length(listInput))]
  )
  
}

ui <- fluidPage(
  
  h3('Chat Window'),
  tags$div(class='jumbotron',
           uiOutput('render')
           ),
  textInput('enter','Enter Message'),
  actionButton('send','Send message')
  
)

server <- function(input,output,session){
  
  userMessage <- reactive({
    
    input$enter
    
  })
  
  randomAnswer <- function(){
    
    pronoun <- 'I'
    
    state <- c('am','was','will be')
    
    verb <- c('walking','walk',
              'talking','talk',
              'parking','park',
              'barking','bark')
    
    relations <- c('with','to','together')
    
    otherPronoun <- c('him','her','it',
                      'them','they',
                      'us')
    
    pointingRelation <- c('to','from','over','under',
                          'besides','next to')
    
    nouns <- c('cat','dog','bird','car', 'stadium',
               'jar')
    
    misc <- c('the')
    
    
    randomMessage <- paste(pronoun,
          selectRandom(state),
          selectRandom(verb),
          selectRandom(relations),
          selectRandom(otherPronoun),
          selectRandom(pointingRelation), 
          selectRandom(misc),
          selectRandom(nouns),sep=' ')
    
    return(randomMessage)
    
    
  }
  
  observeEvent(input$send,{
    
    output$render <- renderUI({
      
      isolate(
      message <- userMessage()
      )
      
      answer <- randomAnswer()
      
      tags$div(
        h4('You: '),
        p(message),
        br(),
        h4('Based Chat Bot Bro: '),
        p(answer),
        br()
        
      )
      
    })
    
    
  })



  
  
}

shinyApp(ui,server)