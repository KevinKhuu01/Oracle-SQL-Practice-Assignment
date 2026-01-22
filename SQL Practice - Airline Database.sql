drop table E_AIR_payment; --1
drop table E_AIR_Booking_flight; --2
drop table E_AIR_payment_method; -- 3
drop table E_AIR_passenger;  --4
drop table E_AIR_flight;  --5
drop table E_AIR_Aircraft; -- 6
drop table E_AIR_booking; --7
drop table E_AIR_airport; --8
drop table E_AIR_Customer; --9 

select * from E_AIR_Customer;
select * from E_AIR_Payment;
select * from E_AIR_aircraft;
select * from E_AIR_flight;
select * from E_AIR_booking;
select * from E_AIR_booking_flight;
select * from E_AIR_passenger;
select * from E_AIR_PAYMENT_METHOD;
select * from E_AIR_airport;

-- SHOW ALL EMAILS OF PASSENGERS BOOKED ON FLIGHT 301
SELECT EMAIL FROM E_AIR_CUSTOMER C
JOIN E_AIR_PASSENGER P ON P.CUSTOMER_ID = C.CUSTOMER_ID
WHERE FLIGHT_ID = 301;


-- SHOW CUSTOMERS PAYMENTS WITH NAME OF EACH BANK PROVIDER USED
select PAYMENT_ID, AMOUNT, STATUS, PAYMENT_DATE, BOOKING_ID, METHOD_NAME from E_AIR_Payment P
JOIN E_AIR_PAYMENT_METHOD PM ON PM.METHOD_ID = P.METHOD_ID 


-- SHOW HOW MANY ERSAN AIR FLIGHTS ARE COMING OUT OF EACH AIRPORT
SELECT NAME, COUNT(DEPARTURE_AIRPORT_ID) FROM E_AIR_AIRPORT A
JOIN E_AIR_FLIGHT F ON F.DEPARTURE_AIRPORT_ID = A.AIRPORT_ID
GROUP BY NAME


-- Create script
CREATE TABLE E_AIR_Customer (
  customer_id NUMBER PRIMARY KEY,
  first_name VARCHAR2(100),
  last_name VARCHAR2(100),
  id VARCHAR2(50),
  password VARCHAR2(100),
  email VARCHAR2(100),
  phone VARCHAR2(20),
  gender CHAR(1) CHECK (gender IN ('M', 'F', 'O')),
  passport_no VARCHAR2(20)
);
CREATE TABLE E_AIR_Payment_Method (
  method_id NUMBER PRIMARY KEY,
  method_name VARCHAR2(50)
);
CREATE TABLE E_AIR_Airport (
  airport_id NUMBER PRIMARY KEY,
  name VARCHAR2(100),
  code VARCHAR2(10),
  country VARCHAR2(100)
); 
CREATE TABLE E_AIR_Booking (
  booking_id NUMBER PRIMARY KEY,
  booking_date DATE,
  status VARCHAR2(20) CHECK (status IN ('confirmed', 'pending', 'cancelled')),
  customer_id NUMBER,
  FOREIGN KEY (customer_id) REFERENCES E_AIR_Customer(customer_id)
); 
CREATE TABLE E_AIR_Payment (
  payment_id NUMBER PRIMARY KEY,
  amount NUMBER(10,2),
  status VARCHAR2(20) CHECK (status IN ('paid', 'pending', 'failed')),
  payment_date DATE,
  booking_id NUMBER,
  method_id NUMBER,
  FOREIGN KEY (booking_id) REFERENCES E_AIR_Booking(booking_id),
  FOREIGN KEY (method_id) REFERENCES E_AIR_Payment_Method(method_id)
);
CREATE TABLE E_AIR_Aircraft (
  aircraft_id NUMBER PRIMARY KEY,
  model VARCHAR2(50),
  seat_capacity NUMBER,
  airport_id NUMBER,
  FOREIGN KEY (airport_id) REFERENCES E_AIR_Airport(airport_id)
);
CREATE TABLE E_AIR_Flight (
  flight_id NUMBER PRIMARY KEY,
  flight_code VARCHAR2(20),
  depart_time DATE,
  arrival_time DATE,
  departure_airport_id NUMBER,
  arrival_airport_id NUMBER,
  aircraft_id NUMBER,
  FOREIGN KEY (departure_airport_id) REFERENCES E_AIR_Airport(airport_id),
  FOREIGN KEY (arrival_airport_id) REFERENCES E_AIR_Airport(airport_id),
  FOREIGN KEY (aircraft_id) REFERENCES E_AIR_Aircraft(aircraft_id)
);
CREATE TABLE E_AIR_Booking_Flight (
  booking_id NUMBER,
  flight_id NUMBER,
  PRIMARY KEY (booking_id, flight_id),
  FOREIGN KEY (booking_id) REFERENCES E_AIR_Booking(booking_id),
  FOREIGN KEY (flight_id) REFERENCES E_AIR_Flight(flight_id)
);
CREATE TABLE E_AIR_Passenger (
  passenger_id NUMBER PRIMARY KEY,
  first_name VARCHAR2(100),
  last_name VARCHAR2(100),
  gender CHAR(1) CHECK (gender IN ('M', 'F', 'O')),
  passport_no VARCHAR2(20),
  birthday DATE,
  customer_id NUMBER,
  booking_id NUMBER,
  flight_id NUMBER,
  FOREIGN KEY (customer_id) REFERENCES E_AIR_Customer(customer_id),
  FOREIGN KEY (booking_id) REFERENCES E_AIR_Booking(booking_id),
  FOREIGN KEY (flight_id) REFERENCES E_AIR_Flight(flight_id)
);

