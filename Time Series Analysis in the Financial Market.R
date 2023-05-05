# Time Series Analysis in the Financial Market

# http://www.quantmod.com


# Install and load the packages
# install.packages("quantmod")
# install.packages("xts")
# install.packages("moments")
library(quantmod)
library(xts)
library(moments)


# Selection of analysis period
startDate = as.Date("2023-01-01")
endDate = as.Date("2023-04-04")

# Download period data
# Note: Yahoo Finance is undergoing changes and the online quotes service may be unstable
?getSymbols
getSymbols("BRKB.VI", src = "yahoo", from = startDate, to = endDate, auto.assign = T)

# Checking the returned data type
class(BRKB.VI)
is.xts(BRKB.VI)

# Shows the first records for Berkshire Hathaway Inc. shares
head(BRKB.VI)
View(BRKB.VI)


# Parsing the closing data
BRKB.VI.Close <- BRKB.VI[, 'BRKB.VI.Close']
is.xts(BRKB.VI.Close)
?Cl
head(Cl(BRKB.VI),5)

# Now, let's plot the graph of Berkshire Hathaway Inc.
# Berkshire Hathaway Inc. candlestick chart
?candleChart
candleChart(BRKB.VI)

# Closing Plot
plot(BRKB.VI.Close, main = "Daily Closing Berkshire Hathaway Inc. Shares",
     col = "red", xlab = "Date", ylab = "Price", major.ticks = 'months',
     minor.ticks = FALSE)


# Added bollinger bands to the chart, with 20 period average and 2 deviations
# Bollinger Band
# Since the standard deviation is a measure of volatility,
# Bollinger Bands adjust to market conditions. more volatile markets,
# have the bands furthest from the mean, while less volatile markets have the
# stalls closest to the average
?addBBands
addBBands(n = 20, sd = 2)

# Adding the ADX indicator, average 11 of the exponential type
?addADX
addADX(n = 11, maType = "EMA")

# Calculating daily logs
?log
BRKB.VI.ret <- diff(log(BRKB.VI.Close), lag = 1)


# Remove NA values in transition 1
BRKB.VI.ret <- BRKB.VI.ret[-1]

# Plot the rate of return
plot(BRKB.VI.ret, main = "Daily Closing of Berkshire Hathaway Inc. Shares",
     col = "red", xlab = "Date", ylab = "Return", major.ticks = 'months',
     minor.ticks = FALSE)


# Calculating some statistical measures
statNames <- c("Mean", "Standard Deviation", "Skewness", "Kurtosis")
BRKB.VI.stats <- c(mean(BRKB.VI.ret), sd(BRKB.VI.ret), skewness(BRKB.VI.ret), kurtosis(BRKB.VI.ret))
names(BRKB.VI.stats) <- statNames
BRKB.VI.stats


# Saving the data in a .rds file (R binary format file)
# getSymbols("BRKB.VI", src = 'yahoo')
saveRDS(BRKB.VI, file = "BRKB.VI.rds") # Save data in binary format
Ptr = readRDS("BRKB.VI.rds")
dir()
head(Ptr)