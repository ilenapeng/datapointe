# load packages
library(tidyverse)
library(extrafont)

# load data
pdl_winners <- read_csv("pdl-winners.csv")

# define theme
plot_theme <- theme(
  text=element_text(family="Baskerville", color="black"), 
  plot.title=element_text(face="bold", size=16), 
  plot.subtitle=element_text(size=12), 
  plot.caption=element_text(size=8),
#  plot.margin=margin(1,1,1,1, "cm"),
  plot.background=element_rect(color="white"),
  panel.grid.major.y=element_blank(),
  axis.title=element_blank(),
  axis.text.x=element_text(color="black", size=12),
  axis.text.y=element_blank(),
  legend.position="left",
  legend.title=element_blank())

# make charts
## school bar chart
school_bar <- pdl_winners %>%
  filter(school!='NA') %>%
  ### Remove NA and people who forfeited/did not use their placement
  filter(!grepl('Forfeited|Did not use', school)) %>%
  count(school) %>%
  ggplot(aes(x=n, y=reorder(school, n))) + 
  scale_x_continuous(limits=c(0, 80), breaks = c(0, 20, 40, 60, 80)) +
  geom_bar(stat = "identity", fill='#8086F2', width=.5) +
  geom_text(aes(label = school), nudge_x = 0.75, hjust = 0, family="Baskerville") + 
  labs(
    title="More Than 70 Prizewinners Have Gone to London's\nRoyal Ballet & School",
    subtitle='Schools & companies selected by prizewinners') +
#    caption='Data from Prix de Lausanne\nChart by Ilena Peng') +
  theme_minimal() + plot_theme
print(school_bar)
ggsave('school.png', height=12, width=6, unit='in')

## nationality bar chart -- not in use
nationality_bar <- pdl_winners %>% count(nationality) %>%
  ### replace multiple nationality entries
  ggplot(aes(x=n, y=reorder(nationality, n))) + 
  scale_x_continuous(limits=c(0, 90), breaks = c(0, 20, 40, 60, 80)) +
  geom_bar(stat = "identity", fill='#CB9CF2', width=.5) +
  geom_text(aes(label = nationality), nudge_x = 0.75, hjust = 0) + 
  labs(
    title='More than 80 Japanese Dancers Have Been Prix de\nLausanne Prizewinners',
    subtitle='Prix winners by nationality, 1973-2022') + 
    #   caption='Data from Prix de Lausanne\nChart by Ilena Peng') +
    theme_minimal() + plot_theme
    print(nationality_bar)
    ggsave('nationality.png', height=12, width=6, unit='in')
