Про вплив інтернет-технологій на виборах цього року не говорив тільки
лінивий експерт.

Діджитал-кампанія Володимира Зеленського, армія прихильників Петра
Порошенка у Фейсбуці, блоги Анатолія Шарія та Дмитра Гордона на Ютубі -
це все точно впливало на кампанії, що навіть старожили української
політики, на зразок Юлії Тимошенко, почали все активніше освоювати такі
майданчики як Ютуб та Інстаграм.

При цьому Україна ще точно не є на 100% інтернетизованою країною, хоч
частка користувачів мережі постійно зростає. Останні роки цьому сприяє
поява та розширення стандартів мобільного інтрнету 3G та 4G (LTE).
Останній стандарт зв’язку для нас особливо цікавий, адже саме він
дозволяє без проблем їдучи в маршрутці на роботу подивися свіжий блог
Шарія, чи смакуючи шаурмою біля зупинки - новий сторіс Володимира
Зеленського.

4G зв’язок в Україні
--------------------

4G покриття в Україні забезпечують 3 основні телеком оператори -
Київстар, Водафон та Лайфсел. На їх офіційних сайтах можна знайти
інформацію про покриття, що я і зробив. Поті ці дані було використано
для того, аби зв’ясувати, наскільки межі кожної дільниці в Україні є
покриті 4G-зв’язком. Технічні деталі можна знайти в
[репозиторії](https://github.com/RomanKyrychenko/ukrainian_elections).

На карті можна побачити, яка ситуація з покриттям на усіх дільницях.
![](4g_influence_files/figure-markdown_github/map-1.png)

В зоні хорошого покриття 4G живе майже половина проголосувавших на
виборах (близько 48% або майже 7 млн виборців). Там, де нема навіть
натяку на 4G живе близько 11% виборців (або майже 1.6 млн). Інші виборці
проживають у межах дільниць, де покриття тільки часткове і надається не
всіма операторами. Схоже, що вплив інтрнету на виборців уже має бути
дуже відчутним, так як ми при цьому не можемо врахувати вплив провідного
інтернету (відсутні настільки деталізовані дані).

Як би голосували
----------------

Отже, наявність 4G дійсно пов’язана з прихильністю до певних політичних
сил.

<!--html_preserve-->
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#gdjvvruier .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #000000;
  font-size: 16px;
  background-color: #FFFFFF;
  /* table.background.color */
  width: auto;
  /* table.width */
  border-top-style: solid;
  /* table.border.top.style */
  border-top-width: 2px;
  /* table.border.top.width */
  border-top-color: #A8A8A8;
  /* table.border.top.color */
}

#gdjvvruier .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#gdjvvruier .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 1px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#gdjvvruier .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 1px;
  padding-bottom: 4px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#gdjvvruier .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#gdjvvruier .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#gdjvvruier .gt_col_heading {
  color: #000000;
  background-color: #FFFFFF;
  /* column_labels.background.color */
  font-size: 16px;
  /* column_labels.font.size */
  font-weight: initial;
  /* column_labels.font.weight */
  vertical-align: middle;
  padding: 10px;
  margin: 10px;
}

#gdjvvruier .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#gdjvvruier .gt_group_heading {
  padding: 8px;
  color: #000000;
  background-color: #FFFFFF;
  /* row_group.background.color */
  font-size: 16px;
  /* row_group.font.size */
  font-weight: initial;
  /* row_group.font.weight */
  border-top-style: solid;
  /* row_group.border.top.style */
  border-top-width: 2px;
  /* row_group.border.top.width */
  border-top-color: #A8A8A8;
  /* row_group.border.top.color */
  border-bottom-style: solid;
  /* row_group.border.bottom.style */
  border-bottom-width: 2px;
  /* row_group.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* row_group.border.bottom.color */
  vertical-align: middle;
}

#gdjvvruier .gt_empty_group_heading {
  padding: 0.5px;
  color: #000000;
  background-color: #FFFFFF;
  /* row_group.background.color */
  font-size: 16px;
  /* row_group.font.size */
  font-weight: initial;
  /* row_group.font.weight */
  border-top-style: solid;
  /* row_group.border.top.style */
  border-top-width: 2px;
  /* row_group.border.top.width */
  border-top-color: #A8A8A8;
  /* row_group.border.top.color */
  border-bottom-style: solid;
  /* row_group.border.bottom.style */
  border-bottom-width: 2px;
  /* row_group.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* row_group.border.bottom.color */
  vertical-align: middle;
}

#gdjvvruier .gt_striped {
  background-color: #f2f2f2;
}

#gdjvvruier .gt_from_md > :first-child {
  margin-top: 0;
}

