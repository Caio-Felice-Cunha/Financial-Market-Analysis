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
# Data caveat: BRKB.VI is the Berkshire Hathaway B-share cross-listing on the
# Vienna stock exchange, quoted in EUR. It is very thinly traded (daily volumes
# of 0 to a few lots in this window), so the volume pane and the ADX indicator
# below are computed on stale/illiquid quotes and should be read with caution.
# The canonical, liquid listing is "BRK-B" on the NYSE (USD).
getSymbols("BRKB.VI", src = "yahoo", from = startDate, to = endDate, auto.assign = TRUE)

# Checking the returned data type
class(BRKB.VI)
is.xts(BRKB.VI)

# Shows the first records for Berkshire Hathaway Inc. shares
head(BRKB.VI)


# Parsing the closing data
BRKB.VI.Close <- BRKB.VI[, 'BRKB.VI.Close']
is.xts(BRKB.VI.Close)
head(Cl(BRKB.VI),5)

# Now, let's plot the graph of Berkshire Hathaway Inc.
# Berkshire Hathaway Inc. candlestick chart
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
# Note: addBBands()/addADX() re-render the last chartSeries object, so re-draw
# the candlestick chart first to overlay the indicators on it (matches the report).
candleChart(BRKB.VI)
addBBands(n = 20, sd = 2)

# Adding the ADX indicator, average 11 of the exponential type
addADX(n = 11, maType = "EMA")

# Calculating daily logs
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
saveRDS(BRKB.VI, file = "BRKB.VI.rds") # Save data in binary format
Ptr = readRDS("BRKB.VI.rds")
dir()
head(Ptr)