-- Insert into E_AIR_Customer
INSERT INTO E_AIR_Customer VALUES (1, 'Seounghoon', 'Jung', 'jung123', '**123', 'sjung@example.com', '01012345678', 'F', 'P1234567');
INSERT INTO E_AIR_Customer VALUES (2, 'Kevin', 'kyle', 'kyle777', '**123', 'kkyle@example.com', '01023456789', 'M', 'P2345678');
INSERT INTO E_AIR_Customer VALUES (3, 'Kevin', 'Khuu', 'kkhuu001', '**123', 'kkhuu1@example.com', '01034567890', 'M', 'P3456789');
INSERT INTO E_AIR_Customer VALUES (4, 'Suzurimi', 'Ken', 'kensuzu', '**123', 'sken321@example.com', '01045678901', 'F', 'P4567890');
INSERT INTO E_AIR_Customer VALUES (5, 'david', 'andres', 'dandres', '**123', 'dandres@example.com', '01056789012', 'M', 'P5678901');

-- Insert into E_AIR_Payment_Method
INSERT INTO E_AIR_Payment_Method VALUES (1, 'Credit Card');
INSERT INTO E_AIR_Payment_Method VALUES (2, 'Debit Card');
INSERT INTO E_AIR_Payment_Method VALUES (3, 'Bank Transfer');
INSERT INTO E_AIR_Payment_Method VALUES (4, 'Gift Card');

-- Insert into E_AIR_Airport
INSERT INTO E_AIR_Airport VALUES (1, 'Incheon Intl', 'ICN', 'South Korea');
INSERT INTO E_AIR_Airport VALUES (2, 'Toronto Pearson', 'YYZ', 'Canada');
INSERT INTO E_AIR_Airport VALUES (3, 'Los Angeles', 'LAX', 'USA');
INSERT INTO E_AIR_Airport VALUES (4, 'Heathrow', 'LHR', 'UK');
INSERT INTO E_AIR_Airport VALUES (5, 'Narita', 'NRT', 'Japan');

-- Insert into E_AIR_Aircraft
INSERT INTO E_AIR_Aircraft VALUES (1, 'Boeing 737', 150, 1);
INSERT INTO E_AIR_Aircraft VALUES (2, 'Airbus A320', 180, 2);
INSERT INTO E_AIR_Aircraft VALUES (3, 'Boeing 777', 300, 3);
INSERT INTO E_AIR_Aircraft VALUES (4, 'Airbus A380', 500, 4);
INSERT INTO E_AIR_Aircraft VALUES (5, 'Embraer E190', 100, 5);

-- Insert into E_AIR_Booking
INSERT INTO E_AIR_Booking VALUES (101, TO_DATE('24-05-01', 'YY-MM-DD'), 'confirmed', 1);
INSERT INTO E_AIR_Booking VALUES (102, TO_DATE('24-05-03', 'YY-MM-DD'), 'pending', 2);
INSERT INTO E_AIR_Booking VALUES (103, TO_DATE('24-05-05', 'YY-MM-DD'), 'cancelled', 3);
INSERT INTO E_AIR_Booking VALUES (104, TO_DATE('24-05-07', 'YY-MM-DD'), 'confirmed', 4);
INSERT INTO E_AIR_Booking VALUES (105, TO_DATE('24-05-09', 'YY-MM-DD'), 'confirmed', 5);

-- Insert into E_AIR_Flight
INSERT INTO E_AIR_Flight VALUES (301, 'KE101', TO_DATE('24-06-01 08:00', 'YY-MM-DD HH24:MI'), TO_DATE('24-06-01 13:00', 'YY-MM-DD HH24:MI'), 1, 2, 1);
INSERT INTO E_AIR_Flight VALUES (302, 'AC202', TO_DATE('24-06-02 09:00', 'YY-MM-DD HH24:MI'), TO_DATE('24-06-02 14:00', 'YY-MM-DD HH24:MI'), 2, 3, 2);
INSERT INTO E_AIR_Flight VALUES (303, 'DL303', TO_DATE('24-06-03 10:00', 'YY-MM-DD HH24:MI'), TO_DATE('24-06-03 16:00', 'YY-MM-DD HH24:MI'), 3, 4, 3);
INSERT INTO E_AIR_Flight VALUES (304, 'BA404', TO_DATE('24-06-04 11:00', 'YY-MM-DD HH24:MI'), TO_DATE('24-06-04 17:00', 'YY-MM-DD HH24:MI'), 4, 5, 4);
INSERT INTO E_AIR_Flight VALUES (305, 'JL505', TO_DATE('24-06-05 12:00', 'YY-MM-DD HH24:MI'), TO_DATE('24-06-05 18:00', 'YY-MM-DD HH24:MI'), 5, 1, 5);

