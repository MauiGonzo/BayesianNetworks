### initPackages.R

# check if all the packages required are there
# otherwise install them

packages <- c("readr", "dplyr", "lavaan", "lavaanPlot")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))
}
