# Financial Market Analysis

Time series analysis of a publicly traded stock in R, using `quantmod` to pull
price data and compute returns, volatility bands, and trend indicators.

[Script](https://github.com/Caio-Felice-Cunha/Financial-Market-Analysis/blob/main/Time%20Series%20Analysis%20in%20the%20Financial%20Market.R) ·
[Report (PDF)](https://github.com/Caio-Felice-Cunha/Financial-Market-Analysis/blob/main/Time-Series-Analysis-in-the-Financial-Market-Report.pdf)

![image](https://user-images.githubusercontent.com/111542025/236521677-744baf37-fdc9-4c00-8002-8794e01ae444.png)

## What it does

Downloads daily OHLCV data for a Berkshire Hathaway B-share listing, then:

* plots a candlestick chart of the closing price,
* overlays Bollinger Bands (20-period mean, 2 standard deviations),
* adds an ADX trend-strength indicator (11-period EMA),
* computes daily log returns and their summary statistics (mean, standard deviation, skewness, kurtosis).

**Analysis window:** 2023-01-01 to 2023-04-04 (effective trading range 2023-01-02 to 2023-04-03).
**Data source:** Yahoo Finance, via `quantmod::getSymbols`.

## Data caveat

The ticker used is `BRKB.VI`, the Berkshire Hathaway B-share **cross-listing on the
Vienna stock exchange, quoted in EUR**, not the primary `BRK-B` listing on the NYSE
(USD). The Vienna listing is very thinly traded: in this window the report shows
daily volumes of 0 to a few lots and several days where Open = High = Low = Close at
zero volume. Because of that, the volume pane and the ADX indicator are computed on
stale or illiquid quotes and should be read with caution. For a liquid, reproducible
study, switch the ticker to `BRK-B` (NYSE) and re-run the script and report together.

## How to run

Requires R (4.x recommended) and three packages:

```r
install.packages(c("quantmod", "xts", "moments"))
```

Then run the script in R or RStudio:

```r
source("Time Series Analysis in the Financial Market.R")
```

The script downloads the data live from Yahoo Finance, draws the charts, prints the
return statistics, and saves a local `BRKB.VI.rds` copy of the data (gitignored).

## Results

Real figures from the committed report
([Time-Series-Analysis-in-the-Financial-Market-Report.pdf](https://github.com/Caio-Felice-Cunha/Financial-Market-Analysis/blob/main/Time-Series-Analysis-in-the-Financial-Market-Report.pdf)).
All values are for the EUR Vienna listing over 2023-01-02 to 2023-04-03.

**Daily log-return statistics**

| Measure            | Value          |
| ------------------ | -------------- |
| Mean               | -0.0003351317  |
| Standard deviation | 0.0095803274   |
| Skewness           | -0.7010818789  |
| Kurtosis           | 2.9240831030   |

Returns are roughly flat on average over the window, with daily volatility near 0.96%.
The negative skewness points to a longer left (downside) tail, and the kurtosis just
under 3 is close to the normal-distribution baseline.

**Bollinger Bands (20, 2) at end of period:** upper 294.688, lower 271.956, last price
283.799988 (EUR).

**First five closing prices:** 290.05, 292.60, 296.35, 295.35, 299.60 (EUR, for
2023-01-02 through 2023-01-06).

## Next steps

* Re-run on `BRK-B` (NYSE) for a liquid, USD-denominated series.
* Include additional stocks from other companies for comparison.
* Commit the report's R Markdown source so the PDF is reproducible.

## Disclaimer

A good part of this project was largely done in the Data Science Academy "Big Data
Analytics with R and Microsoft Azure Machine Learning" course (part of the Data
Scientist training). Licensed under MIT (see [LICENSE](LICENSE)).
