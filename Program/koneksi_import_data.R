#untuk membuat koneksi dengan postgresql 
install.packages("DBI")
install.packages("RPostgreSQL")
library(DBI)
library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host="localhost", user="postgres", password="admin", dbname="outlier", port="5432")

query <-"select 
gen_month,
count(acq_date)
FROM generate_series(DATE '2000-11-01', DATE '2015-03-31', '1  WEEK') m(gen_month)
LEFT OUTER JOIN hotspot_2001_2015_riau
ON (acq_date BETWEEN gen_month AND gen_month + INTERVAL '1 WEEK' - INTERVAL '1' DAY)
GROUP BY gen_month ORDER BY gen_month"

rs <- dbSendQuery(con, query)

## fetch all elements from the result set
data_titik_panas_2001_2015_riau <- fetch(rs,n=-1)

## Submit and execute the query
##dbGetQuery(con, "select * from R_packages")

## Closes the connection
dbDisconnect(con)

## Frees all the resources on the driver
dbUnloadDriver(drv)
data_titik_panas_2001_2015_riau[110]
