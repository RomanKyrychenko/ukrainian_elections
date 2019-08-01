#'
#' Аналіз перетоків голосів з першого туру президентських виборів у другому турі 
#' президентських виборів та на парламентських виборах
#'
#' Основна ідея аналізу
#' 
#' Аналіз було зроблено за допомогою методу додатніх найменших квадратів. Цей метод побудови
#' лінійної регресії відрізняється від звичайнойного способу (звичайні найменші квадрати) тим,
#' що всі коефіцієти, на які множаться предиктори є більше 0 або дорівнюють йому. Таким чином,
#' залежна ознака в цьому випадку є просто сумою предикторів, які зважені на коефіцієти.
#' 
#' У випадку аналізу перетоків голосів, коефіцієнти по суті означають відсоток перетоку голосів.
#' 
#' Для більшої точності розрахунок рівнянь регресії робився на відсотках підтримки кандидатів і 
#' партій на кожній дільниці (це допомогло зважити явку), ці відсотки потім уже переводилися назад 
#' в абсолютні значення, які далі агрегувалися. Та частина інформації, яка не пояснювалася
#' предикторами тракутвалася як голоси тих виборців, які до цього не голосували. Для більшої
#' точності робилися окремі моделі для кодного округу, аби враховувати ще і їх специфіку.
#' 
#' Побудова рівнянь регресії методом не негативних найменших квадратів робилася за допомогою
#' пакету nnls. 
#' Візуалізація перетоків робилася через пакет ggalluvial.
#'
#' ® Roman Kyrychenko


suppressPackageStartupMessages({
  require(dplyr)
  require(ggplot2)
  require(hrbrthemes)
  require(ggalluvial)
})

setwd("~/ukrainian_elections/")

coord_dil <- readr::read_csv("data/cordynaty_VD.csv", col_types = readr::cols())
parlament_election_2019_by_vd <- fst::read_fst("data/parlament_election_2019_by_vd.fst")
president_election_2019_1_by_vd <- fst::read_fst("data/president_election_2019_1_by_vd.fst")
president_election_2019_2_by_vd <- fst::read_fst("data/president_election_2019_2_by_vd.fst")