#gdjvvruier .gt_from_md > :last-child {
  margin-bottom: 0;
}

#gdjvvruier .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
}

#gdjvvruier .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#gdjvvruier .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#gdjvvruier .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#gdjvvruier .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#gdjvvruier .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#gdjvvruier .gt_table_body {
  border-top-style: solid;
  /* table_body.border.top.style */
  border-top-width: 2px;
  /* table_body.border.top.width */
  border-top-color: #A8A8A8;
  /* table_body.border.top.color */
  border-bottom-style: solid;
  /* table_body.border.bottom.style */
  border-bottom-width: 2px;
  /* table_body.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* table_body.border.bottom.color */
}

#gdjvvruier .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  padding: 4px;
  /* footnote.padding */
}

#gdjvvruier .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#gdjvvruier .gt_center {
  text-align: center;
}

#gdjvvruier .gt_left {
  text-align: left;
}

#gdjvvruier .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#gdjvvruier .gt_font_normal {
  font-weight: normal;
}

#gdjvvruier .gt_font_bold {
  font-weight: bold;
}

#gdjvvruier .gt_font_italic {
  font-style: italic;
}

#gdjvvruier .gt_super {
  font-size: 65%;
}

#gdjvvruier .gt_footnote_glyph {
  font-style: italic;
  font-size: 65%;
}
</style>
<!--gt table start-->
<table class="gt_table">
<thead>
<tr>
<th colspan="6" class="gt_heading gt_title gt_font_normal gt_center">
Як якість покриття 4G пов’язана з голосуванням на парламентських
виборах?
</th>
</tr>
<tr>
<th colspan="6" class="gt_heading gt_subtitle gt_font_normal gt_center gt_bottom_border">
Розподіли голосів виборців в залежності від покриття меж їх дільниці 4G
</th>
</tr>
</thead>
<tr>
<th class="gt_col_heading gt_left" rowspan="1" colspan="1">
Партія
</th>
<th class="gt_col_heading gt_right" rowspan="1" colspan="1">
Є повне покриття трьома операторами
</th>
<th class="gt_col_heading gt_right" rowspan="1" colspan="1">
Є повне покриття двома операторами
</th>
<th class="gt_col_heading gt_right" rowspan="1" colspan="1">
Є повне покриття одним оператором
</th>
<th class="gt_col_heading gt_right" rowspan="1" colspan="1">
Є часткове покриття одним оператором
</th>
<th class="gt_col_heading gt_right" rowspan="1" colspan="1">
Немає навіть часткового покриття
</th>
</tr>
<tbody class="gt_table_body">
<tr>
<td class="gt_row gt_left" style="background-color:white;">
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/%D0%97%D0%B5%21_%D0%BF%D0%B0%D1%80%D1%82%D1%96%D1%8F_%C2%AB%D0%A1%D0%BB%D1%83%D0%B3%D0%B0_%D0%9D%D0%B0%D1%80%D0%BE%D0%B4%D1%83%C2%BB.svg/1200px-%D0%97%D0%B5%21_%D0%BF%D0%B0%D1%80%D1%82%D1%96%D1%8F_%C2%AB%D0%A1%D0%BB%D1%83%D0%B3%D0%B0_%D0%9D%D0%B0%D1%80%D0%BE%D0%B4%D1%83%C2%BB.svg.png" style="height:30px;">
</td>
<td class="gt_row gt_right" style="background-color:#95353B;color:#FFFFFFFF;">
42.77%
</td>
<td class="gt_row gt_right" style="background-color:#8F2A35;color:#FFFFFFFF;">
44.79%
</td>
<td class="gt_row gt_right" style="background-color:#922F37;color:#FFFFFFFF;">
43.95%
</td>
<td class="gt_row gt_right" style="background-color:#933139;color:#FFFFFFFF;">
43.44%
</td>
<td class="gt_row gt_right" style="background-color:#993B3E;color:#FFFFFFFF;">
41.55%
</td>
</tr>
<tr>
<td class="gt_row gt_left gt_striped" style="background-color:white;">
<img src="https://upload.wikimedia.org/wikipedia/commons/5/5a/Logo_of_%22Opposition_Platform_-_For_life%22.png" style="height:30px;">
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#E1BE9A;color:#000000FF;">
13.59%
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#E1BD9A;color:#000000FF;">
13.66%
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#E5C7A2;color:#000000FF;">
11.57%
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#E5C6A1;color:#000000FF;">
11.78%
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#E0BC99;color:#000000FF;">
13.89%
</td>
</tr>
<tr>
<td class="gt_row gt_left" style="background-color:white;">
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/European_Solidarity.svg/2880px-European_Solidarity.svg.png" style="height:30px;">
</td>
<td class="gt_row gt_right" style="background-color:#EAD0A8;color:#000000FF;">
9.76%
</td>
<td class="gt_row gt_right" style="background-color:#EFDBB1;color:#000000FF;">
7.36%
</td>
<td class="gt_row gt_right" style="background-color:#F1DFB3;color:#000000FF;">
6.66%
</td>
<td class="gt_row gt_right" style="background-color:#F2E2B6;color:#000000FF;">
5.91%
</td>
<td class="gt_row gt_right" style="background-color:#F3E3B7;color:#000000FF;">
5.74%
</td>
</tr>
<tr>
<td class="gt_row gt_left gt_striped" style="background-color:white;">
<img src="https://upload.wikimedia.org/wikipedia/commons/2/25/Holos.png" style="height:30px;">
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#F0DDB2;color:#000000FF;">
6.95%
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#F2E2B6;color:#000000FF;">
6.05%
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#F4E6B9;color:#000000FF;">
5.22%
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#F7ECBD;color:#000000FF;">
3.92%
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#F8EFC0;color:#000000FF;">
3.26%
</td>
</tr>
<tr>
<td class="gt_row gt_left" style="background-color:white;">
<img src="https://upload.wikimedia.org/wikipedia/commons/a/a1/%D0%92%D0%9E_%C2%AB%D0%91%D0%B0%D1%82%D1%8C%D0%BA%D1%96%D0%B2%D1%89%D0%B8%D0%BD%D0%B0%C2%BB.png" style="height:30px;">
</td>
<td class="gt_row gt_right" style="background-color:#F1DFB4;color:#000000FF;">
6.58%
</td>
<td class="gt_row gt_right" style="background-color:#EED9AF;color:#000000FF;">
7.82%
</td>
<td class="gt_row gt_right" style="background-color:#EAD0A8;color:#000000FF;">
9.79%
</td>
<td class="gt_row gt_right" style="background-color:#E8CBA5;color:#000000FF;">
10.69%
</td>
<td class="gt_row gt_right" style="background-color:#E7CBA4;color:#000000FF;">
10.79%
</td>
</tr>
<tr>
<td class="gt_row gt_left gt_striped" style="background-color:white;">
<img src="https://file.liga.net/images/general/2019/07/18/20190718084728-9963.jpg" style="height:30px;">
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#F6EABC;color:#000000FF;">
4.37%
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#F7EDBE;color:#000000FF;">
3.68%
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#F8EEBF;color:#000000FF;">
3.47%
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#F8F0C0;color:#000000FF;">
3.17%
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#F9F1C1;color:#000000FF;">
2.85%
</td>
</tr>
<tr>
<td class="gt_row gt_left" style="background-color:white;">
<img src="https://upload.wikimedia.org/wikipedia/commons/6/6b/Opposition_Bloc_2019.png" style="height:30px;">
</td>
<td class="gt_row gt_right" style="background-color:#F8EFC0;color:#000000FF;">
3.32%
</td>
<td class="gt_row gt_right" style="background-color:#F9F0C1;color:#000000FF;">
3.04%
</td>
<td class="gt_row gt_right" style="background-color:#FAF3C3;color:#000000FF;">
2.46%
</td>
<td class="gt_row gt_right" style="background-color:#F9F2C2;color:#000000FF;">
2.68%
</td>
<td class="gt_row gt_right" style="background-color:#F9F1C1;color:#000000FF;">
2.88%
</td>
</tr>
<tr>
<td class="gt_row gt_left gt_striped" style="background-color:white;">
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/%D0%9B%D0%BE%D0%B3%D0%BE%D1%82%D0%B8%D0%BF_%D0%BF%D0%B0%D1%80%D1%82%D0%B8%D0%B8_%D0%A8%D0%B0%D1%80%D0%B8%D1%8F.svg/1920px-%D0%9B%D0%BE%D0%B3%D0%BE%D1%82%D0%B8%D0%BF_%D0%BF%D0%B0%D1%80%D1%82%D0%B8%D0%B8_%D0%A8%D0%B0%D1%80%D0%B8%D1%8F.svg.png" style="height:30px;">
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#F8EFC0;color:#000000FF;">
3.25%
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#FBF5C4;color:#000000FF;">
2.07%
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#FCF9C7;color:#000000FF;">
1.23%
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#FDFBC9;color:#000000FF;">
0.9%
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#FDFBC9;color:#000000FF;">
0.82%
</td>
</tr>
<tr>
<td class="gt_row gt_left" style="background-color:white;">
<img src="https://upload.wikimedia.org/wikipedia/uk/c/c1/%D0%A3%D0%BA%D1%80%D0%B0%D1%97%D0%BD%D1%81%D1%8C%D0%BA%D0%B0_%D0%A1%D1%82%D1%80%D0%B0%D1%82%D0%B5%D0%B3%D1%96%D1%8F_%D0%93%D1%80%D0%BE%D0%B9%D1%81%D0%BC%D0%B0%D0%BD%D0%B0.jpg" style="height:30px;">
</td>
<td class="gt_row gt_right" style="background-color:#FAF5C4;color:#000000FF;">
2.12%
</td>
<td class="gt_row gt_right" style="background-color:#FAF4C4;color:#000000FF;">
2.22%
</td>
<td class="gt_row gt_right" style="background-color:#F9F1C1;color:#000000FF;">
2.92%
</td>
<td class="gt_row gt_right" style="background-color:#F9F1C1;color:#000000FF;">
2.84%
</td>
<td class="gt_row gt_right" style="background-color:#F9F1C1;color:#000000FF;">
2.88%
</td>
</tr>
<tr>
<td class="gt_row gt_left gt_striped" style="background-color:white;">
<img src="https://upload.wikimedia.org/wikipedia/commons/9/98/%D0%9B%D0%BE%D0%B3%D0%BE%D1%82%D0%B8%D0%BF_%D0%92%D1%81%D0%B5%D1%83%D0%BA%D1%80%D0%B0%D1%97%D0%BD%D1%81%D1%8C%D0%BA%D0%BE%D0%B3%D0%BE_%D0%BE%D0%B1%27%D1%94%D0%B4%D0%BD%D0%B0%D0%BD%D0%BD%D1%8F_%C2%AB%D0%A1%D0%B2%D0%BE%D0%B1%D0%BE%D0%B4%D0%B0%C2%BB.png" style="height:30px;">
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#FBF5C4;color:#000000FF;">
2.09%
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#FAF4C4;color:#000000FF;">
2.19%
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#FAF3C3;color:#000000FF;">
2.44%
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#FAF4C4;color:#000000FF;">
2.22%
</td>
<td class="gt_row gt_right gt_striped" style="background-color:#FBF5C5;color:#000000FF;">
1.99%
</td>
</tr>
<tr>
<td class="gt_row gt_left" style="background-color:white;">
<img src="https://upload.wikimedia.org/wikipedia/commons/1/1d/Radical_Party_of_Oleh_Lyashko_logo.png" style="height:30px;">
</td>
<td class="gt_row gt_right" style="background-color:#FBF6C5;color:#000000FF;">
1.76%
</td>
<td class="gt_row gt_right" style="background-color:#F8EFC0;color:#000000FF;">
3.35%
</td>
<td class="gt_row gt_right" style="background-color:#F3E3B7;color:#000000FF;">
5.67%
</td>
<td class="gt_row gt_right" style="background-color:#EEDAB0;color:#000000FF;">
7.71%
</td>
<td class="gt_row gt_right" style="background-color:#ECD6AC;color:#000000FF;">
8.58%
</td>
</tr>
</tbody>
<tfoot>
<tr>
<td colspan="7" class="gt_sourcenote">
За даними сайту ЦВК (без врахування спецдільниць)
</td>
</tr>
</tfoot>
</table>
<!--gt table end-->

<!--/html_preserve-->
Так, фактор 4G суттєво не змінює підтримку Слуги народу та ОПЗЖ, однак є
дуже відчутним для Європейської солідарності та Голосу, підтримка яких
зосереджена переважно на тих дільницях, де є хороше 4G покриття. У той
же час такі партії як Батьківщина та особливо Радикальна партія отримали
основну підтримку на дільницях з гіршим покриттям мобільного інтернету
останнього покоління. Наприклад, радикали мають на дільницях без 4G
більше 8% підтримки та 4 рейтингову сходинку.

Цікавим також є кейс партії Шарія, яка в сукупності дільниць з повним
покриттям 4G інтернетом 3-ма операторами має майже в 4 рази більшу
підтримку, ніж на дільницях, де покриття нема взагалі.

Таким чином, доступ до інтернету є одним із факторів, який впливає на
вибори, хоча не потрібно його перебільшувати. З 5 прохідних партій
тільки Голос не мав достатньої підтримки серед виборців, які прописані в
межах дільниць без 4G інтернету, для проходу в парламент. Чисті
інтернет-проекти поки існує 5% прохідний бар’єр і поки якість покриття
зв’язком не є ідеальною не претендують на прохід в парламент.
