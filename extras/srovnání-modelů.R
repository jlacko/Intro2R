library(tidyverse)

# načtení zdroje
dataset <- read_csv2("./data/potraviny.csv") %>% 
   filter(reprcen_kod == "0114701" & uzemi_kod == "19") %>% 
   mutate(rok = lubridate::year(obdobiod)) %>% 
   group_by(rok) %>% 
   summarise(prumer = mean(hodnota))

# natrénovat lineární model
p_lin <- lm(prumer ~ rok, data = dataset)

# natrénovat exponenciální model
p_exp <- nls(prumer ~ a * (1 + r)^(rok-min(dataset$rok)+1),
             data = dataset,
             start = list(a = 1, r = .01))

# společná škála k ověření dat
budoucnost <- data.frame(rok = 2000:2025)

# předpověď lineárním modelem
mod_lin <- data.frame(rok = budoucnost$rok,
                      prumer = predict(p_lin, newdata = budoucnost))

# předpověď exponenciálním modelem
mod_exp <- data.frame(rok = budoucnost$rok,
                      prumer = predict(p_exp, newdata = budoucnost))

# grafické srovnání dat & 2x výsledku
ggplot() +
   geom_point(data = dataset, aes(x = rok, y = prumer)) +
   geom_line(data = mod_lin, aes(x = rok, y = prumer), color = "red") +
   geom_line(data = mod_exp, aes(x = rok, y = prumer), color = "blue")
             

# vypsání výsledku - vyhrála funkce s menší absilutní hodnotou reziduálů
if(abs(sum(residuals(p_lin))) < abs(sum(residuals(p_exp)))) {
      print("vyhrála lineární") 
   } else {
      print("vyhrála exponenciální")
}