pre_par <- parlament_election_2019_by_vd %>%
  filter(`№ ВД` > 16) %>%
  select(
    `№ ВД`,
    `3) К-сть виборців, внесених до списку`,
    `13) К-сть бюлетенів, визнаних недійсними`,
    `14) Сумарна к-сть голосів виборців ЗА`,
    `Політична партія "ОПОЗИЦІЙНИЙ БЛОК"`:`Політична партія "Рух Нових Сил Михайла Саакашвілі"`
  ) %>%
  mutate(
    `Інші партії` = `Політична Партія "ПАТРІОТ"` + `Політична партія "Сила Людей"` +
      `ПОЛІТИЧНА ПАРТІЯ "ПАРТІЯ ЗЕЛЕНИХ УКРАЇНИ"` + `ПОЛІТИЧНА ПАРТІЯ "ВСЕУКРАЇНСЬКЕ ОБ’ЄДНАННЯ "ФАКЕЛ"` +
      `Політична партія "Об’єднання "САМОПОМІЧ"` + `політична партія "Громадянська позиція"` +
      `ПОЛІТИЧНА ПАРТІЯ "СОЦІАЛЬНА СПРАВЕДЛИВІСТЬ"` + `ПОЛІТИЧНА ПАРТІЯ "СИЛА ПРАВА"` +
      `ПОЛІТИЧНА ПАРТІЯ "НЕЗАЛЕЖНІСТЬ"` + `Аграрна партія України` + `Політична партія "Рух Нових Сил Михайла Саакашвілі"`,
    `Кількість виборців, які проголосували на парламентських виборах` = `14) Сумарна к-сть голосів виборців ЗА`
  ) %>%
  rename(
    Опоблок = `Політична партія "ОПОЗИЦІЙНИЙ БЛОК"`,
    `Сила і Честь` = `ПОЛІТИЧНА ПАРТІЯ "СИЛА І ЧЕСТЬ"`,
    Батьківщина = `політична партія Всеукраїнське об’єднання "Батьківщина"`,
    `ОП За Життя` = `Політична партія "ОПОЗИЦІЙНА ПЛАТФОРМА – ЗА ЖИТТЯ"`,
    `Європейська солідарність` = `Політична партія "Європейська Солідарність"`,
    `Українська стратегія Гройсмана` = `ПОЛІТИЧНА ПАРТІЯ "УКРАЇНСЬКА СТРАТЕГІЯ ГРОЙСМАНА"`,
    `Слуга народу` = `ПОЛІТИЧНА ПАРТІЯ "СЛУГА НАРОДУ"`,
    `Радикальна партія Ляшка` = `ПОЛІТИЧНА ПАРТІЯ "РАДИКАЛЬНА ПАРТІЯ ОЛЕГА ЛЯШКА"`,
    `Партія Шарія` = `ПОЛІТИЧНА ПАРТІЯ "ПАРТІЯ ШАРІЯ"`,
    Голос = `Політична Партія "ГОЛОС"`,
    Свобода = `політична партія Всеукраїнське об’єднання "Свобода"`
  ) %>%
  select(
    `№ ВД`, 
    `Кількість виборців, які проголосували на парламентських виборах`,
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
    `Інші партії`
  ) %>%
  left_join(
    president_election_2019_1_by_vd %>%
      filter(`№ ВД` > 16) %>%
      select(
        `№ ВД`, `10.К-сть бюлетенів, визнаних недійсними`,
        `9.К-сть виборців, які взяли участь у голосуванні`,
        БалашовГеннадій:ШевченкоОлександр
      ) %>%
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
        `Тимошенко Юлія` = ТимошенкоЮлія,
        `Кількість виборців, які проголосували в першому турі президентських виборів` = `9.К-сть виборців, які взяли участь у голосуванні`
      ) %>%
      select(
        `№ ВД`, 
        `Зіпсовані президентські 1 тур`,
        `Кількість виборців, які проголосували в першому турі президентських виборів`,
        `Бойко Юрій`,
        `Вілкул Олександр`,
        `Гриценко Анатолій`,
        `Зеленський Володимир`,
        `Кошулинський Руслан`,
        `Ляшко Олег`,
        `Порошенко Петро`,
        `Смешко Ігор`,
        `Тимошенко Юлія`, 
        `Інші кандидати`
      ),
    by = "№ ВД"
  ) %>%
  left_join(
    president_election_2019_2_by_vd %>%
      filter(`№ ВД` > 26) %>%
      select(
        `№ ВД`, `2.К-сть виборців, внесених до списку`,
        `9.К-сть виборців, які взяли участь у голосуванні`,
        `10.К-сть бюлетенів, визнаних недійсними`,
        ЗеленськийВолодимир, ПорошенкоПетро
      ) %>%
      mutate(
        `Зіпсовані президентські 2 тур` = `10.К-сть бюлетенів, визнаних недійсними`
      ) %>% rename(
        `Кількість виборців, які проголосували в другому турі президентських виборів` = `9.К-сть виборців, які взяли участь у голосуванні`
      ) %>%
      select(
        `№ ВД`, 
        `Зіпсовані президентські 2 тур`,
        `Кількість виборців, які проголосували в другому турі президентських виборів`,
        ЗеленськийВолодимир, ПорошенкоПетро
      ),
    by = "№ ВД"
  ) %>%
  left_join(coord_dil %>% select(PEC, okrug) %>% rename(
    `Номер округу` = okrug
  ), by = c("№ ВД" = "PEC")) %>%
  filter(!is.na(`Номер округу`)) %>%
  mutate_all(~ ifelse(is.na(.), 0, .))

