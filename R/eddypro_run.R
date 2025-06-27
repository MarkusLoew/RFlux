eddypro_run <- function(siteID, path_eddypro_bin, path_eddypro_projfiles, showLOG=TRUE){

workdir <- getwd()
#setwd(path_eddypro_projfiles)
#setwd("..")
# eddypro.path <- getwd()
# eddypro needs a tmp folder right above the folder where its executable files are!
  #dir.create(paste0(getwd(),"/tmp")) 

if (Sys.info()[['sysname']]=="Darwin") command_OpSys <- " -s mac "
if (Sys.info()[['sysname']]=="Windows") command_OpSys <- " -s win "
if (Sys.info()[['sysname']]=="Linux") command_OpSys <- " -s linux "

# see help
#/eddypro_rp --help
#
 #Help for EddyPro-RP
 #--------------------
 #EddyPro-RP, version 7.0.9, build 2021-12-09, 12:00.
#
# USAGE: eddypro_rp [OPTION [ARG]] [PROJ_FILE]
#
 #OPTIONS:
  # [-s | --system [win | linux | mac]]  Operating system; if not provided assumes "win"
  # [-m | --mode [embedded | desktop]]   Running mode; if not provided assumes "desktop"
  # [-c | --caller [gui | console]]      Caller; if not provided assumes "console"
  # [-e | --environment [DIRECTORY]]     Working directory, to be provided in embedded mode; if not provided assumes \.
  # [-h | --help]                        Display this help and exit
  # [-v | --version]                     Output version information and exit

 #PROJ_FILE                              Path of project (*.eddypro) file; if not provided, assumes ..\ini\processing.eddypro
# acceptable command line for eddy pro - these all work
  # potentially exploiting a command line bug in eddypro regarding the temporary directory?
  # ./eddypro_rp -s linux -m /tmp -e /tmp ~/workdir/eddypro/processing/AU-Wom.eddypro
  # trick seems to be to use -m with the path to a writeable directory, not using the two official options [embedded | desktop]


  rp.command <- paste0(path_eddypro_bin, "/eddypro_rp", command_OpSys, "-m /tmp -e /tmp ", path_eddypro_projfiles, "/", siteID, ".eddypro")
  rp <- system(rp.command, intern=!showLOG)

  fcc.command <- paste0(path_eddypro_bin, "/eddypro_fcc", command_OpSys, "-m /tmp -e /tmp ", path_eddypro_projfiles, "/", siteID, ".eddypro")
  fcc <- system(fcc.command, intern=!showLOG)

cat("\n The results of EddyPro run are stored in ", path_eddypro_projfiles, "\n", sep="")
}
