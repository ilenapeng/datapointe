library(tidyverse)
library(extrafont)

df <- read_csv("~/Documents/github/balanchine/balanchine.csv")

plot <- df %>%
#  # create column with individual colors for Tchaik and Stravinsky
#  mutate(era_color = case_when(
#    Composer == 'Peter Ilyitch Tschaikovsky' ~ 'Tchaikovsky',
#    Composer == 'Igor Stravinsky' ~ 'Stravinsky',
#    TRUE ~ `Composer era`
#  )) %>%
#  # relevel so the colors in scale_color_manual go in this order
#  mutate(era_color = fct_relevel(era_color, c("Baroque", "Classical", "Romantic", "Tchaikovsky", "Modernist", "Neoclassical", "Stravinsky", "Impressionist", "Contemporary"))) %>%
  # relevel so the x axis is in the right order
  mutate(composer_era_factor = fct_relevel(`Composer era`, c("Baroque", "Classical", "Romantic", "Modernist", "Neoclassical", "Impressionist", "Contemporary"))) %>%
  # plot
  ggplot() + 
  geom_hline(yintercept=1948, color="gray", linewidth=0.5, linetype='dashed') + 
  geom_point(aes(x=composer_era_factor, y=Year, size=Dancers, color=composer_era_factor, stroke=NA), alpha=0.7) +
  scale_y_continuous(trans ='reverse', breaks=seq(1928, 1982, by = 18)) +
  scale_size_continuous(range = c(0.5,8)) +
  scale_color_manual(values=c("#F10D03", "#FA7D02", "#FECB18", "#95C940", "#53DFF0", "#6B53C8", "#FDABAC")) +
  labs(
    title="Mr. B's Ballets",
    subtitle="George Balanchine's works & the music he choreographed to\nDot size corresponds to number of dancers",
    caption="Data from The George Balanchine Trust | Chart by Ilena Peng",
    x="Musical era",
    y="Year created"
  ) +
  theme_minimal() +
  theme(
    plot.background=element_rect(fill="white", color="white"),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(),
    text=element_text(family="Baskerville", size=16),
    axis.title=element_blank(),
    legend.position="none",
    plot.caption=element_text(hjust=0.5, size=10),
    plot.title=element_text(hjust=0.5, face="bold", size=22),
    plot.subtitle=element_text(hjust=0.5, size=14),
    plot.margin=margin(1,1,1,1, unit="cm")
  )

print(plot)

ggsave("~/Documents/github/balanchine/balanchine_raw.png", width=9, height=10, unit="in")
