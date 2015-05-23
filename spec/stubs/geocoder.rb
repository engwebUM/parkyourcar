Geocoder.configure(lookup: :test)

Geocoder::Lookup::Test.add_stub(
  'Allen Street', [
    {
      'latitude'  => 40.718760,
      'longitude' => -73.990486
    }
  ]
)

Geocoder::Lookup::Test.add_stub(
  'Broadway', [
    {
      'latitude'  => 40.790962,
      'longitude' => -73.974711
    }
  ]
)

Geocoder::Lookup::Test.add_stub(
  'Times Square', [
    {
      'latitude'  => 40.758883,
      'longitude' => -73.985142
    }
  ]
)

Geocoder::Lookup::Test.add_stub(
  'Mountain View', [
    {
      'latitude'  => 37.393046,
      'longitude' => -122.085208
    }
  ]
)

Geocoder::Lookup::Test.set_default_stub(
  [
    {
      'latitude'  => 40.7127837,
      'longitude' => -74.0059413
    }
  ]
)
