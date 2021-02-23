library(tikzDevice)
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(ggthemes)
library(ggrepel)

# Daten
data <- read.csv("datensaetze/parteizugehoerigkeit.csv", dec = ",", stringsAsFactors=TRUE, na.strings = "0.000000")
# Entferne 0%-Anteile
data$Prozent[data$Prozent==0] <- NA
# Abfolge auf x-Achse festlegen
data$Sendung <- factor(data$Sendung,levels = c("Bundestagswahl 2009", "Alle Sendungen", "Anne Will", "Beckmann", "Günther Jauch", "hart aber fair", "log in", "maybrit illner", "Menschen bei Maischberger"))
# Abfolge auf y-Achse festlegen
data$Partei <- factor(data$Partei,levels = c("CDU / CSU", "SPD", "FDP", "Grüne", "Die Linke.", "Piratenpartei", "Sonstige"))

# Plot
plot <- ggplot(data) +
  aes(x = Partei, fill = Partei, y = Prozent) +
  geom_bar(stat = "identity") +
  scale_y_continuous(limits=c(0,45)) +
  geom_text(aes(label = paste(round(Prozent), "%")), vjust=-0.3, size=2.8) +
  labs(x = element_blank(), y = "%-Anteil") +
  scale_fill_manual(values = c("black", "red", "yellow", "green", "violet", "orange", "grey")) +
  #hrbrthemes::theme_ipsum() +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
  facet_wrap(vars(Sendung), ncol = 2L)
print(plot)

# Speichern als
## PNG
ggsave("grafiken/plot_parteizugehoerigkeit.png", plot, type="cairo", dpi = "retina")
## PDF
ggsave("grafiken/plot_parteizugehoerigkeit.pdf", plot, device=cairo_pdf, dpi = 600)
## SVG
ggsave("grafiken/plot_parteizugehoerigkeit.svg", plot)
