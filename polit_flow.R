require(dplyr)
require(ggplot2)
require(hrbrthemes)

setwd("~/ukrainian_elections/")

coord_dil <- readr::read_csv("data/cordynaty_VD.csv", col_types = readr::cols())
parlament_election_2019_by_vd <- fst::read_fst("data/parlament_election_2019_by_vd.fst")
president_election_2019_1_by_vd <- fst::read_fst("data/president_election_2019_1_by_vd.fst")
president_election_2019_2_by_vd <- fst::read_fst("data/president_election_2019_2_by_vd.fst")

pre_par <- parlament_election_2019_by_vd %>% 
  filter(`№ ВД` > 16) %>% 
  select(`№ ВД`, 
         `3) К-сть виборців, внесених до списку`,
         `13) К-сть бюлетенів, визнаних недійсними`, 
         `14) Сумарна к-сть голосів виборців ЗА`,
         `Політична партія "ОПОЗИЦІЙНИЙ БЛОК"`:`Політична партія "Рух Нових Сил Михайла Саакашвілі"`) %>% 
  mutate(
    `Інші партії` = `Політична Партія "ПАТРІОТ"` + `Політична партія "Сила Людей"` +
`ПОЛІТИЧНА ПАРТІЯ "ПАРТІЯ ЗЕЛЕНИХ УКРАЇНИ"` + `ПОЛІТИЧНА ПАРТІЯ "ВСЕУКРАЇНСЬКЕ ОБ’ЄДНАННЯ "ФАКЕЛ"` +
`Політична партія "Об’єднання "САМОПОМІЧ"` + `політична партія "Громадянська позиція"` +
`ПОЛІТИЧНА ПАРТІЯ "СОЦІАЛЬНА СПРАВЕДЛИВІСТЬ"` + `ПОЛІТИЧНА ПАРТІЯ "СИЛА ПРАВА"` +
  `ПОЛІТИЧНА ПАРТІЯ "НЕЗАЛЕЖНІСТЬ"` + `Аграрна партія України` + `Політична партія "Рух Нових Сил Михайла Саакашвілі"`,
    Проголосували = `14) Сумарна к-сть голосів виборців ЗА`
    ) %>% 
  rename(
    Опоблок = `Політична партія "ОПОЗИЦІЙНИЙ БЛОК"`,
    `Сила і Честь` = `ПОЛІТИЧНА ПАРТІЯ "СИЛА І ЧЕСТЬ"`,
    Батьківщина = `політична партія Всеукраїнське об’єднання "Батьківщина"`,
    `ОП За Життя` = `Політична партія "ОПОЗИЦІЙНА ПЛАТФОРМА – ЗА ЖИТТЯ"`,
    `Європейська солідарність` = `Політична партія "Європейська Солідарність"`,
    `Українська стратегія Гройсмана` = `ПОЛІТИЧНА ПАРТІЯ "УКРАЇНСЬКА СТРАТЕГІЯ ГРОЙСМАНА"`,
    `Слуга народу`= `ПОЛІТИЧНА ПАРТІЯ "СЛУГА НАРОДУ"`,                      
    `Радикальна партія Ляшка` = `ПОЛІТИЧНА ПАРТІЯ "РАДИКАЛЬНА ПАРТІЯ ОЛЕГА ЛЯШКА"`,  
    `Партія Шарія` = `ПОЛІТИЧНА ПАРТІЯ "ПАРТІЯ ШАРІЯ"`,
    Голос = `Політична Партія "ГОЛОС"`,  
    Свобода = `політична партія Всеукраїнське об’єднання "Свобода"`
  ) %>% 
  select(`№ ВД`, Проголосували, 
         Опоблок,
         `Сила і Честь`,
         Батьківщина,
         `ОП За Життя`,
         `Європейська солідарність`,
         `Українська стратегія Гройсмана`,
         `Слуга народу`,
         `Радикальна партія Ляшка`,
         `Партія Шарія`,
         Голос,
         Свобода,
         `Інші партії`) %>% 
  left_join(
    president_election_2019_1_by_vd %>% 
      filter(`№ ВД` > 16) %>% 
      select(`№ ВД`,  `10.К-сть бюлетенів, визнаних недійсними`,
             `9.К-сть виборців, які взяли участь у голосуванні`,
             БалашовГеннадій:ШевченкоОлександр) %>% 
      mutate(
        `Зіпсовані президентські 1 тур` = `10.К-сть бюлетенів, визнаних недійсними`,
        `Інші кандидати` = БалашовГеннадій + БезсмертнийРоман + БогомолецьОльга + 
          БогословськаІнна + БондарВіктор + ВащенкоОлександр + ГаберМикола + ДанилюкОлександр +
          `Дерев’янкоЮрій` + ЖуравльовВасиль + КаплінСергій + КармазінЮрій + КиваІлля + 
          КорнацькийАркадій + КривенкоВіктор + КупрійВіталій + ЛитвиненкоЮлія + МорозОлександр +
          НаливайченкоВалентин + НасіровРоман + НовакАндрій + НосенкоСергій + ПетровВолодимир +
          РиговановРуслан + СкоцикВіталій + СоловйовОлександр + ТарутаСергій + 
          ТимошенкоЮрій + ШевченкоІгор + ШевченкоОлександр
        ) %>% 
      rename(
        `Бойко Юрій` = БойкоЮрій,
        `Вілкул Олександр` = ВілкулОлександр,
        `Гриценко Анатолій` = ГриценкоАнатолій,
        `Зеленський Володимир` = ЗеленськийВолодимир,
        `Кошулинський Руслан` = КошулинськийРуслан,
        `Ляшко Олег` = ЛяшкоОлег,
        `Порошенко Петро` = ПорошенкоПетро,
        `Смешко Ігор` = СмешкоІгор,
        `Тимошенко Юлія` = ТимошенкоЮлія
      ) %>% 
      select(`№ ВД`, `Зіпсовані президентські 1 тур`,
             `9.К-сть виборців, які взяли участь у голосуванні`, 
             `Бойко Юрій`,
             `Вілкул Олександр`,
             `Гриценко Анатолій`,
             `Зеленський Володимир`,
             `Кошулинський Руслан`,
             `Ляшко Олег`,
             `Порошенко Петро`,
             `Смешко Ігор`,
             `Тимошенко Юлія`, `Інші кандидати`), by = "№ ВД") %>% 
  left_join(
    president_election_2019_2_by_vd %>% 
      filter(`№ ВД` > 26) %>% 
      select(`№ ВД`, `2.К-сть виборців, внесених до списку`,
             `9.К-сть виборців, які взяли участь у голосуванні`,
             `10.К-сть бюлетенів, визнаних недійсними`,
             ЗеленськийВолодимир, ПорошенкоПетро) %>% 
      mutate(
        `Явка президентські 2 тур` = `9.К-сть виборців, які взяли участь у голосуванні` / `2.К-сть виборців, внесених до списку`,
        `Зіпсовані президентські 2 тур` = `10.К-сть бюлетенів, визнаних недійсними`
      ) %>% 
      select(`№ ВД`, `Явка президентські 2 тур`, `Зіпсовані президентські 2 тур`,
             `9.К-сть виборців, які взяли участь у голосуванні`, 
             ЗеленськийВолодимир, ПорошенкоПетро), by = "№ ВД") %>% 
  left_join(coord_dil %>% select(PEC, okrug), by = c("№ ВД" = "PEC")) %>% 
  filter(!is.na(okrug)) %>% 
  mutate_all(~ifelse(is.na(.), 0, .))
  
