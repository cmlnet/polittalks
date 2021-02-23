library(dplyr)
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(ggthemes)
library(ggrepel)
library(svglite)
library(Cairo)

# Daten
data <- read.csv("datensaetze/journalisten_experten.csv", dec = ",", stringsAsFactors=TRUE, na.strings = "0.000000")
# Entferne 0%-Anteile
data$Prozent[data$Prozent==0.000000] <- NA
# Abfolge auf x-Achse festlegen
data$Sendung <- factor(data$Sendung,levels = c("Anne Will", "Beckmann", "Günther Jauch", "hart aber fair", "log in", "maybrit illner", "Menschen bei Maischberger"))

# Plot
plot <- ggplot(data) +
  aes(x = Typ, fill = Typ, y = Prozent) +
  geom_bar(stat = "identity") +
  scale_y_continuous(limits=c(0,25)) +
  geom_text(aes(label = paste(round(Prozent), "%")), vjust=-0.3, size=2.8) +
  labs(x = element_blank(), y = "%-Anteil") +
  scale_fill_brewer(palette = "RdYlBu") +
  #hrbrthemes::theme_ipsum() +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
  facet_wrap(vars(Sendung), ncol = 2L)
print(plot)

# Speichern als
## PNG
ggsave("grafiken/plot_journalisten_experten.png", plot, type="cairo", dpi = "retina")
## PDF
ggsave("grafiken/plot_journalisten_experten.pdf", plot, device=cairo_pdf, dpi = 600)
## SVG
ggsave("grafiken/plot_journalisten_experten.svg", plot)
