library(shiny)
library(JBrowseR)

data_server <- serve_data("~/pathway")

ui <- fluidPage(
  titlePanel("SL JBrowseR Example"),
  # this adds to the browser to the UI, and specifies the output ID in the server
  JBrowseROutput("browserOutput")
)

server <- function(input, output, session) {
  # create the necessary JB2 assembly configuration
  assembly <- assembly(
    "http://127.0.0.1:5000/S_lycopersicum_chromosomes.4.00.fa.gz",
    bgzip = TRUE
  )

  # create configuration for a JB2 GFF FeatureTrack
  annotations_track <- track_feature(
    "http://127.0.0.1:5000/ITAG4.0_gene_models.sorted.gff.gz",
    assembly
  )
  bws1_track <- track_wiggle("http://127.0.0.1:5000/NOR.bw",assembly)

  # create the tracks array to pass to browser
  tracks <- tracks(
    annotations_track,bws1_track
  )

  # set up the default session for the browser
  default_session <- default_session(
    assembly,
    c(annotations_track,bws1_track)
  )

  theme <- theme("#5da8a3", "#333")

  # link the UI with the browser widget
  output$browserOutput <- renderJBrowseR(
    JBrowseR(
      "View",
      assembly = assembly,
      tracks = tracks,
      defaultSession = default_session,
      theme = theme
    )
  )
}
shinyApp(ui, server)
