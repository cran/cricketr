\name{getPlayerData}
\alias{getPlayerData}
\title{
Get the player data from ESPN Cricinfo based on specific inputs and store in a file in a given directory
}
\description{
Get the player data given the profile of the batsman. The allowed inputs are home,away or both and won,lost or draw of matches. The data is stored in a <player>.csv file in a directory specified. This function also returns a data frame of the player
}
\usage{
getPlayerData(profile,opposition="",host="",dir="./data",file="player001.csv",
type="batting", homeOrAway=c(1,2,3),result=c(1,2,4))
}
\arguments{
  \item{profile}{
This is the profile number of the player to get data. This can be obtained from https://www.espncricinfo.com/ci/content/player/index.html. Type the name of the player and click search. This will display the details of the player. Make a note of the profile ID. For e.g For Sachin Tendulkar this turns out to be
httsp://www.espncricinfo.com/india/content/player/35320.html. Hence the profile for Sachin is 35320
}
\item{opposition}{
The numerical value of the opposition country e.g.Australia,India, England etc. The values are 
Australia:2,Bangladesh:25,England:1,India:6,New Zealand:5,Pakistan:7,South Africa:3,Sri Lanka:8,
West Indies:4, Zimbabwe:9
}
\item{host}{
The numerical value of the host country e.g.Australia,India, England etc. The values are 
Australia:2,Bangladesh:25,England:1,India:6,New Zealand:5,Pakistan:7,South Africa:3,Sri Lanka:8,
West Indies:4, Zimbabwe:9
}
\item{dir}{
Name of the directory to store the player data  into. If not specified the data is stored in a default directory "./data". Default="./data"
}
\item{file}{
Name of the file to store the data into for e.g. tendulkar.csv. This can be used for subsequent functions. Default="player001.csv"
}
\item{type}{
type of data required. This can be "batting" or "bowling"
}
\item{homeOrAway}{
This is onw of  1,2,3. 1 is for home 2 is for away and 3 is for neutral venue
}
\item{result}{
This is a vector that can take values 1,2,4. 1 - won match 2- lost match 4- draw 
}
}
\details{
More details can be found in my short video tutorial in Youtube
https://www.youtube.com/watch?v=q9uMPFVsXsI
}
\value{
Returns the player's dataframe
}
\references{
https://www.espncricinfo.com/ci/content/stats/index.html\cr
https://gigadom.in/
}
\author{
Tinniam V Ganesh
}
\note{
Maintainer: Tinniam V Ganesh <tvganesh.85@gmail.com>
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{getPlayerDataSp}}
}
\examples{
\dontrun{
# Both home and away. Result = won,lost and drawn
tendulkar <-getPlayerData(35320,dir="../cricketr/data", file="tendulkar1.csv",
type="batting", homeOrAway=c(1,2,3),result=c(1,2,4))

# Only away. Get data only for won and lost innings
tendulkar <-getPlayerData(35320,dir="../cricketr/data", file="tendulkar2.csv",
type="batting",homeOrAway=c(2),result=c(1,2))

# Get bowling data and store in file for future
kumble <- getPlayerData(30176,dir="../cricketr/data",file="kumble1.csv",
type="bowling",homeOrAway=c(1),result=c(1,2))

#Get the Tendulkar's Performance against Australia in Australia
tendulkar <-getPlayerData(35320, opposition = 2,host=2,dir=".", 
file="tendulkarVsAusInAus.csv",type="batting") 
}

}
