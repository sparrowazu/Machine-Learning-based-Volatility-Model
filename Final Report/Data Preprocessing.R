setwd("C:/Users/maian/OneDrive - University of Waterloo/Documents/UW/W24/AFM423/Homeworks")
load("data_ml.RData")


# Keeping only stocks with full data. 

data_ml %>%
  group_by(date)
data_ml <- data_ml %>% 
  filter(date > "1999-12-31",         # Keep the date with sufficient data points
         date < "2019-01-01") %>%
  arrange(stock_id, date) 

stock_ids <- levels(as.factor(data_ml$stock_id)) # A list of all stock_ids
stock_days <- data_ml %>%                        # Compute the number of data points per stock
  group_by(stock_id) %>% summarize(nb = n()) 
stock_ids_short <- stock_ids[which(stock_days$nb == max(stock_days$nb))] # Stocks with full data

#Returns is the wide format
returns <- data_ml %>%                           # Compute returns, in matrix format, in 3 steps:
  filter(stock_id %in% stock_ids_short) %>%    # 1. Filtering the data
  dplyr::select(date, stock_id, R1M_Usd) %>%   # 2. Keep returns along with dates & firm names
  pivot_wider(names_from = "stock_id", 
              values_from = "R1M_Usd")     

## Test set for wide format data (returns)

separation_date <- as.Date("2014-01-15")
training_sample <- filter(returns, date < separation_date)
testing_sample <- filter(returns, date >= separation_date)


## Long format 

returns_long <- data_ml %>%                           # Compute returns, in matrix format, in 3 steps:
  filter(stock_id %in% stock_ids_short) %>%    # 1. Filtering the data
  dplyr::select(date, stock_id, R1M_Usd)   # 2. Keep returns along with dates & firm names

training_sample_long <- filter(returns_long, date < separation_date)
testing_sample_long <- filter(returns_long, date >= separation_date)