first_round_matrix <- pre_par %>%
  select(`Бойко Юрій`:`Інші кандидати`, `Зіпсовані президентські 1 тур`, `Кількість виборців, які проголосували в першому турі президентських виборів`) %>%
  mutate_all(~./`Кількість виборців, які проголосували в першому турі президентських виборів`) %>%
  select(-`Кількість виборців, які проголосували в першому турі президентських виборів`) %>% 
  as.matrix()

get_flow_from_first_round_to_parlament <- function(to) {
  purrr::map_dfr(unique(pre_par$`Номер округу`), function(x) {
    y <- pre_par[[to]][pre_par$`Номер округу` == x] / pre_par$`Кількість виборців, які проголосували на парламентських виборах`[pre_par$`Номер округу` == x]
    y <- ifelse(is.na(y), 0, y)
    fit <- nnls::nnls(first_round_matrix[pre_par$`Номер округу` == x, ], y)
    tibble(
      to = to,
      `Номер округу` = x,
      from = colnames(first_round_matrix),
      coef = ifelse(fit$x > 1, 1, fit$x),
      golos = unname(colSums(first_round_matrix[pre_par$`Номер округу` == x, ] * pre_par$`Кількість виборців, які проголосували в першому турі президентських виборів`[pre_par$`Номер округу` == x])),
      to_pa = round(unname(colSums(first_round_matrix[pre_par$`Номер округу` == x, ] %*% diag(coef) * pre_par$`Кількість виборців, які проголосували на парламентських виборах`[pre_par$`Номер округу` == x])))
    )
  })
}

flow_from_first_round_to_parlament <- purrr::map_dfr(pre_par %>%
  select(Опоблок:`Інші партії`) %>%
  colnames(), get_flow_from_first_round_to_parlament)

get_flow_from_first_round_to_second_round <- function(to) {
  purrr::map_dfr(unique(pre_par$`Номер округу`), function(x) {
    y <- pre_par[[to]][pre_par$`Номер округу` == x] / pre_par$`Кількість виборців, які проголосували в другому турі президентських виборів`[pre_par$`Номер округу` == x]
    y <- ifelse(is.na(y), 0, y)
    fit <- nnls::nnls(first_round_matrix[pre_par$`Номер округу` == x, ], y)
    tibble(
      to = to,
      `Номер округу` = x,
      from = colnames(first_round_matrix),
      coef = ifelse(fit$x > 1, 1, fit$x),
      golos = unname(colSums(first_round_matrix[pre_par$`Номер округу` == x, ] * pre_par$`Кількість виборців, які проголосували в першому турі президентських виборів`[pre_par$`Номер округу` == x])),
      to_pa = round(unname(colSums(first_round_matrix[pre_par$`Номер округу` == x, ] %*% diag(coef) * pre_par$`Кількість виборців, які проголосували в другому турі президентських виборів`[pre_par$`Номер округу` == x])))
    )
  })
}

flow_from_first_round_to_second_round  <- purrr::map_dfr(pre_par %>%
  select(ЗеленськийВолодимир:ПорошенкоПетро, `Зіпсовані президентські 2 тур`) %>%
  colnames(), get_flow_from_first_round_to_second_round)

second_round_matrix <- pre_par %>%
  select(ЗеленськийВолодимир:ПорошенкоПетро, `Зіпсовані президентські 2 тур`, `Кількість виборців, які проголосували в другому турі президентських виборів`) %>%
  mutate_all(~./`Кількість виборців, які проголосували в другому турі президентських виборів`) %>% 
  mutate_all(~ifelse(is.na(.), 0, .)) %>% 
  select(-`Кількість виборців, які проголосували в другому турі президентських виборів`) %>% 
  as.matrix()

