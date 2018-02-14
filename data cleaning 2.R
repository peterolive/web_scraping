### yeezy data load and cleaning ###
yeezy = fread('~/Downloads/NYCDSA_week_5/Selenium/shoes_yeezy.csv', header = FALSE)

yeezy = yeezy %>% rename(name= 'V1') %>% 
  rename(retail_price = 'V2') %>% 
  rename(release_date = 'V3') %>%
  rename(number_sales = 'V4') %>%
  rename(price_premium = 'V5') %>%
  rename(average_sale_price = 'V6') %>%
  mutate(category = 'yeezy') %>%
  filter(price_premium != '--')

yeezy$release_date = as.Date(yeezy$release_date, '%Y-%m-%d')
yeezy = yeezy %>% mutate(retail_price = as.numeric(gsub('\\$|\\,', '', retail_price))) %>%
  mutate(number_sales = as.numeric(number_sales, number_sales)) %>%
  mutate(price_premium = as.numeric(gsub('%', '', fixed = TRUE, price_premium))) %>%
  mutate(average_sale_price = as.numeric(gsub('$', '', fixed = TRUE, average_sale_price)))

### nmd data load and cleaning ###
nmd = fread('~/Downloads/NYCDSA_week_5/Selenium/shoes_nmd.csv', header = FALSE)

nmd = nmd %>% rename(name= 'V1') %>% 
  rename(retail_price = 'V2') %>% 
  rename(release_date = 'V3') %>%
  rename(number_sales = 'V4') %>%
  rename(price_premium = 'V5') %>%
  rename(average_sale_price = 'V6') %>%
  mutate(category = 'nmd') %>%
  filter(price_premium != '--')

nmd$release_date = as.Date(nmd$release_date, '%Y-%m-%d')
nmd = nmd %>% mutate(retail_price = as.numeric(gsub('\\$|\\,', '', retail_price))) %>%
  mutate(number_sales = as.numeric(number_sales, number_sales)) %>%
  mutate(price_premium = as.numeric(gsub('%', '', fixed = TRUE, price_premium))) %>%
  mutate(average_sale_price = as.numeric(gsub('$', '', fixed = TRUE, average_sale_price)))

### air jordan data load and cleaning ###
air_jordan1 = fread('~/Downloads/NYCDSA_week_5/Selenium/shoes.csv', header = FALSE)
air_jordan2 = fread('~/Downloads/NYCDSA_week_5/Selenium/shoes_2008.csv', header = FALSE)
air_jordan3 = fread('~/Downloads/NYCDSA_week_5/Selenium/shoes_before2008.csv', header = FALSE)

air_jordan = do.call(rbind, list(air_jordan1, air_jordan2, air_jordan3))

air_jordan = air_jordan %>% rename(name= 'V1') %>% 
  rename(retail_price = 'V2') %>% 
  rename(release_date = 'V3') %>%
  rename(number_sales = 'V4') %>%
  rename(price_premium = 'V5') %>%
  rename(average_sale_price = 'V6') %>%
  mutate(category = 'air jordan') %>%
  filter(price_premium != '--')

sneakers = do.call(rbind, list(yeezy, nmd, air_jordan))

#sneakers = sneakers %>% mutate(retail_price = as.numeric(gsub('\\$|\\,', '', retail_price)))

#sneakers = sneakers %>% filter(is.na(retail_price))
#sneakers = sneakers %>% filter(is.na(average_sale_price))
# sneakers = sneakers %>% mutate(retail_price = substring(retail_price, 2,2)) %>%
#   mutate(retail_price = as.numeric(retail_price))
#sneakers = sneakers %>% filter(retail_price != '$')
sneakers$release_date = as.Date(sneakers$release_date, '%Y-%m-%d')
sneakers = sneakers %>% mutate(retail_price = as.numeric(gsub('\\$|\\,', '', retail_price))) %>%
  mutate(number_sales = as.numeric(number_sales, number_sales)) %>%
  mutate(price_premium = as.numeric(gsub('%', '', fixed = TRUE, price_premium))) %>%
  mutate(average_sale_price = as.numeric(gsub('$', '', fixed = TRUE, average_sale_price)))
######
sneakers1 = sneakers %>% mutate(premium = avg_)
######
air_jordan = air_jordan %>%
  mutate(release_date = replace(release_date, release_date == '6/28/17', '2017-06-28'))
