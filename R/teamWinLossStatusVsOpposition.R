##########################################################################################
# Designed and developed by Tinniam V Ganesh
# Date : 07 Jun 2019
# Function: teamWinLossStatusVsOpposition
# This function returns a team's win/loss/draw/tie status against the opposition. The
# matches could be played at home/away/neutral venues for Test, ODI and T20
#
###########################################################################################
#' @title
#' Compute the  wins/losses/draw/tied etc for a Team in Test, ODI or T20 against opposition
#'
#' @description
#' This function computes the  won,lost,draw,tied or no result for a team against
#' other teams in home/away or neutral venues and either returns a dataframe or plots it against opposition
#'
#' @usage
#' teamWinLossStatusVsOpposition(file,teamName,opposition=c("all"),homeOrAway=c("all"),
#'       matchType="Test",plot=FALSE)
#'
#' @param file
#' The CSV file for which the plot is required
#'
#' @param teamName
#' The name of the team for which plot is required
#'
#' @param opposition
#' Opposition is a vector namely c("all") or c("Australia", "India", "England")
#'
#' @param homeOrAway
#' This parameter is a vector which is either c("all") or a vector of venues c("home","away","neutral")
#'
#'
#' @param matchType
#' Match type - Test, ODI or T20
#'
#' @param plot
#' If plot=FALSE then a data frame is returned, If plot=TRUE then  a plot is generated
#'
#' @return None
#' @references
#' \url{https://www.espncricinfo.com/ci/content/stats/index.html}\cr
#' \url{https://gigadom.in/}\cr
#'
#'
#' @author
#' Tinniam V Ganesh
#' @note
#' Maintainer: Tinniam V Ganesh \email{tvganesh.85@gmail.com}
#'
#' @examples
#' \dontrun{
#' #Get the team data for India for Tests
#'
#' df <- getTeamDataHomeAway(teamName="India",file="indiaOD.csv",matchType="ODI")
#' teamWinLossStatusAtGrounds("india.csv",teamName="India",opposition=c("Australia","England","India"),
#'                           homeOrAway=c("home","away"),plot=TRUE)
#' }
#' @seealso
#' \code{\link{teamWinLossStatusVsOpposition}}
#' \code{\link{teamWinLossStatusAtGrounds}}
#' \code{\link{plotTimelineofWinsLosses}}
#'
#' @export
#'
teamWinLossStatusVsOpposition <- function(file,teamName,opposition=c("all"),homeOrAway=c("all"),matchType="Test",plot=FALSE){
  Opposition <- ha <- ground <- Result <- team <- NULL
  # Read CSV file
  df <- read.csv(file,stringsAsFactors = FALSE)
  #Clean data
  df1<- cleanTeamData(df,matchType)

  # Get the vector of countries in opposition and filter those rows
  if("all" %in% opposition){
    #Do not filter
  } else {
    df1 <- df1 %>% filter(Opposition %in% opposition)
  }

  #Check home/away/neutral from vector homeOrAway and filter rows
  if("all" %in% homeOrAway ){
    # Do not filter
  } else {
    df1 <- df1 %>% filter(ha  %in% homeOrAway)
  }

  # Select columns, group and count
  df2 <- df1 %>% select(Opposition,ha,Result)  %>%
      group_by(Opposition,Result,ha) %>% summarize(count=n())
  

  # If plot is TRUE
  if(plot == TRUE){
    # Collapse vector of countries in opposition
    oppn = paste(opposition,collapse='-')
    # Collapse vectors of homeOrAway vector
    ground = paste(homeOrAway,collapse='-')

    atitle <- paste("Win/Loss status of",teamName, "against opposition in", matchType,"(s)")

    asub <- paste("Against",oppn," teams at", ground, "grounds")

    # Plot for opposition and home/away for a team in Tes, ODI and T20
    ggplot(data=df2, aes(x=Opposition, y=count,fill=Result)) +
        geom_bar(stat="identity",position="stack")  +
        geom_text(aes(label=count), vjust=-0.5,position="stack") +
        labs(x="Win/Loss Status",
             y="Count",
             title=atitle,
             subtitle=asub,
             caption = "Data source-Courtesy:ESPN Cricinfo", side=1, line=4, adj=1.0, cex=0.8, col="blue") +
        theme(axis.text.x=element_text(angle=90,hjust=1))+
        ggtitle(atitle) + facet_wrap(~ha)

  }
  else{
    # Return dataframe
    df2
  }
}
