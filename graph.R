### air jordan, air jordan and yeezy, air jordan and nmd
air_jordan_single_line = air_jordan %>% filter(release_date > '2011-01-01') %>%
  filter(price_premium < 150) %>% 
  group_by(release_date) %>%
  summarise(mean_ = mean(price_premium)) %>% mutate(Category = "Air Jordan")

ggplot(air_jordan_single_line, aes(x = release_date, y = mean_, group =1)) +
  #geom_line() + 
  geom_point(size = 3, color = "#F8766D") + 
  geom_smooth(se = FALSE, size =1.5) +
  scale_x_date(date_labels = "%Y", date_breaks = '1 year') +
  #geom_abline(yintercept = 0, slope = 0, size = 1) +
  ggtitle('Average price premium of Air Jordan sneakers from 2011 to 2017') +
  ylab("Average Price Premium %") +
  xlab("") +
  theme(legend.position="none",
        plot.title = element_text(hjust = 0.5, size = 22, face = 'bold'),
        axis.text = element_text(size=20),
        axis.title = element_text(size = 20))+
  scale_color_manual(name = "category",
                     labels = "air jordan",
                     breaks = "air jordan") +
  theme(legend.key.size = unit(10,"mm"), 
        legend.text = element_text(size =12), 
        legend.title = element_text(size = 14))
  

yeezy_single_line = yeezy %>% filter(release_date > '2011-01-01') %>%
  group_by(release_date) %>%
  summarise(mean_ = mean(price_premium)) %>% 
  mutate(Category = "Yeezy") #%>%
  #filter(mean_ < 600)

ggplot(yeezy_single_line, aes(x = release_date, y = mean_, group =1)) +
  #geom_line() + 
  geom_point() + 
  geom_smooth() +
  scale_x_date(date_labels = "%Y", date_breaks = '1 year')

nmd_single_line = nmd %>% filter(release_date > '2011-01-01') %>%
  filter(price_premium < 900) %>%
  group_by(release_date) %>%
  summarise(mean_ = mean(price_premium)) %>% 
  mutate(Category = "NMD")

ggplot(nmd_single_line, aes(x = release_date, y = mean_, group =1)) +
  #geom_line() + 
  geom_point() + 
  geom_smooth() +
  scale_x_date(date_labels = "%Y", date_breaks = '1 year')
#cobine air jordan and nmd
air_jordan_nmd_single_line = rbind(air_jordan_single_line, nmd_single_line)
############## graph air jordan and nmd
ggplot(air_jordan_nmd_single_line, aes(x = release_date, y = mean_, 
                                         group = Category, 
                                         color = Category, 
                                         linetype =Category)) +
  #geom_line() + 
  geom_point(size = 4, aes(shape = Category)) + 
  geom_smooth(se = FALSE, color = "blue", size =1.5) +
  scale_x_date(date_labels = "%Y", date_breaks = '1 year') +
  scale_linetype_discrete(name = "Category", breaks=c("Air Jordan", "NMD")) +
  scale_linetype_manual(values =c("Air Jordan" = 1, "NMD" =2)) +
  theme(legend.key.size = unit(10,"mm"), 
        legend.text = element_text(size =18), 
        legend.title = element_text(size = 20)) +
  ggtitle('Average price premium of Air Jordan and NMD sneakers from 2011 to 2017') +
  ylab("Average Price Premium %") +
  xlab("") +
  theme(plot.title = element_text(hjust = 0.5, size = 22, face = 'bold'),
        axis.text = element_text(size=20),
        axis.title = element_text(size = 20)) +
  scale_color_manual(values = c('#F8766D', '#7CAE00'))

  
  


#combine air jordan and yeezy
air_jordan_yeezy_single_line = rbind(air_jordan_single_line, yeezy_single_line)

ggplot(air_jordan_yeezy_single_line, aes(x = release_date, y = mean_, 
                                         group = Category, 
                                         color = Category, 
                                         linetype =Category)) +
  #geom_line() + 
  geom_point(size = 4, aes(shape = Category)) + 
  geom_smooth(se = FALSE, color = "blue", size =1.5) +
  scale_x_date(date_labels = "%Y", date_breaks = '1 year') +
  scale_linetype_discrete(name = "Category", breaks=c("Air jordan", "Yeezy")) +
  scale_linetype_manual(values =c("Air Jordan" = 1, "Yeezy" =6)) +
  theme(legend.key.size = unit(10,"mm"), 
        legend.text = element_text(size = 18), 
        legend.title = element_text(size = 20)) +
  ggtitle('Average price premium of Air Jordan and Yeezy sneakers from 2011 to 2017') +
  ylab("Average Price Premium %") +
  xlab("") +
  theme(
    plot.title = element_text(hjust = 0.5, size = 22, face = 'bold'),
        axis.text = element_text(size=20),
        axis.title = element_text(size = 20)) #+
  # scale_color_manual(name = "Category", 
  #                    labels = c('Air Jordan', 'Yeezy'), 
  #                    values=c("black", "yellow"))





### style datasets ###
air_jordan_size_premium = air_jordan %>% 
  mutate(model = gsub('.* ([0-9]+).*','\\1',air_jordan$name)) %>%
  mutate(model = as.numeric(model)) %>% 
  filter(!is.na(model)) %>% filter(model <= 23 & model > 0) %>% 
  filter(price_premium < 150) %>%
  group_by(model) %>%
  summarise(premium_mean = mean(price_premium), 
            total_number = sum(number_sales), sales_premium = premium_mean * total_number) %>%
  mutate(model = as.factor(model))

