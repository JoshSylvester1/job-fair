theme_side_text <- ggplot2::theme_light() +
  theme(axis.text = element_text(color = "blue"),
        axis.text.x = element_text(angle = -60),
        legend.position = "top",
        legend.title = element_blank(),
        legend.background = element_rect(fill = NA, colour = "transparent"),
        legend.key = element_rect(fill = NA, colour = "transparent"),
        axis.title.x = element_text(size = 8, face = "bold", color = "black"),
        axis.title.y = element_text(size = 8, face = "bold", color = "red"),
        panel.background = element_rect(fill = NA, color = "transparent"),
        plot.background = element_rect(fill = NA, color = "transparent"),
        panel.border = element_blank(),
        panel.grid.minor = element_blank(),
        plot.caption = element_text(color = "gray20", size = 6, hjust=0, vjust=0),
        plot.title = element_text(size = 11, face="bold", color = "blue", hjust=1, vjust=0),
        plot.subtitle = element_text(size = 9, face="plain", color = "orange", hjust=1, vjust=0),
        axis.line = element_line(size = 1, colour = "black")
  )



