Geocoder.configure(lookup: :test)

Geocoder::Lookup::Test.add_stub(
  'Allen Street, New York, USA', [
    {
      'latitude'  => 40.7187154,
      'longitude' => -73.9904645
    }
  ]
)

Geocoder::Lookup::Test.add_stub(
  'Broadway, New York, USA', [
    {
      'latitude'  => 40.76164,
      'longitude' => -73.80176
    }
  ]
)

Geocoder::Lookup::Test.add_stub(
  'Times Square, New York, USA', [
    {
      'latitude'  => 40.759011,
      'longitude' => -73.9844722
    }
  ]
)

Geocoder::Lookup::Test.add_stub(
  '1263 California St, Mountain View, USA', [
    {
      'latitude'  => 37.393029,
      'longitude' => -122.085585
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
