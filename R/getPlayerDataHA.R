##########################################################################################
# Designed and developed by Tinniam V Ganesh
# Date : 10 Jul 2019
# Function: getPlayerDataHA
# This function creates a CSV file with a players data and also adds a column whether the
# match was played at home or overseas
###########################################################################################
#' @title
#' Return the CSV file and a dataframe of a player's matches along with home/away column
#'
#' @description
#' This function saves the players data as a CSV file and also returns a data frame. A new column
#' home/away/neutral is added
#'
#' @usage
#' getPlayerDataHA(profileNo,tdir=".",tfile="player001.csv",type="batting",
#'                      matchType="Test")
#'
#' @param profileNo
#' The profile number of the player
#'
#' @param tdir
#' The name of the directory to save the CSV file
#'
#' @param tfile
#' The name of the CSV file
#'
#' @param type
#' This parameter should be 'batting' for batsman data and 'bowling' for bowlers
#'
#' @param matchType
#' Match type - Test, ODI or T20
#'
#'
#' @return dataframe
#'
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
#' #Get data for Tendulkar
#' df=getPlayerDataHA(profileno=35320,tfile="tendulkarHA.csv")
#' #Get the bowling data for Jadeja in ODIs
#' df=getPlayerDataHA(profileNo=234675,tfile="jadejaODIHA.csv",type="bowling",matchType='ODI')
#' # Get the data for Kohli in T20s for batting
#' df=getPlayerDataHA(profileNo=253802,tfile="kohliT20HA.csv",matchType="T20")
#' }
#' @seealso
#' \code{\link{teamWinLossStatusVsOpposition}}
#' \code{\link{batsman4s}}
#'
#' @export
#'
getPlayerDataHA <- function(profileNo,tdir=".",tfile="player001.csv",type="batting",matchType="Test"){
    print("Working...")
    # Check if matchType is Test
    if(matchType == "Test"){
        home <- getPlayerData(profile=profileNo,homeOrAway=c(1),type=type) # Home
        away <- getPlayerData(profile=profileNo,homeOrAway=c(2),type=type) # Away
        home$ha="home"
        away$ha="away"
        df <-rbind(home,away)
    }  else if (matchType == "ODI"){ # For ODIs
        home <- getPlayerDataOD(profile=profileNo,homeOrAway=c(1),type=type) #Home
        away <- getPlayerDataOD(profile=profileNo,homeOrAway=c(2),type=type) #Away
        neutral <- getPlayerDataOD(profile=profileNo,homeOrAway=c(3),type=type) #Neutral
        home$ha="home"
        away$ha="away"
        neutral$ha="neutral"
        df <-rbind(home,away,neutral)
    } else if (matchType == "T20"){ #T20
        home <- getPlayerDataTT(profile=profileNo,homeOrAway=c(1),type=type) #Home
        away <- getPlayerDataTT(profile=profileNo,homeOrAway=c(2),type=type) #Away
        neutral <- getPlayerDataTT(profile=profileNo,homeOrAway=c(3),type=type) #Neutral
        home$ha="home"
        away$ha="away"
        neutral$ha="neutral"
        df <-rbind(home,away,neutral)

    }
    dir.create(tdir,mode="0777",showWarnings=FALSE)
    file <-paste(tdir,tfile,sep="/")

    file.create(file)

    # Write to file
    write.csv(df,file=file)

    #Return dataframe
    df

}
