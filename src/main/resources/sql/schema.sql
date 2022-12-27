drop table if exists bookings;
drop table if exists trips;
drop table if exists locations;
drop table if exists vehicles;
drop table if exists users;

create table users
(
    user_id       int generated always as identity primary key,
    email         varchar(255) unique not null,
    password      varchar(50)         not null,
    first_name    varchar(255)        not null,
    last_name     varchar(255)        not null,
    birth_date    date                not null,
    driver_rating numeric(2, 1),
    created_on    timestamp default now(),
    last_login    timestamp
    -- license - enum sau tabel
    -- phone_number
    -- profile_picture
);

create table vehicles
(
    plate_number      varchar(20) primary key,
    country_code      char(2)     not null,
    brand             varchar(50) not null,
    model             varchar(50) not null,
    color             varchar(50) not null,
    registration_year date        not null,
    owner             int references users (user_id)
);

create table locations
(
    location_id   int generated always as identity primary key,
    name varchar(255) unique not null
);

create table trips
(
    trip_id            int generated always as identity primary key,
    departure_location int references locations (location_id),
    arrival_location   int references locations (location_id),
    departure_address  varchar(255) not null,
    arrival_address    varchar(255) not null,
    driver             int references users (user_id),
    price              smallint     not null,
    seats              smallint     not null,
    additinal_comment  varchar(255)
    -- traseu selectat pe harta
);

create table bookings
(
    trip      int references trips (trip_id),
    booked_by int references users (user_id),
    booked_at timestamp default now(),
    primary key (trip, booked_by)
)

-- create table connections
-- (
--     connection_id       int generated always as identity primary key,
--     departure_location  int references locations (location_id),
--     arrival_location    int references locations (location_id),
--     departure_timestamp timestamp not null,
--     arrival_timestamp   timestamp not null,
--     trip                int references trips (trip_id)
-- );