e <- pre_par %>% select(`Бойко Юрій`:`Інші кандидати`, `Зіпсовані президентські 1 тур`) %>% as.matrix()
#e[is.na(e)] <- 0
e <- e/pre_par$`9.К-сть виборців, які взяли участь у голосуванні.x`
#e[is.infinite(e)] <- 0
#e[is.nan(e)] <- 0
#pre_par$ПорошенкоПетро.y <- ifelse(is.na(pre_par$ПорошенкоПетро.y), 0, pre_par$ПорошенкоПетро.y)
#pre_par$ЗеленськийВолодимир.y <- ifelse(is.na(pre_par$ЗеленськийВолодимир.y), 0, pre_par$ЗеленськийВолодимир.y)

flow <- function(party) {
  purrr::map_dfr(unique(pre_par$okrug), function(x) {
    y <- pre_par[[party]][pre_par$okrug == x]/pre_par$Проголосували[pre_par$okrug == x]
    y <- ifelse(is.na(y), 0, y)
    fit <- nnls::nnls(e[pre_par$okrug == x,], y)
    tibble(
      party = party,
      okrug = x,
      name = colnames(e),
      coef = ifelse(fit$x > 1, 1, fit$x),
      golos = unname(colSums(e[pre_par$okrug == x,]*pre_par$`9.К-сть виборців, які взяли участь у голосуванні.x`[pre_par$okrug == x])),
      to_pa = round(unname(colSums(e[pre_par$okrug == x,]%*%diag(coef)*pre_par$Проголосували[pre_par$okrug == x])))
    )
  })
}