air_jordan$release_date = as.Date(air_jordan$release_date, '%Y-%m-%d')
air_jordan = air_jordan %>% mutate(retail_price = as.numeric(gsub('\\$|\\,', '', retail_price))) %>%
  mutate(number_sales = as.numeric(number_sales, number_sales)) %>%
  mutate(price_premium = as.numeric(gsub('%', '', fixed = TRUE, price_premium))) %>%
  mutate(average_sale_price = as.numeric(gsub('$', '', fixed = TRUE, average_sale_price)))
############ first graph ##########
air_jordan_ = air_jordan %>% filter(release_date > '2011-01-01') %>%
  filter(price_premium < 150) 
air_jordan_single_line = air_jordan %>% filter(release_date > '2011-01-01') %>%
  filter(price_premium < 150) %>% 
  group_by(release_date) %>%
  summarise(med= median(price_premium))
# sneakers_ = sneakers %>% filter(release_date > '2011-01-01') %>%
#   filter(price_premium < 150)
yeezy_ = yeezy %>% filter(release_date > '2011-01-01') #%>%
  #filter(price_premium < 600)
nmd_ = nmd %>% filter(release_date > '2011-01-01') %>%
  filter(price_premium < 900)
air_yeezy = rbind(air_jordan_, yeezy_, nmd_)
air_yeezy_nmd = do.call(rbind, list(air_jordan_, yeezy_, nmd_))
### graph_1 ###
ggplot(air_jordan_, aes(x = release_date, y = price_premium, group =1)) +
  #geom_line() + 
  geom_point() + 
  geom_smooth() +
  scale_x_date(date_labels = "%Y", date_breaks = '1 year')

ggplot(air_jordan_single_line, aes(x = release_date, y = med, group =1)) +
  #geom_line() + 
  geom_point() + 
  geom_smooth() +
  scale_x_date(date_labels = "%Y", date_breaks = '1 year')

ggplot(yeezy, aes(x = release_date, y = price_premium, group =1)) +
  #geom_line() + 
  geom_point() + 
  geom_smooth() +
  scale_x_date(date_labels = "%Y", date_breaks = '1 year')


ggplot(nmd_, aes(x = release_date, y = price_premium, group =1)) +
  geom_line() + 
  geom_point() + 
  geom_smooth() +
  scale_x_date(date_labels = "%Y", date_breaks = '1 year')
################## graphy of yeezy, air jordan, nmd #################
ggplot(air_yeezy, aes(x = release_date, y = price_premium, group = category, color = category)) +
  geom_line() + 
  geom_point() + 
  geom_smooth(se = FALSE, col = "black") +
  scale_x_date(date_labels = "%Y", date_breaks = '1 year')
ggplot(air_yeezy_nmd, aes(x = release_date, y = price_premium, group = category, color = category)) +
  geom_line() + 
  geom_point() + 
  geom_smooth(se = FALSE, aes(color = category)) +
  scale_x_date(date_labels = "%Y", date_breaks = '1 year')
ggplot(air_yeezy_nmd, aes(x = release_date, y = price_premium, group = category, color = category)) +
  geom_line() + 
  geom_point() + 
  geom_smooth(se = FALSE, color = "black") +
  scale_x_date(date_labels = "%Y", date_breaks = '1 year')
ggplot(air_yeezy_nmd, aes(x = release_date, y = price_premium, group = category, color = category, linetype =category)) +
  # geom_line() +
  geom_point(size = 4, aes(shape = category)) +
  geom_smooth(se = FALSE, color = "black", size =1.5) +
  scale_x_date(date_labels = "%Y", date_breaks = '1 year') +
  scale_linetype_discrete(name = "category", breaks=c("air jordan", "nmd", "yeezy")) +
  scale_linetype_manual(values =c("air jordan" = 1, "nmd" =2, "yeezy"=6)) +
  theme(legend.key.size = unit(10,"mm"), 
        legend.text = element_text(size =12), 
        legend.title = element_text(size = 14))
  #scale_shape_manual(values=c("air jordan"=3, "nmd"=16, "yeezy"=17))
#######################################
ggplot(air_jordan, aes(x = price_premium, y = number_sales)) + 
  geom_point(position = 'jitter') +
  coord_cartesian(xlim = c(0, 5000), ylim = c(-100,1000)) +
  stat_smooth(method = "lm", col = "blue")
###################################

year_release = fread('~/Downloads/NYCDSA_week_5/Selenium/year.csv')

year_release = year_release %>% rename(name = 'V1') %>%
  rename(year = 'V2') %>% 
  group_by(year) %>% 
  summarise(count=n())
