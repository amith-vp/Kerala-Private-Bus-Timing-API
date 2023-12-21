# ENDPOINT

## GET /api/v1/schedules

Returns a list of trips between two stations, optionally filtered by departure time and optionally excluding stations before the departure station and after the destination station.

### Parameters

- `departure` (required, string): The name of the departure station.
- `destination` (required, string): The name of the destination station.
- `time` (optional, string): The earliest departure time from the departure station, in 24-hour format (HH:MM). Only trips that depart after this time will be included.
- `exclude` (optional, boolean): If true, stations before the departure station and after the destination station will be excluded.

### Response

A JSON array of trips. Each trip is an object with the following properties:

- `vehicle_number` (string): The vehicle number of the bus.
- `trip` (string): The trip identifier.
- `stations` (array): An array of stations that the bus stops at. Each station is an object with the following properties:
  - `station` (string): The name of the station.
  - `arrivalTime` (string): The arrival time at the station, in 12-hour format.
  - `departureTime` (string): The departure time from the station, in 12-hour format.

### Example

Request:

https://busapi.amithv.xyz/api/v1/schedules?departure=HIGH%20COURT%20JUNCTION&destination=ERNAKULAM%20SOUTH&time=12:00

Response:

```json
[
  {
    "vehicle_number": "KL 02 S 2003",
    "trip": 6,
    "stations": [
      {
        "station": "HIGH COURT JUNCTION",
        "arrivalTime": "12:20 pm",
        "departureTime": "12:20 pm"
      },
      {
        "station": "ERNAKULAM SOUTH",
        "arrivalTime": "12:27 pm",
        "departureTime": "12:27 pm"
      },
      {
        "station": "POOTHOTTA",
        "arrivalTime": "01:27 pm",
        "departureTime": "01:27 pm"
      }
    ]
  }
  // More Schedules
]
```
