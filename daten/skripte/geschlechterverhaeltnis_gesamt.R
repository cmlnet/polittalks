library(dplyr)
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(ggthemes)
library(Cairo)

# Daten
data <- read.csv("datensaetze/geschlechterverhaeltnis_gesamt.csv", dec = ",", stringsAsFactors=TRUE, na.strings = "0.000000")

plot <- ggplot(data, aes(x = Geschlecht, y = Prozent, label = paste(round(Prozent, 1), "%"), fill = Geschlecht, weight = Prozent)) + 
  geom_bar(stat = "identity") +
  geom_text(size = 5, position = position_dodge(width = 1), vjust = -0.5) +
  ylab("Anteil") +
  xlab("") +
  ylim(0,75) +
  theme_ipsum() +
  scale_fill_brewer(palette = "RdYlBu") +
  theme(legend.position = "none")
print(plot)

# Speichern als
## PNG
ggsave("grafiken/plot_geschlechterverhaeltnis_gesamt.png", plot, type="cairo", dpi = "retina")
## PDF
ggsave("grafiken/plot_geschlechterverhaeltnis_gesamt.pdf", plot, device=cairo_pdf, dpi = 600)
## SVG
ggsave("grafiken/plot_geschlechterverhaeltnis_gesamt.svg", plot)
