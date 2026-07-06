enum UkraineRegion {
  vinnytsia(1, 'Вінницька область'),
  volyn(2, 'Волинська область'),
  dnipropetrovsk(3, 'Дніпропетровська область'),
  donetsk(4, 'Донецька область'),
  zhytomyr(5, 'Житомирська область'),
  zakarpattia(6, 'Закарпатська область'),
  zaporizhzhia(7, 'Запорізька область'),
  ivanoFrankivsk(8, 'Івано-Франківська область'),
  kyiv(9, 'Київська область'),
  kirovohrad(10, 'Кіровоградська область'),
  luhansk(16, 'Луганська область'),
  lviv(13, 'Львівська область'),
  mykolaiv(14, 'Миколаївська область'),
  odesa(15, 'Одеська область'),
  poltava(17, 'Полтавська область'),
  rivne(18, 'Рівненська область'),
  sumy(19, 'Сумська область'),
  ternopil(20, 'Тернопільська область'),
  kharkiv(21, 'Харківська область'),
  kherson(22, 'Херсонська область'),
  khmelnytskyi(23, 'Хмельницька область'),
  cherkasy(24, 'Черкаська область'),
  chernivtsi(25, 'Чернівецька область'),
  chernihiv(26, 'Чернігівська область'),
  crimea(29, 'Автономна Республіка Крим'),
  kyivCity(31, 'м. Київ'),
  sevastopol(30, 'м. Севастополь');

  const UkraineRegion(this.uid, this.title);

  final int uid;
  final String title;

  static UkraineRegion? fromUid(int uid) {
    for (final region in UkraineRegion.values) {
      if (region.uid == uid) {
        return region;
      }
    }
    return null;
  }
}