ggplot(air_jordan_size_premium, aes(x = model, y = total_number)) +
  geom_bar(stat = 'identity', aes(fill = model)) +
  ggtitle('Number of sales for each style from 2011 to 2017') +
  ylab("Number of Sales") +
  xlab("Style") +
  theme(legend.position="none",
        plot.title = element_text(hjust = 0.5, size = 22, face = 'bold'),
        axis.text = element_text(size=20),
        axis.title = element_text(size = 20))

ggplot(air_jordan_size_premium, aes(x = model, y = premium_mean)) +
  geom_bar(stat = 'identity', aes(fill = model)) +
  ggtitle('Average price premium for each style from 2011 to 2017') +
  ylab("Average Price Premium %") +
  xlab("Style") +
  theme(legend.position="none",
        plot.title = element_text(hjust = 0.5, size = 22, face = 'bold'),
        axis.text = element_text(size=20),
        axis.title = element_text(size = 20))

ggplot(air_jordan_size_premium, aes(x = reorder(model, sales_premium), y = sales_premium)) +
  geom_bar(stat = 'identity', aes(fill = model)) +
  scale_y_continuous(labels = comma) +
  ggtitle('Average price premium × number of sales for each style from 2011 to 2017') +
  ylab("Average Price Premium × Number of Sales") +
  xlab("Style") +
  theme(legend.position="none",
        plot.title = element_text(hjust = 0.5, size = 22, face = 'bold'),
        axis.text = element_text(size=20),
        axis.title = element_text(size = 20))






### size datasets ###
size_2016_2018 = fread('~/Downloads/NYCDSA_week_5/Selenium/shoes_size.csv')
size_2015 = fread('~/Downloads/NYCDSA_week_5/Selenium/shoes_size2015.csv')
size_2014 = fread('~/Downloads/NYCDSA_week_5/Selenium/shoes_size2014.csv')
size_2011_2013 = fread('~/Downloads//NYCDSA_week_5/Selenium/shoes_size2013.csv')
size_2014_2018 = do.call(rbind, list(size_2011_2013, 
                                     size_2014, 
                                     size_2015, 
                                     size_2016_2018))
size_2016_2018_2 = size_2014_2018 %>% 
  mutate(model = gsub('.* ([0-9]+).*','\\1',size_2014_2018$V1)) %>%
  rename(name= 'V1') %>%
  rename(resell_data = 'V2') %>%
  rename(size = 'V3') %>%
  rename(resell_price = 'V4') %>%
  mutate(size = as.numeric(size)) %>%
  filter(!is.na(size)) %>%
  mutate(resell_price = as.numeric(gsub('\\$|\\,', '', resell_price))) %>%
  mutate(model = as.numeric(model)) %>% 
  filter(!is.na(model)) %>% 
  filter(model <= 23 & model > 0)  %>%
  filter(!is.na(size))
size_2016_2018_join = inner_join(size_2016_2018_2, air_jordan_join, by ='name')
size_2016_2018_premium = size_2016_2018_join %>% 
  mutate(price_premium = (resell_price-retail_price)/retail_price) %>%
  mutate(size = as.factor(size))
size_2016_2018_premium_summary = size_2016_2018_premium %>% group_by(size) %>%
  summarise(avg_premium = mean(price_premium)*100, count = n(), 
            total_premium_count = avg_premium * count)

### graph ###
ggplot(size_2016_2018_premium_summary, 
       aes(x = reorder(size, avg_premium),
           y = avg_premium)) +
  geom_bar(stat = 'identity', aes(fill = size)) +
  ggtitle('Average price premium for each size from 2011 to 2017') +
  ylab("Average Price Premium %") +
  xlab("Size") +
  theme(legend.position="none",
        plot.title = element_text(hjust = 0.5, size = 22, face = 'bold'),
        axis.text = element_text(size=20),
        axis.title = element_text(size = 20))

ggplot(size_2016_2018_premium_summary, 
       aes(x = reorder(size, count),
           y = count)) +
  geom_bar(stat = 'identity', aes(fill = size)) +
  ggtitle('Number of sales for each size from 2011 to 2017') +
  ylab("Number of Sales") +
  xlab("Size") +
  theme(legend.position="none",
        plot.title = element_text(hjust = 0.5, size = 22, face = 'bold'),
        axis.text = element_text(size=20),
        axis.title = element_text(size = 20))


ggplot(size_2016_2018_premium_summary, 
       aes(x = reorder(size, total_premium_count),
           y = total_premium_count)) +
  geom_bar(stat = 'identity', aes(fill = size)) +
  scale_y_continuous(labels = comma) +
  ggtitle('Average price premium × number of sales for each size from 2011 to 2017') +
  ylab("Average Price Premium × Number of Sales") +
  xlab("Size") +
  theme(legend.position="none",
        plot.title = element_text(hjust = 0.5, size = 22, face = 'bold'),
        axis.text = element_text(size=20),
        axis.title = element_text(size = 20))

air_jordan_join = air_jordan %>% select(c('name', 'retail_price'))