year_release$year = as.factor(year_release$year)
### graph_2 ###
ggplot(year_release, aes(x = year, y = count)) + 
  geom_bar(stat = 'identity', aes(fill = year)) +theme(legend.key.size = unit(10,"mm"), 
                                                       legend.text = element_text(size = 18), 
                                                       legend.title = element_text(size = 20)) +
  ggtitle('Number of styles released by Air Jordan from 2011 to 2017') +
  ylab("Number of Styles Released") +
  xlab("") +
  theme(legend.position = 'none',
    plot.title = element_text(hjust = 0.5, size = 22, face = 'bold'),
    axis.text = element_text(size=20),
    axis.title = element_text(size = 20))
###### sales of nmd #####
nmd_sales_per_year = nmd %>% mutate(year = as.numeric(format(release_date, '%Y'))) %>%
  filter(year <2018)
nmd_sales_per_year$year = as.factor(nmd_sales_per_year$year)
nmd_sales_per_year_count = nmd_sales_per_year %>% group_by(year) %>%
  summarise(count = n())
ggplot(nmd_sales_per_year_count, aes(x = year, y = count)) + 
  geom_bar(stat = 'identity', aes(fill = year))
########
air_jordan_model = air_jordan %>% mutate(model = gsub('.* ([0-9]+).*','\\1',air_jordan$name)) %>%
  mutate(model = as.numeric(model)) %>% 
  filter(!is.na(model)) %>% filter(model <= 23 & model > 0) %>%
  group_by(model) %>%
  summarise(total_number = sum(number_sales)) %>%
  mutate(model = as.factor(model))
### graph_3 ###
ggplot(air_jordan_model, aes(x = model, y = total_number)) +
  geom_bar(stat = 'identity', aes(fill = model))
######

air_jordan_size_premium = air_jordan %>% 
  mutate(model = gsub('.* ([0-9]+).*','\\1',air_jordan$name)) %>%
  mutate(model = as.numeric(model)) %>% 
  filter(!is.na(model)) %>% filter(model <= 23 & model > 0) %>% 
  filter(price_premium < 150) %>%
  group_by(model) %>%
  summarise(premium_mean = mean(price_premium)) %>%
  mutate(model = as.factor(model))
### mean bar ###
ggplot(air_jordan_size_premium, aes(x = reorder(model, premium_mean), y = premium_mean)) +
  geom_bar(stat = 'identity', aes(fill = model))

air_jordan_size_premium2 = air_jordan %>% mutate(model = gsub('.* ([0-9]+).*','\\1',air_jordan$name)) %>%
  mutate(model = as.numeric(model)) %>% 
  filter(!is.na(model)) %>% filter(model <= 23 & model > 0) %>%
  mutate(model = as.factor(model)) %>%
  filter(price_premium < 150)
df = df %>% mutate(model = as.factor(model))
### median based on model ###
ggplot(air_jordan_size_premium2, aes(x = reorder(model, price_premium, median), y = price_premium)) +
  geom_boxplot()
ggplot(df, aes(x = reorder(model, price_premium, median), y = price_premium)) +
  geom_boxplot()
### premium number ###
air_jordan_size_premium_number = air_jordan_size_premium2 %>%
  group_by(model) %>% summarise(med = median(price_premium), total_number = sum(number_sales),
                                med_retail_price = median(retail_price), 
                                size_premium = med * total_number * med_retail_price/100)
ggplot(air_jordan_size_premium_number, aes(x = reorder(model, size_premium), y = size_premium)) +
  geom_bar(stat = 'identity', aes(fill = model))



### compare median of air_jordan_size_premium and df ###
df3 = air_jordan_size_premium2 %>% group_by(model) %>% summarise(med = median(price_premium))
df4 = df %>% group_by(model) %>% summarise(med = median(price_premium))

### size datasets ###
size_2016_2018 = fread('~/Downloads/NYCDSA_week_5/Selenium/shoes_size.csv')
size_2016_2018_1 = size_2016_2018 %>% 
  mutate(model = gsub('.* ([0-9]+).*','\\1',size_2016_2018$V1)) %>%
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
size_2016_2018_join = inner_join(size_2016_2018_1, air_jordan_join, by ='name')
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
  geom_bar(stat = 'identity', aes(fill = size))

ggplot(size_2016_2018_premium_summary, 
       aes(x = reorder(size, count),
           y = count)) +
  geom_bar(stat = 'identity', aes(fill = size)) 

ggplot(size_2016_2018_premium_summary, 
       aes(x = reorder(size, total_premium_count),
           y = total_premium_count)) +
  geom_bar(stat = 'identity', aes(fill = size))





air_jordan_join = air_jordan %>% select(c('name', 'retail_price'))