parties <- purrr::map_dfr(pre_par %>% 
  select(Опоблок:`Інші партії`) %>% 
  colnames(), flow)

parties %>% group_by(party, name) %>% summarise(to_pa = sum(to_pa))

flow2 <- function(party) {
  purrr::map_dfr(unique(pre_par$okrug), function(x) {
    y <- pre_par[[party]][pre_par$okrug == x]/pre_par$`9.К-сть виборців, які взяли участь у голосуванні.y`[pre_par$okrug == x]
    y <- ifelse(is.na(y), 0, y)
    fit <- nnls::nnls(e[pre_par$okrug == x,], y)
    tibble(
      party = party,
      okrug = x,
      name = colnames(e),
      coef = ifelse(fit$x > 1, 1, fit$x),
      golos = unname(colSums(e[pre_par$okrug == x,]*pre_par$`9.К-сть виборців, які взяли участь у голосуванні.x`[pre_par$okrug == x])),
      to_pa = round(unname(colSums(e[pre_par$okrug == x,]%*%diag(coef)*pre_par$`9.К-сть виборців, які взяли участь у голосуванні.y`[pre_par$okrug == x])))
    )
  })
}

second_tur <- purrr::map_dfr(pre_par %>% 
                            select(ЗеленськийВолодимир:ПорошенкоПетро, `Зіпсовані президентські 2 тур`) %>% 
                            colnames(), flow2)

second_tur %>% group_by(party, name) %>% summarise(to_pa = sum(to_pa, na.rm = T)) 

e2 <- pre_par %>% select(ЗеленськийВолодимир:ПорошенкоПетро, `Зіпсовані президентські 2 тур`) %>% as.matrix()
e2 <- e2/pre_par$`9.К-сть виборців, які взяли участь у голосуванні.y`
e2[is.na(e2)] <- 0
#e2[is.infinite(e2)] <- 0
#e2[is.nan(e2)] <- 0

flow3 <- function(party) {
  purrr::map_dfr(unique(pre_par$okrug), function(x) {
    y <- pre_par[[party]][pre_par$okrug == x]/pre_par$Проголосували[pre_par$okrug == x]
    y <- ifelse(is.na(y), 0, y)
    fit <- nnls::nnls(e2[pre_par$okrug == x,], y)
    tibble(
      party = party,
      okrug = x,
      name = colnames(e2),
      coef = ifelse(fit$x > 1, 1, fit$x),
      golos = unname(colSums(e2[pre_par$okrug == x,]*pre_par$`9.К-сть виборців, які взяли участь у голосуванні.y`[pre_par$okrug == x])),
      to_pa = round(unname(colSums(e2[pre_par$okrug == x,]%*%diag(coef)*pre_par$Проголосували[pre_par$okrug == x])))
    )
  })
}

parties2 <- purrr::map_dfr(pre_par %>% 
                            select(Опоблок:`Інші партії`) %>% 
                            colnames(), flow3)

parties2 %>% group_by(party, okrug) %>% summarise(to_pa = sum(to_pa)) %>% 
  left_join(pre_par %>% 
              select(okrug, Опоблок:`Інші партії`) %>% 
              tidyr::gather("party", "res", -okrug) %>% group_by(okrug, party) %>% 
              summarise(res = sum(res)), by = c("party", "okrug")) %>% 
  mutate(mape = abs(res-to_pa)) %>% pull(mape) %>% summary()



require(ggalluvial)