-- Insert into E_AIR_Payment
INSERT INTO E_AIR_Payment VALUES (201, 300.00, 'paid', TO_DATE('24-05-01', 'YY-MM-DD'), 101, 1);
INSERT INTO E_AIR_Payment VALUES (202, 250.00, 'pending', TO_DATE('24-05-03', 'YY-MM-DD'), 102, 2);
INSERT INTO E_AIR_Payment VALUES (203, 150.00, 'failed', TO_DATE('24-05-05', 'YY-MM-DD'), 103, 2);
INSERT INTO E_AIR_Payment VALUES (204, 400.00, 'paid', TO_DATE('24-05-07', 'YY-MM-DD'), 104, 4);
INSERT INTO E_AIR_Payment VALUES (205, 220.00, 'paid', TO_DATE('24-05-09', 'YY-MM-DD'), 105, 3);

-- Insert into E_AIR_Booking_Flight
INSERT INTO E_AIR_Booking_Flight VALUES (101, 301);
INSERT INTO E_AIR_Booking_Flight VALUES (102, 302);
INSERT INTO E_AIR_Booking_Flight VALUES (103, 303);
INSERT INTO E_AIR_Booking_Flight VALUES (104, 304);
INSERT INTO E_AIR_Booking_Flight VALUES (105, 305);

-- Insert into E_AIR_Passenger
INSERT INTO E_AIR_Passenger VALUES (401, 'Seounghoon', 'Jung', 'F', 'P1234567', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 1, 101, 301);
INSERT INTO E_AIR_Passenger VALUES (402, 'Kevin', 'kyle', 'M', 'P2345678', TO_DATE('1988-02-02', 'YYYY-MM-DD'), 2, 102, 302);
INSERT INTO E_AIR_Passenger VALUES (403, 'Kevin', 'Khuu', 'M', 'P3456789', TO_DATE('1992-03-03', 'YYYY-MM-DD'), 3, 103, 303);
INSERT INTO E_AIR_Passenger VALUES (404, 'Suzurimi', 'Ken', 'F', 'P4567890', TO_DATE('1995-04-04', 'YYYY-MM-DD'), 4, 104, 304);
INSERT INTO E_AIR_Passenger VALUES (405, 'david', 'andres', 'M', 'P5678901', TO_DATE('1993-05-05', 'YYYY-MM-DD'), 5, 105, 305);

select * from e_air_customer
select * from e_air_aircraft
select * from e_air_passenger
select * from e_air_flight


-- Show all customer information and flight dates with passport numbers ending in 7, 8, or 9 on flights between june 1-4 2024
SELECT AC.*, F.DEPART_TIME, F.ARRIVAL_TIME FROM E_AIR_CUSTOMER AC
JOIN E_AIR_PASSENGER AP ON AP.CUSTOMER_ID = AC.CUSTOMER_ID
JOIN E_AIR_FLIGHT F ON F.FLIGHT_ID = AP.FLIGHT_ID
WHERE SUBSTR(AP.PASSPORT_NO, -1, 1) IN ('7', '8', '9')
AND F.DEPART_TIME BETWEEN TO_DATE('2024-06-01', 'YYYY-MM-DD') AND TO_DATE('2024-06-04', 'YYYY-MM-DD')

-- Show the count of each payment method status where the amount is greater than 200.00 in descending order
SELECT STATUS, COUNT(*) FROM E_AIR_PAYMENT
WHERE AMOUNT > 200
GROUP BY STATUS
ORDER BY COUNT(*) DESC


-- Show the names of payment methods of all aircrafts with more than 200 seats and average payment amount is greater than $200
SELECT AC.MODEL, PM.METHOD_NAME, AVG(P.AMOUNT) FROM E_AIR_AIRCRAFT AC
JOIN E_AIR_FLIGHT F ON F.AIRCRAFT_ID = AC.AIRCRAFT_ID
JOIN E_AIR_BOOKING_FLIGHT BF ON BF.FLIGHT_ID = F.FLIGHT_ID
JOIN E_AIR_BOOKING B ON B.BOOKING_ID = BF.BOOKING_ID
JOIN E_AIR_PAYMENT P ON P.BOOKING_ID = B.BOOKING_ID
JOIN E_AIR_PAYMENT_METHOD PM ON PM.METHOD_ID = P.METHOD_ID
WHERE AC.SEAT_CAPACITY > 200
AND 
(SELECT AVG(AMOUNT) FROM E_AIR_PAYMENT) > 200
GROUP BY AC.MODEL, PM.METHOD_NAME






















