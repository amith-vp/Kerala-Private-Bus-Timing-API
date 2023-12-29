# ENDPOINT

## GET /api/v1/schedules/:departure/:destination

Returns a list of trips between two stations, optionally filtered by departure time and optionally excluding stations before the departure station and after the destination station.

### Parameters

- `departure` (required, string): The name of the departure station.
- `destination` (required, string): The name of the destination station.
- `time` (optional, string): The earliest departure time from the departure station, in 24-hour format (HH:MM). Only trips that depart after this time will be included.
- `restrict` (optional, boolean): If true, stations before the departure station and after the destination station will be excluded.

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

https://busapi.amithv.xyz/api/v1/schedules/high_court_junction/ernakulam_south&time=12:00

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

## GET /api/v1/search

Returns the full route of a bus by searching its vehicle number.

### Parameters

- `vehicle_number` (required, string): The vehicle number of the bus. It can be provided with or without spaces.

### Response

A JSON array of routes. Each route is an object with the following properties:

- `trip` (string): The trip identifier.
- `stations` (array): An array of stations that the bus stops at. Each station is an object with the following properties:
  - `station` (string): The name of the station.
  - `arrivalTime` (string): The arrival time at the station, in 12-hour format.
  - `departureTime` (string): The departure time from the station, in 12-hour format.

If no bus is found with the provided vehicle number, a JSON object with an `error` property will be returned.

### Example

Request:

https://busapi.amithv.xyz/api/v1/search?vehicle_number=KL41A1251

This will return the full route of the bus with the vehicle number "KL41A1251".

# Installation Guide

Follow the steps below to install and setup the API:

# Prerequisites

You need to have Ruby on Rails installed on your machine. If you don't have it installed, you can follow the instructions on the [official Rails guide](https://guides.rubyonrails.org/getting_started.html#installing-rails) to install it.

## Step 1: Clone the Repository

First, clone the repository to your local machine. You can do this by running the following command in your terminal:

```bash
git clone https://github.com/amith-vp/Kerala-Private-Bus-Timing-API
```

## Step 1.5: Install Dependencies
After cloning the repository, navigate to the project directory and run

```bash
bundle install
```

## Step 2: Setup the Database

The application uses default DB SQLite3 of Rails,PostgreSQL can also be used.

## Step 3: Database Migration

Next, migrate the database by running the following command in your terminal:

```bash
rails db:migrate
```

## Step 4: Add JSON File

Download the required JSON file from [amith-vp/Kerala-Private-Bus-Timing](https://github.com/amith-vp/Kerala-Private-Bus-Timing) and paste it in the `db/data.json` directory of your cloned repository.

## Step 5: Seed the Database

Seed the database by running the following command in your terminal:

```bash
rails db:seed
```

This process might take around 2-3 minutes.

## Step 6: Start the Server

Finally, start the server by running the following command in your terminal:

```bash
rails s
```

Now, you should be able to access the application on your local machine.

## Step 7: Access the API

You can access the API from the following URL:

```
http://localhost:3000/api/v1/schedules/aluva/kakkanad
```