get_flow_from_second_round_to_parlament <- function(to) {
  purrr::map_dfr(unique(pre_par$`Номер округу`), function(x) {
    y <- pre_par[[to]][pre_par$`Номер округу` == x] / pre_par$`Кількість виборців, які проголосували на парламентських виборах`[pre_par$`Номер округу` == x]
    y <- ifelse(is.na(y), 0, y)
    fit <- nnls::nnls(second_round_matrix[pre_par$`Номер округу` == x, ], y)
    tibble(
      to = to,
      `Номер округу` = x,
      from = colnames(second_round_matrix),
      coef = ifelse(fit$x > 1, 1, fit$x),
      golos = unname(colSums(second_round_matrix[pre_par$`Номер округу` == x, ] * pre_par$`Кількість виборців, які проголосували в другому турі президентських виборів`[pre_par$`Номер округу` == x])),
      to_pa = round(unname(colSums(second_round_matrix[pre_par$`Номер округу` == x, ] %*% diag(coef) * pre_par$`Кількість виборців, які проголосували на парламентських виборах`[pre_par$`Номер округу` == x])))
    )
  })
}

flow_from_second_round_to_parlament <- purrr::map_dfr(pre_par %>%
  select(Опоблок:`Інші партії`) %>%
  colnames(), get_flow_from_second_round_to_parlament)

flow_from_second_round_to_parlament %>%
  bind_rows(
    flow_from_second_round_to_parlament %>%
      group_by(from) %>%
      summarise(to_pa = sum(to_pa, na.rm = T)) %>%
      left_join(
        pre_par %>%
          select(ЗеленськийВолодимир:ПорошенкоПетро, `Зіпсовані президентські 2 тур`) %>%
          summarise_all(sum, na.rm = T) %>% t() %>% as_tibble(rownames = "from"),
        by = "from"
      ) %>% mutate(
        to_pa = V1 - to_pa,
        to_pa = ifelse(to_pa < 0, 0, to_pa)
      ) %>% mutate(
        to = "Не голосував",
        `Номер округу` = 0,
        coef = 0,
        golos = 0
      ) %>% select(to, `Номер округу`, from, coef, golos, to_pa)
  ) %>%
  bind_rows(
    flow_from_second_round_to_parlament %>%
      group_by(to) %>%
      summarise(to_pa = sum(to_pa, na.rm = T)) %>%
      left_join(
        pre_par %>%
          select(Опоблок:`Інші партії`) %>%
          summarise_all(sum, na.rm = T) %>% t() %>% as_tibble(rownames = "to"),
        by = "to"
      ) %>% mutate(
        to_pa = V1 - to_pa,
        to_pa = ifelse(to_pa < 0, 0, to_pa)
      ) %>% mutate(
        from = "Не голосував",
        `Номер округу` = 0,
        coef = 0,
        golos = 0
      ) %>% select(to, `Номер округу`, from, coef, golos, to_pa)
  ) %>%
  left_join(
    pre_par %>%
      select(Опоблок:`Інші партії`) %>%
      tidyr::gather("to", "per2") %>%
      group_by(to) %>% summarise(per2 = sum(per2)) %>% ungroup() %>%
      mutate(all = sum(per2), per2 = round(per2 / all, 3) * 100) %>% select(to, per2),
    by = "to"
  ) %>%
  mutate(
    all = sum(golos, na.rm = T) / 2, all_2 = sum(to_pa, na.rm = T) - (flow_from_second_round_to_parlament %>%
      group_by(from) %>%
      summarise(to_pa = sum(to_pa, na.rm = T)) %>%
      left_join(
        pre_par %>%
          select(ЗеленськийВолодимир:ПорошенкоПетро, `Зіпсовані президентські 2 тур`) %>%
          summarise_all(sum, na.rm = T) %>% t() %>% as_tibble(rownames = "from"),
        by = "from"
      ) %>% mutate(
        to_pa = V1 - to_pa,
        to_pa = ifelse(to_pa < 0, 0, to_pa)
      ) %>% pull(2) %>% sum()),
    from = ifelse(from == "Зіпсовані президентські 2 тур", "Зіпсовані бюлетені", from)
  ) %>%
  group_by(from) %>%
  mutate(per = round(sum(golos / all / 2, na.rm = T) * 100, 1)) %>%
  ungroup() %>%
  mutate(
    from = ifelse(from == "ЗеленськийВолодимир", "Зеленський Володимир", from),
    from = ifelse(from == "ПорошенкоПетро", "Порошенко Петро", from),
    from = paste0(from, " (", per, "%)"),
    from = ifelse(stringr::str_detect(from, "Не голосував"), "Не голосував", from),
    to = paste0(to, " (", per2, "%)"),
    to = ifelse(stringr::str_detect(to, "Не голосував"), "Не голосував", to)
  ) %>%
  group_by(from, to) %>%
  summarise(to_pa = sum(to_pa, na.rm = T)) %>%
  ggplot(aes(y = to_pa, axis1 = from, axis2 = to)) +
  geom_alluvium(aes(fill = from), width = 1 / 12) +
  geom_stratum(width = 1 / 6, fill = "white", color = "black") +
  geom_text(stat = "stratum", label.strata = TRUE, family = "PT Sans", size = 3) +
  scale_fill_manual(values = c("#33a02c", "#1f78b4", "#b15928", "#e31a1c")) +
  scale_x_discrete(limits = c("Другий тур президентських виборів", "Парламентські вибори"), expand = c(.0, .0)) +
  labs(
    title = "Перетікання голосів з 2 туру президентських виборів на парламентських виборах",
    caption = "На основі даних ЦВК (без врахування спецдільниць)"
  ) +
  theme_ipsum(base_family = "PT Sans") +
  theme(
    legend.position = "none",
    panel.grid = element_blank(),
    axis.title = element_blank(),
    axis.text.y = element_blank()
  )

