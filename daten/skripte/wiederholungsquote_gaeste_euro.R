library(tikzDevice)
library(dplyr)
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(ggthemes)

# Daten
data <- read.csv("datensaetze/wiederholungsquote_gaeste_euro.csv", dec = ",", stringsAsFactors=TRUE, na.strings = "0.000000")
# Abfolge auf x-Achse festlegen
data$Kategorie <- factor(data$Kategorie,levels = c("Politik", "Journalismus", "Experten", "Wirtschaft", "Zivilgesellschaft", "Kultur / Sport", "Religion", "Normalbürger"))

plot <- ggplot(data, aes(x = Kategorie, y = Quotient, label = Quotient, fill = Kategorie, weight = Quotient)) + 
  geom_bar(stat = "identity") +
  scale_x_discrete(guide = guide_axis(angle = 45)) +
  geom_text(size = 5, position = position_dodge(width = 1), vjust = -0.5) +
  ylab("") +
  xlab("") +
  ylim(0,2) +
  theme_ipsum() +
  scale_fill_brewer(palette = "RdYlBu") +
  theme(legend.position = "none")
print(plot)

# Speichern als
## PNG
ggsave("grafiken/plot_wdhquote_gaeste_euro.png", plot, type="cairo", dpi = "retina")
## PDF
ggsave("grafiken/plot_wdhquote_gaeste_euro.pdf", plot, device=cairo_pdf, dpi = 600)
## SVG
ggsave("grafiken/plot_wdhquote_gaeste_euro.svg", plot)