parties2 %>%
  bind_rows(
    parties2 %>% 
      group_by(name) %>% 
      summarise(to_pa = sum(to_pa,na.rm = T)) %>% 
      left_join(
        pre_par %>% 
          select(ЗеленськийВолодимир:ПорошенкоПетро, `Зіпсовані президентські 2 тур`) %>% 
          summarise_all(sum, na.rm=T) %>% t() %>% as_tibble(rownames = "name"), by = "name"
      ) %>% mutate(
        to_pa = V1 - to_pa,
        to_pa = ifelse(to_pa < 0, 0, to_pa)
      ) %>% mutate(
        party = "Не голосував",
        okrug = 0,
        coef = 0,
        golos = 0
      ) %>% select(party, okrug, name, coef, golos, to_pa)
  ) %>% 
  bind_rows(
    parties2 %>% 
      group_by(party) %>% 
      summarise(to_pa = sum(to_pa,na.rm = T)) %>% 
      left_join(
        pre_par %>% 
          select(Опоблок:`Інші партії`) %>% 
          summarise_all(sum, na.rm = T) %>% t() %>% as_tibble(rownames = "party"), by = "party"
      ) %>% mutate(
        to_pa = V1 - to_pa,
        to_pa = ifelse(to_pa < 0, 0, to_pa)
      ) %>% mutate(
        name = "Не голосував",
        okrug = 0,
        coef = 0,
        golos = 0
      ) %>% select(party, okrug, name, coef, golos, to_pa)
  ) %>% 
  left_join(
    pre_par %>% 
      select(Опоблок:`Інші партії`) %>% 
      tidyr::gather("party", "per2") %>% 
      group_by(party) %>% summarise(per2 = sum(per2)) %>% ungroup() %>% 
      mutate(all = sum(per2), per2 = round(per2/all,3)*100) %>% select(party, per2), by = "party"
  ) %>% 
  mutate(all = sum(golos, na.rm = T)/2, all_2 = sum(to_pa, na.rm = T)-(parties2 %>% 
                                                                         group_by(name) %>% 
                                                                         summarise(to_pa = sum(to_pa,na.rm = T)) %>% 
                                                                         left_join(
                                                                           pre_par %>% 
                                                                             select(ЗеленськийВолодимир:ПорошенкоПетро, `Зіпсовані президентські 2 тур`) %>% 
                                                                             summarise_all(sum, na.rm=T) %>% t() %>% as_tibble(rownames = "name"), by = "name"
                                                                         ) %>% mutate(
                                                                           to_pa = V1 - to_pa,
                                                                           to_pa = ifelse(to_pa < 0, 0, to_pa)
                                                                         ) %>% pull(2) %>% sum()),
         name = ifelse(name == "Зіпсовані президентські 2 тур", "Зіпсовані бюлетені", name)) %>% 
  group_by(name) %>% 
  mutate(per = round(sum(golos/all/2, na.rm = T)*100,1)) %>% 
  ungroup() %>%
  mutate(
    name = ifelse(name == "ЗеленськийВолодимир", "Зеленський Володимир", name),
    name = ifelse(name == "ПорошенкоПетро", "Порошенко Петро", name),
    name = paste0(name, " (", per, "%)"),
         name = ifelse(stringr::str_detect(name, "Не голосував"), "Не голосував", name),
         party = paste0(party, " (", per2, "%)"),
         party = ifelse(stringr::str_detect(party, "Не голосував"), "Не голосував", party)) %>% 
  group_by(name, party) %>% summarise(to_pa = sum(to_pa, na.rm = T)) %>% 
  ggplot(aes(y = to_pa, axis1 = name, axis2 = party)) +
  geom_alluvium(aes(fill = name), width = 1/12) +
  geom_stratum(width = 1/6, fill = "white", color = "black") +
  geom_text(stat = "stratum", label.strata = TRUE, family = "PT Sans", size = 3) +
  scale_fill_manual(values = c("#33a02c", "#1f78b4", "#b15928", "#e31a1c")) + 
  scale_x_discrete(limits = c("Другий тур президентських виборів", "Парламентські вибори"), expand = c(.0, .0)) +
  labs(
    title = "Перетікання голосів з 2 туру президентських виборів на парламентських виборах",
    caption = "На основі даних ЦВК (без врахування спецдільниць)"
  ) +
  theme_ipsum(base_family = "PT Sans") + 
  theme(legend.position = "none", 
        panel.grid = element_blank(), 
        axis.title = element_blank(), 
        axis.text.y = element_blank())

ggsave("plots/2toparl.png", dpi = 600, width = 15, height = 10)

