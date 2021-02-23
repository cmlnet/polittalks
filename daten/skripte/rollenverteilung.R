library(dplyr)
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(ggthemes)
library(Cairo)

# Daten
data <- read.csv("datensaetze/rollenverteilung.csv", dec = ",", stringsAsFactors=TRUE, na.strings = "0.000000")
# Entferne 0%-Anteile
data$ProzAnteil[data$ProzAnteil==0.000000] <- NA
# Abfolge auf x-Achse festlegen
data$Sendung <- factor(data$Sendung,levels = c("Alle Sendungen", "ARD-Talks", "Anne Will", "Beckmann", "Günther Jauch", "Hart aber fair", "log in", "maybrit illner", "Menschen bei Maischberger"))

# Plot
plot <- ggplot(data) +
  aes(x = Rolle, fill = Rolle, y = ProzAnteil) +
  geom_bar(stat = "identity") +
  scale_y_continuous(limits=c(0,50)) +
  geom_text(aes(label = paste(round(ProzAnteil), "%")), vjust=-0.3, size=2.8) +
  labs(x = element_blank(), y = "%-Anteil") +
  scale_fill_brewer(palette = "RdYlBu", type = "qual", guide = "legend") +
  #hrbrthemes::theme_ipsum() +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
  facet_wrap(vars(Sendung), ncol = 2L)
print(plot)

# Speichern als
## PNG
ggsave("grafiken/plot_rollenverteilung.png", plot, type="cairo", dpi = "retina")
## PDF
ggsave("grafiken/plot_rollenverteilung.pdf", plot, device=cairo_pdf, dpi = 600)
## SVG
ggsave("grafiken/plot_rollenverteilung.svg", plot)
