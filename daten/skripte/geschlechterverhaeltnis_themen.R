library(dplyr)
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(ggthemes)
library(ggrepel)
library(svglite)
library(Cairo)

# Daten
data <- read.csv("datensaetze/geschlechterverhaeltnis_themen.csv", dec = ",", stringsAsFactors=TRUE, na.strings = "0.000000")
# Entferne 0%-Anteile
data$Prozent[data$Prozent==0] <- NA
# Abfolge auf x-Achse festlegen
#data$Sendung <- factor(data$Sendung,levels = c("Alle Sendungen (n=1441)", "ARD-Talks (n=1044)", "Anne Will (n=214)", "Beckmann (n=196)", "Günther Jauch (n=203)", "hart aber fair (n=193)", "log in (n=160)", "maybrit illner (n=237)", "Maischberger (n=238)"))
data$Prozent <- data$Prozent * 100

plot <- ggplot(data) +
  aes(x = Geschlecht, fill = Geschlecht, y = Prozent) +
  geom_bar(stat = "identity") +
  scale_y_continuous(limits=c(0,90)) +
  geom_text(aes(label = paste(round(Prozent), "%")), vjust=-0.3, size=2.8) +
  labs(x = element_blank(), y = "%-Anteil") +
  scale_fill_brewer(palette = "RdYlBu") +
  #hrbrthemes::theme_ipsum() +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
  facet_wrap(vars(Themenbereich), ncol = 2L)
print(plot)

# Speichern als
## PNG
ggsave("grafiken/plot_geschlechterverhaeltnis_themen.png", plot, type="cairo", dpi = "retina")
## PDF
ggsave("grafiken/plot_geschlechterverhaeltnis_themen.pdf", plot, device=cairo_pdf, dpi = 600)
## SVG
ggsave("grafiken/plot_geschlechterverhaeltnis_themen.svg", plot)