parties %>% 
  bind_rows(
    parties %>% 
      group_by(name) %>% 
      summarise(to_pa = sum(to_pa,na.rm = T)) %>% 
      left_join(
        pre_par %>% 
          select(`Бойко Юрій`:`Інші кандидати`, `Зіпсовані президентські 1 тур`) %>% 
          summarise_all(sum) %>% t() %>% as_tibble(rownames = "name"), by = "name"
      ) %>% mutate(
        to_pa = V1 - to_pa,
        to_pa = ifelse(to_pa < 0, 0, to_pa)
      ) %>% mutate(
        party = "Не голосував",
        okrug = 0,
        coef = 0,
        golos = 0
      ) %>% select(party, okrug, name, coef, golos, to_pa)
  ) %>% 
  bind_rows(
    parties %>% 
      group_by(party) %>% 
      summarise(to_pa = sum(to_pa,na.rm = T)) %>% 
      left_join(
        pre_par %>% 
          select(Опоблок:`Інші партії`) %>% 
          summarise_all(sum, na.rm = T) %>% t() %>% as_tibble(rownames = "party"), by = "party"
      ) %>% mutate(
        to_pa = V1 - to_pa,
        to_pa = ifelse(to_pa < 0, 0, to_pa)
      ) %>% mutate(
        name = "Не голосував",
        okrug = 0,
        coef = 0,
        golos = 0
      ) %>% select(party, okrug, name, coef, golos, to_pa)
  ) %>% 
  left_join(
    pre_par %>% 
      select(Опоблок:`Інші партії`) %>% 
      tidyr::gather("party", "per2") %>% 
      group_by(party) %>% summarise(per2 = sum(per2)) %>% ungroup() %>% 
      mutate(all = sum(per2), per2 = round(per2/all,3)*100) %>% select(party, per2), by = "party"
  ) %>% 
  mutate(all = sum(golos)/2, all_2 = sum(to_pa, na.rm = T) - parties %>% 
           group_by(name) %>% 
           summarise(to_pa = sum(to_pa,na.rm = T)) %>% 
           left_join(
             pre_par %>% 
               select(`Бойко Юрій`:`Інші кандидати`, `Зіпсовані президентські 1 тур`) %>% 
               summarise_all(sum) %>% t() %>% as_tibble(rownames = "name"), by = "name"
           ) %>% mutate(
             to_pa = V1 - to_pa,
             to_pa = ifelse(to_pa < 0, 0, to_pa)
           ) %>% pull(2) %>% sum(),
         name = ifelse(name == "Зіпсовані президентські 1 тур", "Зіпсовані бюлетені", name)) %>% 
  group_by(name) %>% 
  mutate(per = round(sum(golos/all/2)*100,1)) %>% 
  ungroup() %>%
  mutate(name = paste0(name, " (", per, "%)"),
         name = ifelse(stringr::str_detect(name, "Не голосував"), "Не голосував", name),
         party = paste0(party, " (", per2, "%)"),
         party = ifelse(stringr::str_detect(party, "Не голосував"), "Не голосував", party)) %>% 
  group_by(name, party) %>% summarise(to_pa = sum(to_pa, na.rm = T)) %>% 
  ungroup() %>% 
  rename(
    `Перший тур` = name,
    `Другий тур` = party
  ) %>% 
  ggplot(aes(y = to_pa, axis1 = `Перший тур`, axis2 = `Другий тур`)) +
  geom_alluvium(aes(fill = `Перший тур`), width = 1/12) +
  geom_stratum(width = 1/6, fill = "white", color = "black") +
  geom_text(stat = "stratum", label.strata = TRUE, family = "PT Sans", size = 3) +
  scale_fill_manual(values = c("#1f78b4", "#a6cee3", "#ff7f00", "#33a02c", "#b15928",
                               "#ffff99", "#6a3d9a", "#cab2d6", "#fdbf6f", "#e31a1c",
                               "#b2df8a", "#fb9a99")) +
  scale_x_discrete(limits = c("Перший тур президентських виборів", "Парламентські вибори"), expand = c(.0, .0)) +
  labs(
    title = "Перетікання голосів з 1 туру президентських виборів на парламентських виборах",
    caption = "На основі даних ЦВК (без врахування спецдільниць)"
  ) +
  theme_ipsum(base_family = "PT Sans") + 
  theme(legend.position = "none", panel.grid = element_blank(), axis.title = element_blank(), 
        axis.text.y = element_blank())

ggsave("plots/1toparl.png", dpi = 600, width = 15, height = 10)

