## ui.R

dashboardPage(
     dashboardHeader(disable=TRUE),
    # title="GIS Data for the Gulf of Mexico Fisheries"),
          dashboardSidebar(
               sidebarMenu(id = "tab",
            
                    menuItem(" ", tabName = "map",selected=TRUE),
                    tags$head(includeCSS("Style.css")),
                    # tags$style(type="text/css",
                    #            ".shiny-output-error { visibility: hidden; }",
                    #            ".shiny-output-error:before { visibility: hidden; }"
                    # ),
                    
                    div(img(src="logo.png"), style="text-align: center;"),
                    tags$style(type='text/css', ".selectize-input { font-size: 16px; line-height: 18px;} .selectize-dropdown { font-size: 16px; line-height: 18px; }"),
                    br(),
                    div(
                         selectInput("selectFMP", multiple=TRUE, 
                                        selectize=TRUE,
                                     h3("Select 1 or more Fishery Management Plans:"),
                                     c("Coastal Migratory Pelagic" = "CMP", 
                                        "Coral and Coral Reefs" = "CORAL",
                                        "Spiny Lobster" = "LOBSTER",
                                        "Red Drum" = "REDDRUM",
                                        "Reef Fish" = "REEF",
                                        "Shrimp" = "SHRIMP"
                                       ),
                                     selected = c("CORAL", "SHRIMP")),
                         style="text-align: center; background-color: #3c8dbc; border-radius: 5px; padding: 5px 15px 5px 15px;"),

                    br(),
                    br(),
                    br(),
                    br(),
                    br(),
                    br(),
                    br(),
                    br(),
                   
                    actionButton("tabBut", HTML('<h4>What is EFH?</h4>'), width=200, 
                                 style="background-color: #3c8dbc; color: #fff;margin: 6px 0px 6px 0px;" ),
                    actionButton("tabAbout", HTML('<h4>About</h4>'), width=200,
                                 style="background-color: #3c8dbc; color: #fff;margin: 6px 0px 6px 0px;" ),
                    actionButton("tabConsult", HTML('<h4>EFH Consultation</h4>'), width=200,
                                 style="background-color: #3c8dbc; color: #fff;margin: 6px 0px 6px 0px;" ),
                    actionButton("tabDL", HTML('<h4>Download EFH data</h4>'), width=200,
                                 style="background-color: #3c8dbc; color: #fff; margin: 6px 0px 6px 0px;" ),
                    
               #actionButton("tabBut", "what is EFH?"),
                    #HTML("EFH Consultation"),
                    
                    br(),
                    br(),

                    div(tags$a(href="mailto: portal@gulfcouncil.org", h4("portal@gulfcouncil.org")), align="center"),
                    div(br()),
HTML("<h5 id='title' style='text-align:center;' >Gulf of Mexico <br> Fishery Management Council <br> 2203 North Lois Avenue, Suite 1100 <br>
     Tampa, Florida 33607 USA <br> P: 813-348-1630")
                    
                    )),
     dashboardBody(
          tabItems(
               tabItem(tabName='map',includeHTML('pageLoadHTML.html'),
                       includeScript('modalJS.js'),
                       includeCSS('Style.css'),
                       # tabItem(tabName='map',includeHTML('modalHTML4.html'),
                       #         includeScript('modalJS.js'),
                       #tags$img(src="HAPCViewerBanner.png",  width="100%"),
                     HTML("<h3 id='title' style='color: white;' >Essential Fish Habitat Mapping Application for the Gulf of Mexico Fisheries</h3>"),
                  leafletOutput('map',height=600),
                  
                  bsModal("modalExample1", " ", "tabBut", size = "large",
                          htmlOutput("whatEFH")),
                  bsModal("modalExample2", " ", "tabAbout", size = "large",
                          htmlOutput("About")),
                  bsModal("modalExample3", " ", "tabConsult", size = "large",
                          htmlOutput("Consult")),

#                   box(HTML("This map allows you visualize where essential fish habitat (EFH) is located in the Gulf of Mexico by fishery management plan (FMP), but to really get the most out of the map use the pin or draw tool to see which EFH layers exist in any area of the Gulf.  If you drop the pin, you’ll see the table on the right update to indicate if the pin is in or out of essential fish habitat for each FMP.  The same is true for the draw tool box, if EFH for any FMP is in the box you draw, that will be reflected in the table.  This works even if you don’t have all the FMPs displayed on the map.
# These tools are particularly useful if you’re planning a project that requires an EFH consultation through NOAA.  To find out if you need a consultation for your project and what the next steps in that process are, click the ‘EFH Consultations’ link on the left side of the page.
# As always, the textual description of EFH is the legal definition, so these maps are for illustrative purposes only (just in case you didn’t read this disclaimer when you opened the webpage).  If you’re looking for the legal definitions, click the ‘Textual Description” link on the left side of the page.
# If you want to download the shapefiles for your own use, see the GIS Data Download link and if you have any questions about the data please contact us.
# "),
# 
#                     width=8),
                  infoBoxOutput('VB'),
                  box(tableOutput("out3"),width=4,  style="background-color: #000a1b"),
                  box(     fileInput("shp_file", "Choose polygon shapefile File",
                                     accept=c(".shp",".dbf",
                                              ".sbn",".sbx",
                                              ".shx",".prj", "pdf"),
                                     multiple=TRUE
                  ),
                    width=4,  style="background-color: #000a1b"),
box(tableOutput("out32"),width=4,  style="background-color: #000a1b")
          

                  )#,

          )
          
          )
)

