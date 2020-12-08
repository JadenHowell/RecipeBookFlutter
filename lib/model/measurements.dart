enum Measurement{
  NA,
  teaspoon,
  tablespoon,
  cup,
  pint,
  quart,
  gallon,
  litre,
  ounce,
  pound,
  kilo,
  cube,
  package,
}


extension MeasurementString on Measurement{
  String toReadableString(){
    switch (this) {
      case Measurement.teaspoon:
        {
          return 'tsp';
        }
        break;
      case Measurement.tablespoon:
        {
          return 'Tbsp';
        }
        break;
      case Measurement.cup:
        {
          return 'c';
        }
        break;
      case Measurement.cube:
        {
          return 'cube';
        }
        break;
      case Measurement.gallon:
        {
          return 'gal';
        }
        break;
      case Measurement.kilo:
        {
          return 'kg';
        }
        break;
      case Measurement.litre:
        {
          return 'L';
        }
        break;
      case Measurement.ounce:
        {
          return 'oz';
        }
        break;
      case Measurement.pint:
        {
          return 'pt';
        }
        break;
      case Measurement.pound:
        {
          return 'lb';
        }
        break;
      case Measurement.quart:
        {
          return 'qt';
        }
        break;
      case Measurement.NA:
        {
          return 'N/A';
        }
        break;
      case Measurement.package:
        {
          return 'pkg';
        }
        break;
    }
    return '';
  }
}