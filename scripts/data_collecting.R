suppressPackageStartupMessages({
  require(dplyr)
  require(rvest)
  require(sp)
})

#'
#' Дані з ЦВК
#'

poly_dil <- readr::read_rds("data/poly_dil.rds")
coord_dil <- readr::read_csv("data/cordynaty_VD.csv", col_types = readr::cols())

get_parlament_election_2019_by_vd <- purrr::safely(function(x) {
  Sys.sleep(0.2)
  (read_html(paste0("https://www.cvk.gov.ua/pls/vnd2019/wp336pt001f01=919pf7331=", x, ".html")) %>% 
     html_table())[[2]] %>% as_tibble() %>% mutate(`№ ВД` = as.numeric(`№ ВД`))
})

parlament_election_2019_by_vd <- purrr::map_dfr(11:223, function(x) {
  cat(x, "\n")
  get_parlament_election_2019_by_vd(x)$result
})

fst::write_fst(parlament_election_2019_by_vd, "data/parlament_election_2019_by_vd.fst")

#https://www.cvk.gov.ua/pls/vnd2019/wp338pt001f01=919pf7331=11.html

get_parlament_election_2019_by_vd_major <- purrr::safely(function(x) {
  Sys.sleep(0.2)
  (read_html(paste0("https://www.cvk.gov.ua/pls/vnd2019/wp338pt001f01=919pf7331=", x, ".html")) %>% 
      html_table())[[2]] %>% as_tibble() %>% mutate(`№ ВД` = as.numeric(`№ ВД`)) %>% 
    tidyr::gather("Показник", "Кількість", -`№ ВД`) %>% mutate(
      Округ = x
    )
})

parlament_election_2019_by_vd_major <- purrr::map_dfr(11:223, function(x) {
  cat(x, "\n")
  get_parlament_election_2019_by_vd_major(x)$result
})

fst::write_fst(parlament_election_2019_by_vd_major, "data/parlament_election_2019_by_vd_major.fst")

get_parlament_election_2019_major_info <- purrr::safely(function(x) {
  Sys.sleep(0.2)
  (read_html(paste0("https://www.cvk.gov.ua/pls/vnd2019/wp033pt001f01=919pf7331=", x, ".html")) %>% 
    html_table())[[2]] %>% as_tibble() %>% mutate(
      Округ = x
    )
})

parlament_election_2019_major_info <- purrr::map_dfr(11:223, function(x) {
  cat(x, "\n")
  get_parlament_election_2019_major_info(x)$result
})

parlament_election_2019_by_vd_major %>% 
  left_join(
    parlament_election_2019_major_info %>% 
      mutate(
        `Прізвище, ім’я, по батькові кандидата в депутати` = 
          stringr::str_replace_all(`Прізвище, ім’я, по батькові кандидата в депутати`, " ", "")
             ), 
    by = c("Показник" = "Прізвище, ім’я, по батькові кандидата в депутати", "Округ")
  ) %>% 
  group_by(Округ, `№ ВД`) %>% 
  mutate(
    Кількість = as.numeric(Кількість) / as.numeric(Кількість)[Показник == "14) Сумарна к-сть голосів виборців ЗА"]
  )
  group_by(Висування) %>% 
  summarise(
    n = n()
  )


get_president_election_2019_2_by_vd <- purrr::safely(function(x) {
  Sys.sleep(0.1)
  (read_html(paste0("https://www.cvk.gov.ua/pls/vp2019/wp336pt001f01=720pt005f01=", x, ".html")) %>% 
     html_table())[[1]] %>% as_tibble() %>% mutate(`№ ВД` = as.numeric(`№ ВД`))
})

president_election_2019_2_by_vd  <- purrr::map_dfr(11:223, function(x) get_president_election_2019_2_by_vd(x)$result)

fst::write_fst(president_election_2019_2_by_vd, "data/president_election_2019_2_by_vd.fst")

get_president_election_2019_1_by_vd <- purrr::safely(function(x) {
  Sys.sleep(0.2)
  (read_html(paste0("https://www.cvk.gov.ua/pls/vp2019/wp336pt001f01=719pt005f01=", x, ".html")) %>% 
     html_table())[[1]] %>% as_tibble() %>% mutate(`№ ВД` = as.numeric(`№ ВД`))
})

president_election_2019_1_by_vd <- purrr::map_dfr(11:223, function(x) get_president_election_2019_1_by_vd(x)$result)

fst::write_fst(president_election_2019_1_by_vd, "data/president_election_2019_1_by_vd.fst")

