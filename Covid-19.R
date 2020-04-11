# Covid-19 selected counties and regions
library(tidyverse)

data <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")

ga <- data %>%
  filter(county %in% c("Fulton", "DeKalb", "Cobb") & state == "Georgia")
vt <- data %>% filter(state == "Vermont")
philly <- data %>% filter(fips == "42101")
nyc <- data %>% filter(county == "New York City")
washington <- data %>% filter(state == "Washington")
la <- data %>% filter(fips == "06037")
dmv <- data %>% 
  filter(fips %in% c("11001", "51059", "24031", "24033", "51153", "51013", "24003", "24017", "51107", "51061"))

# rbind - appending rows
regions <- rbind(ga, vt, philly, nyc, washington, la, dmv )
regions <- regions %>% 
  select(-fips)

# rename variable labels
regions$state <- fct_recode(regions$state, Atlanta = "Georgia", Philadelphia = "Pennsylvania", Los_Angeles = "California")

regions$state <- fct_recode(regions$state, DMV = "District of Columbia", DMV = "Maryland", DMV = "Virginia")
                            
# rename variable name from state to region
names(regions) [3] <- "region"

# Calculate cumulative
regions <- regions %>%
  group_by(date, region) %>%
  summarise(cases = sum(cases), deaths = sum(deaths))

regions <- ungroup(regions)

spain <- read_csv("https://covid19.isciii.es/resources/serie_historica_acumulados.csv")
spain <- spain %>%
  select(FECHA, CCAA, CASOS, Fallecidos) %>%
  filter(CCAA %in% c("CT", "MD"))
colnames(spain) <- c("date", "region", "cases", "deaths")

#Converting date for Spain to match
spain$date <- as.Date(spain$date, "%d/%m/%y")

spain$region <- fct_recode(spain$region, Madrid = "MD", Catalunya = "CT")

# Append the spain and regions data
regions <- rbind(regions, spain)

## Korea
korea <-  read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv") %>% mutate("country"=`Country/Region`) %>% select(-one_of("Province/State", "Country/Region", "Lat", "Long")) %>% pivot_longer(-country, names_to="date", values_to="cases") %>% mutate(date=as.Date(date, format="%m/%d/%y")) %>% group_by(country, date) %>% summarise(cases=sum(cases)) %>% filter(country == "Korea, South")

korea.deaths <-  read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv") %>% mutate("country"=`Country/Region`) %>% select(-one_of("Province/State", "Country/Region", "Lat", "Long")) %>% pivot_longer(-country, names_to="date", values_to="deaths") %>% mutate(date=as.Date(date, format="%m/%d/%y")) %>% group_by(country, date) %>% summarise(deaths=sum(deaths)) %>% filter(country == "Korea, South") %>% ungroup() %>% select(-country)

korea <- korea %>% left_join(korea.deaths, by = "date")
korea$region <- "Korea"
korea <- korea %>% ungroup() %>% select(date, region, cases, deaths)
regions <- rbind(regions, korea)

# Create lags
regions <- regions %>% 
  group_by(region) %>%
  mutate(lag.deaths = lag(deaths, n = 1, default = NA)) %>% 
  mutate(daily.deaths = deaths - lag.deaths) %>%
  mutate(lag.cases = lag(cases, n = 1, default = NA)) %>% 
  mutate(daily.cases = cases - lag.cases)

# Rolling averages (7)
regions <- regions %>%
  group_by(region) %>%
  mutate(rollave7.deaths = (deaths-lag(deaths, n = 7))/7)
regions <- regions %>%
  group_by(region) %>%
  mutate(rollave7.cases = (cases-lag(cases, n = 7))/7)

# Per capita
populations <- read_csv("populations.csv")
regions <- regions %>%
  left_join(populations, by = "region")

regions$deaths_percap <- (regions$rollave7.deaths/regions$population)*100000

regions$cases_percap <- (regions$rollave7.cases/regions$population)*100000

write_csv(regions, "regions.csv")

# Graphs
library(plotly)

ggplotly(ggplot(data =  regions, mapping = aes(x = date, y = rollave7.deaths, color = region)) + geom_smooth())

ggplotly(ggplot(data =  regions, mapping = aes(x = date, y = rollave7.cases, color = region)) + geom_smooth())

ggplotly(ggplot(data =  regions, mapping = aes(x = date, y = rollave7.deaths, color = region)) + geom_smooth(se=FALSE) + scale_y_log10() + scale_color_viridis(option = "B", discrete = TRUE))

ggplot(data =  regions, mapping = aes(x = date, y = rollave7.deaths, color = region)) + geom_smooth(se=FALSE) + theme_minimal()+ scale_y_log10() + scale_color_viridis(option = "D", discrete = TRUE)

ggplotly(ggplot(data =  regions, mapping = aes(x = date, y = rollave7.cases, color = region)) + geom_smooth(se=FALSE) + scale_y_log10())

ggplot(data =  regions, mapping = aes(x = date, y = rollave7.deaths, color = region)) + geom_smooth(se=FALSE) + scale_y_log10()


# Graphs per capita
ggplotly(ggplot(data =  regions, mapping = aes(x = date, y = cases_percap, color = region)) + geom_line() + theme_minimal() + labs(x = "Date", y = "Cases per 100k/day"))


savehistory(file="mylog.apr10.covid")