second_tur %>% 
  bind_rows(
    second_tur %>% 
      group_by(name) %>% 
      summarise(to_pa = sum(to_pa,na.rm = T)) %>% 
      left_join(
        pre_par %>% 
          select(`Бойко Юрій`:`Інші кандидати`, `Зіпсовані президентські 1 тур`) %>% 
          rename(`Зіпсовані бюлетені` = `Зіпсовані президентські 1 тур`) %>% 
          summarise_all(sum) %>% t() %>% as_tibble(rownames = "name"), by = "name"
      ) %>% mutate(
        to_pa = V1 - to_pa,
        to_pa = ifelse(to_pa < 0, 0, to_pa)
      ) %>% mutate(
        party = "Не голосував",
        okrug = 0,
        coef = 0,
        golos = 0
      ) %>% select(party, okrug, name, coef, golos, to_pa)
  ) %>% 
  mutate(
    party = case_when(
      party == "ЗеленськийВолодимир" ~ "Зеленський Володимир",
      party == "ПорошенкоПетро" ~ "Порошенко Петро",
      party == "Зіпсовані президентські 2 тур" ~ "Зіпсовані бюлетені",
      party == "Не голосував" ~ "Не голосував"
    ),
    name = ifelse(name == "Зіпсовані президентські 1 тур", "Зіпсовані бюлетені", name)) %>% 
  bind_rows(
    tibble(
      party = c("Зеленський Володимир", "Порошенко Петро", "Зіпсовані бюлетені"),
      okrug = c(0,0,0),
      name = c("Не голосував", "Не голосував", "Не голосував"),
      coef = c(0,0,0),
      golos = c(0,0,0),
      to_pa = c(770619, 370797, 28018)
    )
  ) %>% 
  left_join(
    pre_par %>% 
      select(ЗеленськийВолодимир, ПорошенкоПетро, `Зіпсовані президентські 2 тур`) %>% 
      tidyr::gather("party", "per2") %>% 
      group_by(party) %>% summarise(per2 = sum(per2)) %>% ungroup() %>% 
      mutate(all = sum(per2), per2 = round(per2/all,3)*100,  party = case_when(
        party == "ЗеленськийВолодимир" ~ "Зеленський Володимир",
        party == "ПорошенкоПетро" ~ "Порошенко Петро",
        party == "Зіпсовані президентські 2 тур" ~ "Зіпсовані бюлетені",
        party == "Не голосував" ~ "Не голосував"
      )) %>% select(party, per2), by = "party"
  ) %>% 
  mutate(all = sum(golos)/2, all_2 = sum(to_pa, na.rm = T)-(second_tur %>% 
                                                              group_by(name) %>% 
                                                              summarise(to_pa = sum(to_pa,na.rm = T)) %>% 
                                                              left_join(
                                                                pre_par %>% 
                                                                  select(`Бойко Юрій`:`Інші кандидати`, `Зіпсовані президентські 1 тур`) %>% 
                                                                  summarise_all(sum) %>% t() %>% as_tibble(rownames = "name"), by = "name"
                                                              ) %>% mutate(
                                                                to_pa = V1 - to_pa,
                                                                to_pa = ifelse(to_pa < 0, 0, to_pa)
                                                              ) %>% pull(2) %>% sum())) %>% 
  group_by(name) %>% 
  mutate(per = round(sum(golos/all/2)*100,1)) %>% 
  ungroup() %>%
  mutate(name = paste0(name, " (", per, "%)"),
         name = ifelse(stringr::str_detect(name, "Не голосував"), "Не голосував", name),
         party = paste0(party, " (", per2, "%)"),
         party = ifelse(stringr::str_detect(party, "Не голосував"), "Не голосував", party)) %>% 
  group_by(name, party) %>% summarise(to_pa = sum(to_pa, na.rm = T)) %>% 
  ungroup() %>% 
  rename(
    `Перший тур` = name,
    `Другий тур` = party
  ) %>% 
  ggplot(aes(y = to_pa, axis1 = `Перший тур`, axis2 = `Другий тур`)) +
  geom_alluvium(aes(fill = `Перший тур`), width = 1/12) +
  geom_stratum(width = 1/6, fill = "white", color = "black") +
  geom_text(stat = "stratum", label.strata = TRUE, family = "PT Sans", size = 3) +
  scale_fill_manual(values = c("#1f78b4", "#a6cee3", "#ff7f00", "#33a02c", "#b15928",
                               "#ffff99", "#6a3d9a", "#cab2d6", "#fdbf6f", "#e31a1c",
                               "#b2df8a", "#fb9a99")) +
  scale_x_discrete(limits = c("Перший тур", "Другий тур"), expand = c(.0, .0)) +
  labs(
    title = "Перетікання голосів з 1 туру президентських виборів у другому турі",
    caption = "На основі даних ЦВК (без врахування спецдільниць)"
  ) +
  theme_ipsum(base_family = "PT Sans") + 
  theme(legend.position = "none", panel.grid = element_blank(), axis.title = element_blank(), 
        axis.text.y = element_blank())

ggsave("plots/1to2.png", dpi = 600, width = 15, height = 10)