#'
#' Дані про покриття 4g з сайті телеком операторів
#'

#https://www.vodafone.ua/4g/4g_38.kmz?5

vodafone <- maptools::getKMLcoordinates(textConnection(system("unzip -p data/4g_38.kmz", intern = TRUE)))

vodafone_4g <- purrr::map_dfr(vodafone, function(x) {
  x[,1:2] %>% as_tibble(.name_repair = "universal") %>% mutate(oreder = 1:nrow(x))
},.id = "group")

vodafone_4g = SpatialPolygons(list(Polygons(purrr::map(vodafone, ~Polygon(.[,1:2], hole = F)),1)))

#https://lifecell.ua/uploads/coverage_maps/lte_w29_11.kmz

lifecell <- system("unzip -p data/lte_w29_11.kmz", intern = TRUE) %>% 
  textConnection() %>% 
  maptools::getKMLcoordinates()

lifecell_4g <- purrr::map_dfr(lifecell, function(x) {
  x[,1:2] %>% as_tibble(.name_repair = "universal") %>% mutate(oreder = 1:nrow(x))
},.id = "group")

lifecell_4g = SpatialPolygons(list(Polygons(purrr::map(lifecell, ~Polygon(.[,1:2], hole = F)),1)))

#https://www.mobua.net/kmzmaps/kyivstar-4g.kmz

kyivstar <- system("unzip -p data/kyivstar-4g.kmz", intern = TRUE) %>% 
  textConnection() %>% 
  maptools::getKMLcoordinates()

kyivstar_4g <- purrr::map_dfr(kyivstar, function(x) {
  x[,1:2] %>% as_tibble(.name_repair = "universal") %>% mutate(oreder = 1:nrow(x))
},.id = "group")

kyivstar_4g = SpatialPolygons(list(Polygons(purrr::map(kyivstar, ~Polygon(.[,1:2], hole = F)),1)))

pols <- function(x) {
  ii <- rgeos::gBuffer(rgeos::gSimplify(SpatialPolygons(
    list(
      Polygons(
        list(
          Polygon(
            x[,2:3])), 1))), tol = 0.001), byid=TRUE, width=0)
  if(is.null(ii)) {
    return(NULL)
  } else {
    return(sf::st_as_sf(ii))
  }}

pols <- purrr::safely(pols)

p <- purrr::map(split(poly_dil[!is.na(poly_dil$V1),], poly_dil$group[!is.na(poly_dil$V1)]), ~pols(.)$result)

kyivstar_4g_sf <- sf::st_as_sf(rgeos::gBuffer(rgeos::gSimplify(kyivstar_4g, tol = 0.00001), byid=TRUE, width=0)) 
vodafone_4g_sf <- sf::st_as_sf(rgeos::gBuffer(rgeos::gSimplify(vodafone_4g, tol = 0.00001), byid=TRUE, width=0)) 
lifecell_4g_sf <- sf::st_as_sf(rgeos::gBuffer(rgeos::gSimplify(lifecell_4g, tol = 0.00001), byid=TRUE, width=0)) 

f <- purrr::safely(function(.) sf::st_intersection(kyivstar_4g_sf, .))
f2 <- purrr::safely(function(.) sf::st_intersection(vodafone_4g_sf, .))
f3 <- purrr::safely(function(.) sf::st_intersection(lifecell_4g_sf, .))

re <- purrr::map_dbl(1:length(p), function(x) {
  if(x %% 1000 == 0) {
    cat(x, "\n")
  }
  if(is.null(p[[x]])){
    return(0)
  } else {
    g <- f(p[[x]])$result
    g2 <- f2(p[[x]])$result
    g3 <- f3(p[[x]])$result
    m <- sf::st_area(p[[x]])
    return(ifelse(is.null(g) | nrow(g) == 0, 0, sf::st_area(g)/m) +
      ifelse(is.null(g2) | nrow(g2) == 0, 0, sf::st_area(g2)/m) +
      ifelse(is.null(g3) | nrow(g3) == 0, 0, sf::st_area(g3)/m))
  }
})

re <- ifelse(is.na(re), 0, re)

internet <- tibble(
  group = names(p),
  has_net = round(unname(re),1)
) %>% left_join(tibble(
  dil = coord_dil$PEC, 
  group = as.character(1:nrow(coord_dil))
), by = "group") %>%  parlament_election_2019_by_vd %>% 
  left_join(internet, by = c("№ ВД" = "dil"))

fst::write_fst(internet, "data/4g_internet_by_vd.fst")

ovk <- sf::read_sf("data/ovk/OVK.shp")

