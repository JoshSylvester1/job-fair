rm(list = ls())
library(tidyverse)
library(gtExtras)
library(RColorBrewer)
library(ggrepel)
library(rsconnect)
#install.packages('gtExtras')
wd <- here::here()
source("maintheme.r")
source('theme_side_text.R')

datadir <- str_c(wd,"/data/")
setwd(datadir)


df1 <- readxl::read_excel(str_c(datadir, "2024 Job Fairs.xlsx")) %>%
  janitor::clean_names()


df2 <- df1 %>%
  select(date,event_name,employer,job_seekers,job_offer,follow_up_interview) %>%
  mutate(date = as.Date(date)) %>%
  filter(date >= '2024-01-01') %>%
  drop_na()



employer <- ggplot(data = df2, aes(x = event_name, y = employer, fill = event_name)) +
  geom_bar(stat = "identity")+
  theme_side_text +
  geom_text(data = df2, aes(label = employer, colour = event_name, vjust = -.05)) +
  labs(x = 'Event Name', y = 'Number of Employers',
       title = 'Number of Employers')
employer


jobseeker <- ggplot(data = df2, aes(x= event_name, y = job_seekers, fill = event_name)) +
  geom_bar(stat = 'identity') +
  theme_side_text +
  geom_text(data = df2, aes(label = job_seekers, colour = event_name, vjust = -.05))+
  labs(x = 'Event Name', y = 'Number of Job Seekers',
       title = 'Number of Job Seekers')

joboffer <- ggplot(data = df2, aes(x= event_name, y = job_offer, fill = event_name)) +
  geom_bar(stat = 'identity') +
  theme_side_text +
  geom_text(data = df2, aes(label = job_offer, colour = event_name, vjust = -.05))+
  labs(x = 'Event Name', y = 'Number of Job Offers',
       title = 'Number of Job Offers')


follow_up <- ggplot(data = df2, aes(x= event_name, y = follow_up_interview, fill = event_name)) +
  geom_bar(stat = 'identity') +
  theme_side_text +
  geom_text(data = df2, aes(label = follow_up_interview, colour = event_name, vjust = -.05)) +
  labs(x = 'Event Name', y = 'Number of Follow up Interviews',
       title = 'Number of Follow up Interviews')

 
df3 <- df2 %>%
  rename(Event = event_name)%>%
  rename(Employer = employer)%>%
  rename("Job Seekers" = job_seekers)%>%
  rename('Job Offers' = job_offer) %>%
  rename("Follow up Interview"=follow_up_interview)%>%
  gt() %>%
  tab_header(title = "2024 Job Fair Recap") %>%
  cols_align(align = 'left') 

df3 %>%
  gt_theme_nytimes() %>%
  gt_highlight_rows(rows = Event %in% c("LEDA Job Fair"),
                    fill = "steelblue" )



ggplot(data = df2, aes(x= event_name, y = job_seekers, fill = event_name)) +
  geom_bar(stat = 'identity', position = 'dodge') +
  labs(title = "2024 Job Seeker Data",
       caption = "source: 2024 Job Fair Collection")+
  main_theme

sum(df2$job_seekers)
sum(df2$employer)


ggplot(data = df2, aes(x = event_name, y = employer, fill = event_name)) +
  geom_bar(stat = "identity")+
  theme_side_text +
  geom_text(data = df2, aes(label = employer, colour = event_name, vjust = -.5))






df4 <- df2 %>%
  mutate(yes = sum(follow_up_interview)/sum(job_seekers)) %>%
  mutate(no = 1-yes) %>%
  head(1) %>%
  select(yes,no)

df5 <-df4 %>%
  pivot_longer(yes:no, names_to = 'n', values_to = 'value')

 pie <- ggplot(data = df5, aes(x = "", y = value, fill = n)) +
  geom_col(color ="black") +
  coord_polar("y", start = 0) +
  geom_text(aes(label = paste0(round(value*100), "%")), 
            position = position_stack(vjust = 0.5)) +
  theme(panel.background = element_blank(),
        axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank(), 
        legend.title = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  ggtitle("% of Job Seekers that Received a Follow up Interview") 











