library(dplyr)
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(ggthemes)
library(Cairo)

# Daten
data <- read.csv("datensaetze/politikebenen.csv", dec = ",", stringsAsFactors=TRUE, na.strings = "0.000000")
# Entferne 0%-Anteile
#data$Prozent[data$Prozent==0.000000] <- NA
# Abfolge auf x-Achse festlegen
data$Ebene <- factor(data$Ebene,levels = c("Bundespolitik", "Landespolitik", "EU-Politik", "Behörden", "Kommunalpolitik", "Ausländische Politik", "Sonstige Politik"))

# Plot
plot <- ggplot(data) +
  aes(x = Ebene, fill = Ebene, y = Prozent) +
  geom_bar(stat = "identity") +
  scale_y_continuous(limits=c(0,70)) +
  geom_text(aes(label = paste(round(Prozent), "%")), vjust=-0.3, size=2.8) +
  labs(x = element_blank(), y = "%-Anteil") +
  scale_fill_brewer(palette = "RdYlBu", type = "qual", guide = "legend") +
  #hrbrthemes::theme_ipsum() +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())
  #facet_wrap(vars(Sendung), ncol = 2L)
print(plot)

# Speichern als
## PNG
ggsave("grafiken/plot_politikebenen.png", plot, type="cairo", dpi = "retina")
## PDF
ggsave("grafiken/plot_politikebenen.pdf", plot, device=cairo_pdf, dpi = 600)
## SVG
ggsave("grafiken/plot_politikebenen.svg", plot)
