library(tidyverse)
library(extrafont)

df_avg <- read_csv("~/Documents/github/datapointe/project-details/shoe-inflation/2023_avg_by_brand.csv")
df_hist <- read_csv("~/Documents/github/datapointe/project-details/shoe-inflation/over_time.csv")
df_inflation <- read_csv("~/Documents/github/datapointe/project-details/shoe-inflation/vs_inflation.csv")

# define theme
plot_theme <- theme(
  text=element_text(family="Baskerville", color="black"), 
  plot.title=element_text(face="bold", size=16), 
  plot.subtitle=element_text(size=12), 
  plot.caption=element_text(size=8),
  #  plot.margin=margin(1,1,1,1, "cm"),
  plot.background=element_rect(color="white"),
  axis.title=element_blank(),
  axis.text=element_text(color="black", size=12),
  legend.position="top",
  legend.title=element_blank())

plot1 <- ggplot(df_avg, aes(x=price, y=brand)) + 
  geom_bar(stat = "identity", fill="#F4D4C8", width=0.75) + 
  scale_y_discrete(limits=rev) +  
  geom_segment(x = 113.6860345, xend = 113.6860345, y = 0, yend = 12, linewidth = 1, linetype='longdash', colour = "#C79B6F") +
  labs(
    title='Nearly All Pointe Shoes Cost Over $100',
    subtitle='Average price by brand',
    caption='Source: Discount Dance'
  ) +
  theme_minimal() +
  theme(panel.grid=element_blank()) +
  plot_theme

print(plot1)
ggsave('~/Documents/github/datapointe/project-details/shoe-inflation/avg_by_brand.png', width=9, height=5, unit='in')

# all on one chart
plot2 <- ggplot(df_hist, aes(x=year, y=discount_dance_price, group=shoe, color=shoe)) +
  geom_line() +
  geom_point() +
  scale_color_manual(values=c('#DEA0CC', '#F77490', '#F4BCC8', '#C79B6F')) +
  labs(
    title='Pointe Shoe Prices Have Steadily Increased',
    subtitle='Prices for four popular models sold by retailer Discount Dance from 2011 to 2023',
    caption='Source: Discount Dance web archives\nData was unavailable for the Freed Studio Professional and Gaynor Minden shoes from 2017-19. 2018 data was unavailable for all four shoes.'
  ) +
  theme_minimal() +
  theme(plot.margin=margin(.5,4,.5,.5,unit="cm")) +
  plot_theme

print(plot2)
ggsave('~/Documents/github/datapointe/project-details/shoe-inflation/over_time.png', width=9, height=6, unit='in')

# facet grid
# ggplot(df_hist, aes(x=year, y=discount_dance_price)) +
#   geom_line() +
#   geom_point() +
#   facet_grid(cols = vars(brand)) +
#   theme(panel.grid.minor=element_blank()) +
#   plot_theme

plot3 <- ggplot(df_inflation) +
  geom_segment(aes(x=inflation_price_2023, xend=price_2023, y=shoe, yend=shoe), color="#F4D4C8") +
  geom_point(aes(x=inflation_price_2023, y=shoe), color='#F4BCC8', size=3) +
  geom_point(aes(x=price_2023, y=shoe), color='#C79B6F', size=3) +
  scale_y_discrete(limits=rev) +
  labs(
    title='Pointe Shoe Prices Have Risen More Than Overall Inflation',
    subtitle='Actual 2023 prices compared to expected prices based on the cumulative inflation rate',
    caption='Source: Actual prices from Discount Dance as of July 29, 2023\nExpected prices from the US Inflation Calculator'
  ) +
  theme_minimal() +
  theme(plot.margin=margin(.5,.5,.5,.5,unit="cm")) +
  plot_theme

print(plot3)
ggsave('~/Documents/github/datapointe/project-details/shoe-inflation/vs_inflation.png', width=9, height=4, unit='in')


  