ggsave("plots/2toparl.png", dpi = 600, width = 15, height = 10)

flow_from_first_round_to_parlament %>%
  bind_rows(
    flow_from_first_round_to_parlament %>%
      group_by(from) %>%
      summarise(to_pa = sum(to_pa, na.rm = T)) %>%
      left_join(
        pre_par %>%
          select(`Бойко Юрій`:`Інші кандидати`, `Зіпсовані президентські 1 тур`) %>%
          summarise_all(sum) %>% t() %>% as_tibble(rownames = "from"),
        by = "from"
      ) %>% mutate(
        to_pa = V1 - to_pa,
        to_pa = ifelse(to_pa < 0, 0, to_pa)
      ) %>% mutate(
        to = "Не голосував",
        `Номер округу` = 0,
        coef = 0,
        golos = 0
      ) %>% select(to, `Номер округу`, from, coef, golos, to_pa)
  ) %>%
  bind_rows(
    flow_from_first_round_to_parlament %>%
      group_by(to) %>%
      summarise(to_pa = sum(to_pa, na.rm = T)) %>%
      left_join(
        pre_par %>%
          select(Опоблок:`Інші партії`) %>%
          summarise_all(sum, na.rm = T) %>% t() %>% as_tibble(rownames = "to"),
        by = "to"
      ) %>% mutate(
        to_pa = V1 - to_pa,
        to_pa = ifelse(to_pa < 0, 0, to_pa)
      ) %>% mutate(
        from = "Не голосував",
        `Номер округу` = 0,
        coef = 0,
        golos = 0
      ) %>% select(to, `Номер округу`, from, coef, golos, to_pa)
  ) %>%
  left_join(
    pre_par %>%
      select(Опоблок:`Інші партії`) %>%
      tidyr::gather("to", "per2") %>%
      group_by(to) %>% summarise(per2 = sum(per2)) %>% ungroup() %>%
      mutate(all = sum(per2), per2 = round(per2 / all, 3) * 100) %>% select(to, per2),
    by = "to"
  ) %>%
  mutate(
    all = sum(golos) / 2, all_2 = sum(to_pa, na.rm = T) - flow_from_first_round_to_parlament %>%
      group_by(from) %>%
      summarise(to_pa = sum(to_pa, na.rm = T)) %>%
      left_join(
        pre_par %>%
          select(`Бойко Юрій`:`Інші кандидати`, `Зіпсовані президентські 1 тур`) %>%
          summarise_all(sum) %>% t() %>% as_tibble(rownames = "from"),
        by = "from"
      ) %>% mutate(
        to_pa = V1 - to_pa,
        to_pa = ifelse(to_pa < 0, 0, to_pa)
      ) %>% pull(2) %>% sum(),
    from = ifelse(from == "Зіпсовані президентські 1 тур", "Зіпсовані бюлетені", from)
  ) %>%
  group_by(from) %>%
  mutate(per = round(sum(golos / all / 2) * 100, 1)) %>%
  ungroup() %>%
  mutate(
    from = paste0(from, " (", per, "%)"),
    from = ifelse(stringr::str_detect(from, "Не голосував"), "Не голосував", from),
    to = paste0(to, " (", per2, "%)"),
    to = ifelse(stringr::str_detect(to, "Не голосував"), "Не голосував", to)
  ) %>%
  group_by(from, to) %>%
  summarise(to_pa = sum(to_pa, na.rm = T)) %>%
  ungroup() %>%
  ggplot(aes(y = to_pa, axis1 = from, axis2 = to)) +
  geom_alluvium(aes(fill = from), width = 1 / 12) +
  geom_stratum(width = 1 / 6, fill = "white", color = "black") +
  geom_text(stat = "stratum", label.strata = TRUE, family = "PT Sans", size = 3) +
  scale_fill_manual(values = c(
    "#1f78b4", "#a6cee3", "#ff7f00", "#33a02c", "#b15928",
    "#ffff99", "#6a3d9a", "#cab2d6", "#fdbf6f", "#e31a1c",
    "#b2df8a", "#fb9a99"
  )) +
  scale_x_discrete(limits = c("Перший тур президентських виборів", "Парламентські вибори"), expand = c(.0, .0)) +
  labs(
    title = "Перетікання голосів з 1 туру президентських виборів на парламентських виборах",
    caption = "На основі даних ЦВК (без врахування спецдільниць)"
  ) +
  theme_ipsum(base_family = "PT Sans") +
  theme(
    legend.position = "none", panel.grid = element_blank(), axis.title = element_blank(),
    axis.text.y = element_blank()
  )

ggsave("plots/1toparl.png", dpi = 600, width = 15, height = 10)

flow_from_first_round_to_second_round  %>%
  bind_rows(
    flow_from_first_round_to_second_round  %>%
      group_by(from) %>%
      summarise(to_pa = sum(to_pa, na.rm = T)) %>%
      left_join(
        pre_par %>%
          select(`Бойко Юрій`:`Інші кандидати`, `Зіпсовані президентські 1 тур`) %>%
          rename(`Зіпсовані бюлетені` = `Зіпсовані президентські 1 тур`) %>%
          summarise_all(sum) %>% t() %>% as_tibble(rownames = "from"),
        by = "from"
      ) %>% mutate(
        to_pa = V1 - to_pa,
        to_pa = ifelse(to_pa < 0, 0, to_pa)
      ) %>% mutate(
        to = "Не голосував",
        `Номер округу` = 0,
        coef = 0,
        golos = 0
      ) %>% select(to, `Номер округу`, from, coef, golos, to_pa),
    flow_from_first_round_to_second_round %>%
      group_by(to) %>%
      summarise(to_pa = sum(to_pa, na.rm = T)) %>%
      left_join(
        pre_par %>%
          select(ЗеленськийВолодимир:ПорошенкоПетро, `Зіпсовані президентські 2 тур`) %>%
          rename(`Зіпсовані бюлетені` = `Зіпсовані президентські 2 тур`) %>%
          summarise_all(sum) %>% t() %>% as_tibble(rownames = "to"),
        by = "to"
      ) %>% mutate(
        to_pa = V1 - to_pa,
        to_pa = ifelse(to_pa < 0, 0, to_pa)
      ) %>% mutate(
        from = "Не голосував",
        `Номер округу` = 0,
        coef = 0,
        golos = 0
      ) %>% select(to, `Номер округу`, from, coef, golos, to_pa)
  ) %>%
  mutate(
    to = case_when(
      to == "ЗеленськийВолодимир" ~ "Зеленський Володимир",
      to == "ПорошенкоПетро" ~ "Порошенко Петро",
      to == "Зіпсовані президентські 2 тур" ~ "Зіпсовані бюлетені",
      to == "Не голосував" ~ "Не голосував"
    ),
    from = ifelse(from == "Зіпсовані президентські 1 тур", "Зіпсовані бюлетені", from)
  ) %>%
  left_join(
    pre_par %>%
      select(ЗеленськийВолодимир, ПорошенкоПетро, `Зіпсовані президентські 2 тур`) %>%
      tidyr::gather("to", "per2") %>%
      group_by(to) %>% summarise(per2 = sum(per2)) %>% ungroup() %>%
      mutate(all = sum(per2), per2 = round(per2 / all, 3) * 100, to = case_when(
        to == "ЗеленськийВолодимир" ~ "Зеленський Володимир",
        to == "ПорошенкоПетро" ~ "Порошенко Петро",
        to == "Зіпсовані президентські 2 тур" ~ "Зіпсовані бюлетені",
        to == "Не голосував" ~ "Не голосував"
      )) %>% select(to, per2),
    by = "to"
  ) %>%
  mutate(all = sum(golos) / 2, all_2 = sum(to_pa, na.rm = T) - (flow_from_first_round_to_second_round  %>%
    group_by(from) %>%
    summarise(to_pa = sum(to_pa, na.rm = T)) %>%
    left_join(
      pre_par %>%
        select(`Бойко Юрій`:`Інші кандидати`, `Зіпсовані президентські 1 тур`) %>%
        summarise_all(sum) %>% t() %>% as_tibble(rownames = "from"),
      by = "from"
    ) %>% mutate(
      to_pa = V1 - to_pa,
      to_pa = ifelse(to_pa < 0, 0, to_pa)
    ) %>% pull(2) %>% sum())) %>%
  group_by(from) %>%
  mutate(per = round(sum(golos / all / 2) * 100, 1)) %>%
  ungroup() %>%
  mutate(
    from = paste0(from, " (", per, "%)"),
    from = ifelse(stringr::str_detect(from, "Не голосував"), "Не голосував", from),
    to = paste0(to, " (", per2, "%)"),
    to = ifelse(stringr::str_detect(to, "Не голосував"), "Не голосував", to)
  ) %>%
  group_by(from, to) %>%
  summarise(to_pa = sum(to_pa, na.rm = T)) %>%
  ungroup() %>%
  ggplot(aes(y = to_pa, axis1 = from, axis2 = to)) +
  geom_alluvium(aes(fill = from), width = 1 / 12) +
  geom_stratum(width = 1 / 6, fill = "white", color = "black") +
  geom_text(stat = "stratum", label.strata = TRUE, family = "PT Sans", size = 3) +
  scale_fill_manual(values = c(
    "#1f78b4", "#a6cee3", "#ff7f00", "#33a02c", "#b15928",
    "#ffff99", "#6a3d9a", "#cab2d6", "#fdbf6f", "#e31a1c",
    "#b2df8a", "#fb9a99"
  )) +
  scale_x_discrete(limits = c("Перший тур", "Другий тур"), expand = c(.0, .0)) +
  labs(
    title = "Перетікання голосів з 1 туру президентських виборів у другому турі",
    caption = "На основі даних ЦВК (без врахування спецдільниць)"
  ) +
  theme_ipsum(base_family = "PT Sans") +
  theme(
    legend.position = "none", panel.grid = element_blank(), axis.title = element_blank(),
    axis.text.y = element_blank()
  )

ggsave("plots/1to2.png", dpi = 600, width = 15, height = 10)
