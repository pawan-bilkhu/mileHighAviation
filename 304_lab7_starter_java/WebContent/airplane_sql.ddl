DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;
DROP VIEW CustView;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    UNIQUE(userid),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATETIME,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(20,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(500),
    productPrice        DECIMAL(20,2),
    productImageURL     VARCHAR(100),
    productDesc         VARCHAR(MAX),
    productOrigin       VARCHAR(100),
    PRIMARY KEY (productId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(20,2),
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(20,2),
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,
    shipmentDesc        VARCHAR(100),
    warehouseId         INT,
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory (
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(20,2),
    PRIMARY KEY (productId, warehouseId),
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(MAX),
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '2041112222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '5723428911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '3334445555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '2508072222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '5556667777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Admin', 'Istrator', 'admin@mha.com', '2508089823', 'DDL', 'VScode', 'PC', 'N/A', 'Canada', 'admin' , '123');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Felipe', 'Chalhub', 'felipe@mha.com', '1234567891', '2234 Richter', 'Kelowna', 'Bc', 'V2L6TD', 'Canada', 'felipe' , 'mha1');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Amer', 'Siddique', 'amer@mha.com', '1234567891', '2234 Richter', 'Kelowna', 'Bc', 'V2L6TD', 'Canada', 'amer' , 'mha2');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Omar', 'Mourad', 'omar@mha.com', '1234567891', '2234 Richter', 'Kelowna', 'Bc', 'V2L6TD', 'Canada', 'omar' , 'mha3');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Pawan', 'Bilkhu', 'pawan@mha.com', '1234567891', '2234 Richter', 'Kelowna', 'Bc', 'V2L6TD', 'Canada', 'pawan' , 'mha4');


INSERT INTO paymentmethod (customerId, paymentNumber, paymentType, paymentExpiryDate) VALUES (1, '1252 5678 9876 5432', 'Visa', '2022-09-10');
INSERT INTO paymentmethod (customerId, paymentNumber, paymentType, paymentExpiryDate) VALUES (1, '1624 0230 9615 5432', 'Master Card',  '2024-10-15');
INSERT INTO paymentmethod (customerId, paymentNumber, paymentType, paymentExpiryDate) VALUES (7, '1234 1560 9876 5432', 'Visa', '2019-10-15');
INSERT INTO paymentmethod (customerId, paymentNumber, paymentType, paymentExpiryDate) VALUES (8, '4656 5678 2020 1566', 'Master Card',  '2025-11-12');
INSERT INTO paymentmethod (customerId, paymentNumber, paymentType, paymentExpiryDate) VALUES (9, '1234 5678 9876 5432', 'Visa', '2019-10-15');
INSERT INTO paymentmethod (customerId, paymentNumber, paymentType, paymentExpiryDate) VALUES (10, '5615 4564 6308 0233', 'Master Card',  '2023-08-06');
INSERT INTO paymentmethod (customerId, paymentNumber, paymentType, paymentExpiryDate) VALUES (1, '2365 3615 9026 5321', 'Visa', '2019-10-15');
INSERT INTO paymentmethod (customerId, paymentNumber, paymentType, paymentExpiryDate) VALUES (2, '1166 1561 8916 0568', 'Master Card',  '2024-07-03');
INSERT INTO paymentmethod (customerId, paymentNumber, paymentType, paymentExpiryDate) VALUES (3, '9785 0231 5161 1891', 'Visa', '2019-10-15');
INSERT INTO paymentmethod (customerId, paymentNumber, paymentType, paymentExpiryDate) VALUES (4, '1651 0551 6514 1651', 'Master Card',  '2026-10-15');




CREATE VIEW CustView AS
SELECT customerId, firstName, lastName, userid, password
FROM customer;

INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('AASI Jetcruzer ',72155436.0,'img/0015085-v40-6.jpg',' The innovative Jetcruzer 500 is designed to be a high speed low cost single engine corporate turboprop and is the product of California based Advanced Aerodynamics and Structures Inc (AASI).

The Jetcruzer 500 is based on the smaller, unpressurised Jetcruzer 450. Early design work for what would become the Jetcruzer 450 began in 1983. Construction of an Allison 250-C20S powered prototype began in 1988. It flew for the first time on January 11 1989.

The preproduction prototype first flew April 1991, and the first production standard Jetcruzer 450 on September 13 1992. When FAA Part 23 certification was granted on June 14 1994 the Jetcruzer became the first aircraft in the world to be certificated as spin resistant.

AASI elected not to place the 450 into production and instead focused its efforts on the pressurised 500. Initial work was on the 500P, which featured a modest 25cm (10in) fuselage stretch, but AASI instead decided to enlarge the design further. The definitive Jetcruzer features a 1.83m (6ft) fuselage stretch over the 450 (increasing cabin length by 90cm (3ft), plus a significantly more powerful PT6A66 turboprop driving a five (rather than three) blade prop, pressurisation to 30,000ft, an airstair entry door on the right hand side and additional cabin windows.

First flight of the prototype 500 (the modified preproduction prototype 450) was in August 22 1997, followed by the second prototype (the modified production 450) on November 7 1997.

Other notable Jetcruzer 500 design features include its canard configuration (which allows the main wing to be positioned further aft than normal, so the wing spars do not intrude into the cabin), lack of flaps (reducing pilot work load and manufacturing costs and saving weight), and optional EFIS avionics. Like the 450 the 500 will be certificated as spin resistant. The fuselage is made from composites while the wing and canard are aluminium.

On February 8 2002, AASI announced that it was taking over the Mooney assets, and that the name Mooney would be used for the combined companies. Headquarters, development, and marketing would remain at AASI''s facility at Long Beach in California, but production of the Jetcruzer would be at Mooney''s Kerrville, Texas plant.

The company is also working on the Stratocruzer 1250, a 13 place twin WilliamsRolls FJ-44 powered light corporate jet development.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('ATR ATR-72 ',57555312.0,'img/0112547-v40-6.jpg',' The ATR-72 is a stretched development of the popular ATR-42 and was launched in January 1986.

The first of three ATR-72 development aircraft flew for the first time on October 27 1988, followed by the awarding of French and then US certification in late 1989. Entry into service was on October 27 1989 with Kar Air of Finland. Some other early operators are Foshing Airlines, NFD (later Eurowings), CSA, American Eagle, TAT, Air Littoral, LOT, and Olympic Aviation.

Significant differences between the ATR-72 and the smaller and older ATR-42 include a 4.50m (14ft 9in) fuselage stretch and reworked wings. The ATR-72''s wings are new outboard of the engine nacelles and with 30% of it made up of composite materials, comprising composite spars and skin panels and a carbon fibre wing box.

Aside from the baseline ATR-72-200, two developments have been offered, the ATR-72-210, and the ATR-72-500 (previously ATR-72-210A). The ATR-72-210 is optimised for operations in hot and high conditions. It has more powerful PW-127 engines for better takeoff performance.

The ATR-72-500 (renamed from ATR-72-210A on May 18, 1998) further improved hot and high model was certificated in early 1997. It features PW-127Fs driving six blade composite Hamilton Sundstrand propellers.

The ATR-52C is an as yet unlaunched derivative with a redesigned tail to incorporate a rear loading ramp, intended for military and commercial operators. As with the ATR-42, a military maritime patrol version, known as the Petrel 72, has also been offered.

The ATR-72 would have formed the basis for the ATR-82, a 78 seat stretched development. The ATR-82 would have been powered by two Allison AE-2100 turboprops (ATR studied turbofans for a time) and would have a cruising speed as high as 610km/h (330kt). The ATR-82 was suspended when AI(R) was formed in early 1996.

 ',' France and Italy ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Antonov/PZL Mielec An-28 ',97090121.0,'img/0450084-v40-6.jpg',' The An-28 was the winner of a competition against the Beriev Be30 for a new light passenger and utility transport for Aeroflot''s short haul routes.

The An-28 is substantially derived from the earlier An14. Commonality with the An14 includes the high wing layout, twin fins and rudders, but it differs in having a new and far larger fuselage, plus turboprop engines. The original powerplant was the TVD850, but production versions are powered by the more powerful TVD10B.

The An-28 made its first flight as the An14M in September 1969 in the Ukraine. A subsequent preproduction aircraft first flew in April 1975. Production of the An-28 was then transferred to Poland''s PZL Mielec in 1978, although it was not until 1984 that the first Polish built production aircraft flew. The An-28''s Soviet type certificate was awarded in April 1986.

While of conventional design, one notable feature of the An-28 is that it will not stall, due to its automatic slots. An engine failure that would usually induce the wing to drop 30° is combated by an automatic spoiler forward of the aileron that opens on the opposite wing, restricting wing drop to 12° in five seconds.

PZL Mielec has been the sole source for production An-28s, and has developed a westernised version powered by 820kW (1100shp) Pratt & Whitney PT6A65B turboprops with five blade Hartzell propellers, plus some western (BendixKing) avionics. Designated the An-28PT, first flight was during early 1993 and it is in limited production. Marketed as the M28 Skytruck, the type received Polish certification equivalent to US FAR Part 23 in March 1996.

The An-28 was further developed into the stretched An-38.

 ',' Ukraine and Poland ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('ATR ATR-42 ',57555309.0,'img/0612709-v40-6.jpg',' Aerospatiale and Aeritalia (now Alenia) established Avions de Transport Regional as a Groupement d''IntÃ©ret Economique under French law to develop a family of regional airliners. The ATR-42 was the consortium''s first aircraft and was launched in October 1981.

The first of two ATR-42 prototypes flew for the first time on August 16 1984. Italian and French authorities granted certification in September 1985 and the first ATR-42 entered airline service on December 9 1985.

The initial ATR-42-300 was the standard production version of the ATR-42 family until 1996 and features greater payload range and a higher takeoff weight than the prototypes. The similar ATR-42-320 (also withdrawn in 1996) differed in having the more powerful PW-121 engines for better hot and high performance, while the ATR-42 Cargo is a quick change freight/passenger version of the 42-300.

The ATR-42-500 is the first significantly improved version of the aircraft and features a revised interior, more powerful PW-127Es for a substantially increased cruising speed (565km/h/305kt) driving six blade propellers, a 1850km (1000nm) maximum range, the EFIS cockpit, elevators and rudders of the stretched ATR-72 (described separately), plus new brakes and landing gear and strengthened wing and fuselage for higher weights. The first ATR-42-500 delivery was in October 1995.

ATR was part of Aero International (Regional), the regional airliner consortium established in January 1996 to incorporate ATR, Avro and Jetstream. AI(R) handled sales, marketing and support for both the ATRs, plus the Avro RJs and the Jetstream 41, until its disbandment in mid 1998 when ATR regained its independence.

In mid-2000, ATR launched a freighter conversion program for both the -42 and -72, involving installing a forward freight door and modifying the cabin for freight.  The ATR-42 Freighter can carry a 5.8 tonne payload.  DHL Aviation Africa was the launch customer with two converted ATR-42-300s redelivered in September and December, 2000. ',' France and Italy ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Auster J series ',37270974.0,' The Auster marque traces its lineage back to the Taylorcraft Aeroplanes (England) company, which produced Taylorcrafts under licence (described separately), and built over 1600 spotter (Air Observation Post) aircraft for Britain''s Royal Air Force and Army (many of which were resold to private operators).

The first civil Auster (as the company become known in 1946) was the Mk 5 J/1 Autocrat, which was essentially similar to the military Mk V, but had a Cirrus Minor 2 engine in place of the Mk 5''s Lycoming, upholstered seats and a small number of other refinements.

The J/1 Autocrat served as the basis for a family of civil aircraft. The next to appear was the two seat side by side J/2 Arrow family, with a 56kW (75hp) Continental, and was further developed into the J/4 Archer, which replaced the Continental with a Cirrus Minor engine. The J/1N Alpha was an attempt to increase sales and overcome the problems associated with fitting the Cirrus Minor engine to the J/1 with less equipment and minor improvements.

Most Auster J/5 models were four seaters except for the initial J/5 which was an Autocrat with a more powerful engine, while the J/5B incorporated the enlarged four seat cabin. The J/5F Aiglet trainer was a fully aerobatic two seat trainer. The J/5D, introduced in 1959, was the last of the line and featured metal wing spars and ribs and Lycoming power (more than 160 were built, including 150 in Portugal by OGMA under licence). Auster was taken over by Beagle in 1960.

 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Aviat A-1 Husky ',71610170.0,'img/0608513-v40-6.jpg',' The Aviat Husky utility has the distinction of being the only all new light aircraft designed and placed into series production in the United States in the mid to late 1980s.

Similar in configuration, appearance and mission to Piper''s venerable Super Cub, the Husky is a much later design, being first conceived in the mid 1980s. The Husky was originally designed by Christen Industries, the company also responsible for the kit built Christen Eagle aerobatic biplane and previous owner of the Pitts Special aerobatic biplane series (described separately, Aviat now owns Pitts and Christen).

Initial design work on the Husky began in late 1985, the aircraft being one of the few in its class designed with the benefit of Computer Aided Design. The prototype Husky flew for the first time in 1986, and the US FAA awarded certification the following year. Production deliveries followed shortly afterwards.

Design features of the Husky include a braced high wing, seating for two in tandem and dual controls. This high wing arrangement was selected for good all round visibility, essential for the many observation and patrol roles the Husky is suited for. Power is supplied by a relatively powerful, for the Husky''s weight, 135kW (180hp) Textron Lycoming O360 flat four turning a constant speed prop. The good power reserves and wing also give good field performance. Unlike most current light aircraft the Husky''s structure features steel tube frames and Dacron covering over all but the rear of the fuselage, plus metal leading edges on the wings.

Options include floats, skis and banner and glider hooks.

With more than 450 sold since production began, the Husky has also quietly gone about becoming one of the largest selling light aircraft GA designs of the 1990s. Many of the aircraft are used for observation duties, fisheries patrol, pipeline inspection, boarder patrol, glider towing and a range of other utility missions. Notable users include the US Departments of the Interior and Agriculture and the Kenya Wildlife Service which flies seven on aerial patrols of elephant herds as part of the fight against illegal ivory poaching.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Antonov/PZL Mielec An-2 ',39343960.0,'img/0552299-v40-6.jpg',' The An-2 was originally designed to meet a USSR Ministry of Agriculture and Forestry requirement, and flew for the first time on August 31 1947.

Entering production and service the following year, Antonov built An-2s were powered by 745kW (1000hp) ASh62 radials. Soviet production continued through to the mid sixties by which time a number of variants had been developed, including the base model An-2P, An-2S and 2M crop sprayers, An-2VA water bomber, An-2M floatplane and the An-2ZA high altitude meteorological research aircraft.

Production responsibility was transferred to Poland''s PZL Mielec in the 1960s, with the first example flying on October 23 1960. Aside from the An-2P, Polish versions include the An-2PK VIP transport, An-2PR for TV relay work, An-2S ambulance, An-2TD paratroop transport, An-2P cargo/passenger version, An-2 Geofiz geophysical survey version, passenger An-2T and An-2TP, and agricultural An-2R.

Chinese production as the Y5 commenced with Nanchang in 1957, before being transferred to the Shijiazhuang Aircraft Manufacturing Company. The main Chinese version is the standard Y5N, while the latest development is the Y5B specialist ag aircraft, which first flew in June 1989.

An Antonov built turboprop powered version, the An-3, flew in prototype form in the early 1980s powered by a 706kW (946shp) Omsk (Mars) TVD10, but did not enter production.

 ',' Ukraine and Poland ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Antonov An-38 ',63758512.0,'img/0728871-v40-6.jpg',' The An-38 is an all-new development of the earlier An-28, series production of which had been transferred to PZL-Mielec in Poland. During a sales tour of India in 1989 a requirement emerged for a larger 25-30 seat version of the An-28. Late 1990 this was approved by the Soviet Ministry of Transport. At the 1991 Paris Air Show a model was shown and details were made public for the first time. The aircraft is intended to replace An-24s, Let L-410s and Yak-40s.

As the An-28 was produced in Poland, and had to be paid in foreign currency after the break-up of the Soviet Union, payment in local currency was an added advantage for the development of the An-38.

The An-38 retains the basic wing and twin fin tail structure of the An-28, but has a stretched fuselage with three additional seat rows. New high efficiency Honeywell TPE331 or Omsk TVD-20 engines power the An-28. Many other improvements have been made such as improved sound and vibration insulation, reduced external noise, improved cockpit and passenger cabin comfort, payload, fuel efficiency and flight speed. The An-38 is equipped with a rear cargo door and a cargo-handling overhead-track hoist. The seats and the baggage compartment can be folded by the crew to provide a clear space for use as a cargo aircraft.

The fixed tricycle gear with low pressure tires enables operation from unpaved runways. The An-38 has weather radar and an integrated navigation system and can be operated by night and in adverse weather. It can be equipped with Western or CIS avionics.

Apart from passenger and cargo configuration, the multirole An-38 can also be equipped for forest patrol, aerial photography, survey, fishery patrol, ambulance, VIP transport and military airlift.

The first flight was made on June 23 1994 by the version with TPE331 engines, the An-38-100. The TVD-20 version, the An-38-200, followed on December 11 2001. Certification of the An-38-100 in compliance with AP-25 rules was granted April 22 1997. The An-38-200 was certificated on November 28 2002.

The An-38-110 is a -100 with a reduced avionics fit, the An-38-120 is a -100 with an enhanced avionics fit.

In December 1995 Antonov and NAPO (Novosibirsk Aircraft Production Association) established a joint venture company, Siberian Antonov Aircraft, to produce, market and provide after-sale support of the An-38. Series production of the An-38-100 aircraft is by NAPO.

Two prototypes (one at Antonov and one at NAPO) and a static test airframe were built. Vostok Airlines became the launch customer for the production aircraft and the first three were received by mid-1995. The An-38 also entered service with e.g. Layang Layang Aerospace in Malaysia, Alrosa-Avia in Russia, and Vietnam Air Services.







 ',' Ukraine ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Antonov An-72/74 ',95649515.0,'img/0420223-v40-6.jpg',' The An-72 was designed as a replacement for the An-26 tactical transport for the Soviet air force, but variants are in use as commercial freighters.

The first of five flying An-72 prototypes flew for the first time on August 31 1977, although it was not until much later in December 1985 that the first of eight extensively revised preproduction An-72s flew. Included in this pre series batch were two An-74s, differing from the An-72s in their ability to operate in harsh weather conditions in polar regions. Production of the An-72/74 family continues.

Versions of the An-72/74 family (NATO codename `Coaler'') include the An-72 base model with extended wings and fuselage compared to the prototypes, the An-72S VIP transport and An-72P maritime patrol aircraft.

Versions of the An-74 include the An-74A, the base An-74 model featuring the enlarged nose radome, the An-74T freighter, the An-74TK, 74TK100 and 74TK200 convertible passenger/freighter models, and the An-74P200D VIP transport.

The most significant design feature of the An-72 and An-74 is the use of the Coanda effect to improve STOL performance, which utilises engine exhaust gases blown over the wing''s upper surface to boost lift. Other features include multi slotted flaps, rear loading ramp and multi unit landing gear capable of operations from unprepared strips.

 ',' Ukraine ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Antonov An-24/26/30/32 & Xian Y-7 ',36520789.0, 'img/0088953-v40-6.jpg',' The An-24 is the original aircraft in a prolific and highly successful family of twin turboprop civil and military transports.

The An-24 first flew in April 1960 with first production versions entering Aeroflot service in September 1963. Aeroflot was the largest An-24 operator, with others going to Soviet client nations.

Subsequent production versions of the An-24 were the An-24B and the An-24T freighter. A small turbojet in the right engine nacelle to boost takeoff performance resulted in the An-24RT and An-24RV. The An-24P firebomber was also developed before Ukrainian production ceased in 1978.

The An-24 was also developed into the An-26 "Curl" military tactical transport with more powerful engines and redesigned tail, which itself evolved into the An-32 with enhancements for better hot and high performance. Over 550 An-26s are in civil service.

The An-30 development has been produced in limited numbers and is used largely for aerial survey and cartography work. This version is identifiable by its extensive nose glazing.

The An-32 first flew in 1976 and features much more powerful 3760kW (5042ehp) Progress engines for improved hot and high performance. The An-32 features above wing mounted engines to give the larger diameter props adequate ground clearance.

China''s Xian Aircraft Manufacturing Company is now the sole production source for the An-24 as the Y-7. The Y-7-100 incorporates a number of modifications including a revised passenger interior and flightdeck, and wingtip winglets. It was developed with the technical assistance of HAECO in Hong Kong during the 1980s.

 ',' Ukraine ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Antonov An-140 ',48114116.0,'img/0778218-v40-6.jpg',' Antonov''s An-140 is an all new 50 seat twin turboprop regional airliner developed to replace the ageing An-24.

Antonov announced development of the An-140 in 1993. The first An-140 prototype rolled out from the Kiev factory on June 6 1997 and flew for the first time on September 17 that year. The second flying prototype was completed in late 1998, while the first production standard An-140 flew on October 11 1999.

The An-140 is of conventional design and construction, with US and European certification planned in addition to Russian/CIS certification. The basic version is powered by Motor-Sich AI-30s which are licence built Klimov TV3-117VMA-SBM1s, while Pratt & Whitney Canada PW127As will be optional. The flightdeck features conventional instruments, the main cabin seats 52 in a four abreast configuration. The rear passenger door features integral stairs, while a forward starboard side freight door allows cargo to be carried. The rear of the cabin also features a galley, coat stowage and a toilet.

Production of the initial basic An-140 was superseded in 2003 by the An-140-100 which features a .00m (3ft 3in) increase in wing span, a higher MTOW and a 300km (160nm) longer range. Other future versions include the An-140A for Aeroflot which will be powered by PW127As, the An-140T freighter which would have a large freight door on the rear port side, the convertible An-140TK, the An-140VIP executive version, and the An-142 with a rear loading freight ramp. Military versions are also planned.

Series production of the An-140 is being undertaken at Kharkov by KhGAPP in Ukraine and at Samara in Russia by Aviacor. The first few aircraft were for Odessa Airlines, Aeromost (originally named Aeromist), Motor-Sich and Illich Avia.

In 1996 Antonov signed an agreement with HESA in Iran for licence assembly of an An-140 model called the IRAN-140 Faraz at a new plant in Esfahan. Initial IRAN-140s will be assembled from supplied kits, with gradually increasing Iranian local content. the first Faraz flew in February 2001. Iran Asseman and Iran Air are expected to be customers.


  ',' Ukraine ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Antonov An-22 Antei ',49685041.0,'img/0563141-v40-6.jpg',' The massive An-22 Antei (Antheus) is the largest turboprop powered aircraft yet built - it has a maximum takeoff weight similar to that of the Airbus A340-300 - and was designed in response to a largely military Soviet requirement for a strategic heavylift freighter.

The An-22 (NATO reporting name `Cock'') made its first flight on February 27 1965 - at that time it was comfortably the largest aircraft in the world. Production of the An-22 for the Soviet air force and Aeroflot continued through the 1960s until 1974.

The An-22 set 14 payload to height records in 1967, the pinnacle of which was the carriage of 100 tonnes (220,500lb) of metal blocks to an altitude of 25,748ft (7848m). It also established the record for a maximum payload lifted to a height of 2000m (6562ft), carrying a payload of 104,444kg (221,443lb). A number of class speed records were also set in 1972, including a speed of 608.5km/h (328kt) around a 1000km (540nm) circuit with a 50,000kg (110,250lb) payload. Further speed with payload records were established in 1974 and 1975.

As well as operations into the underdeveloped regions of Russia''s northeast, Siberia and Far East, Aeroflot An-22s were commonly used for military transport, their `civilian'' status allowing much freer access to landing and overflight rights.

Notable features of the An-22 include the NK12 turboprops - which also power the Tupolev Tu-95/Tu-142 Bear family of bombers and maritime patrol aircraft and are the most powerful turboprop engines in service - comprehensive navigation and precision drop avionics, and massive undercarriage and tailplane.

 ',' Ukraine ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Antonov An-124 Ruslan ',60691652.0,'img/0612942-v40-6.jpg',' For a time the massive An-124 held the mantle of the world''s largest aircraft before the arrival of the An-225, a stretched six engine derivative. It is commonly used for oversize freight charters.

Developed primarily as a strategic military freighter (in which role it can carry missile units and main battle tanks), the first prototype An-124 flew on December 26 1982. A second prototype, named Ruslan (after a Russian folk hero), made the type''s first western public appearance at the Paris Airshow in June 1985, preceding the type''s first commercial operations in January 1986. Since that time the An-124 has set a wide range of payload records, a recent achievement being the heaviest single load ever transported by air - a 124 tonne (273,400lb) powerplant generator and its associated weight spreading cradle, a total payload weight of 132.4 tonnes (291,940lb), set in late 1993.

Notable features include nose and tail cargo doors, 24 wheel undercarriage allowing operations from semi prepared strips, the ability to kneel to allow easier front loading, and flybywire control system.

The two major An-124 variants are the basic An-124 and similar Russian civil certificated An-124-100. Various upgrades have been proposed, including the western avionics equipped An-124-100M built in prototype form but not flown, the three crew EFIS flighdeck equipped An-124-102 and the An-124FFF firebomber.

Numerous reengine studies have also been conducted, including using Rolls-Royce RB-211-524Gs, General Electric CF680s (as the An-124-130) and even Aviadvigatel NK93 propfans.

The An-225 Mryia is based on the An-124 but features six (instead of four) D18T turbofans, a stretched fuselage and a 600 tonne (1,322,750lb) max takeoff weight. One was built, intended as a transport for the Russian Buran Space Shuttle equivalent. First flight was in 1988.

 ',' Ukraine ');
INSERT INTO product(productName, productPrice productDesc, productOrigin) VALUES ('Zlin Z 42, Z 43, Z 142, Z 242 & Z 143 ',23146417.0,' This series of two seat trainers and four seat light aircraft was initially developed to replacement for the successful Zlin Trener.

The initial Z 42 was developed during the mid 1960s and seats two side by side. It flew for the first time on October 17 1967. The improved Z 42M meanwhile introduced a constant speed propeller and the larger tail developed for the Z 43 four seater, and replaced the Z 42 in production in 1974.

Development of the two seat line continued with the further improved Z 142, which flew for the first time on December 29 1979. Changes introduced included a larger cockpit canopy and faired undercarriage. The Z 142 remained in production in Z 142C form to the mid 1990s. The latest two seater of this family to be developed is the 150kW (200hp) Textron Lycoming AEIO360 flat four powered Z 242 L. Changes aside from the engine include a three blade constant speed prop and revised engine cowling profile. First flight was on February 14 1990.

Development of the four seat models, the Z 43 and Z 143, has followed that of the two seaters. The Z 43 appeared a year later than the Z 42, flying for the first time on December 10 1968. The Z 42 and Z 43 share the same basic airframe, but differ in that the Z 43 features a larger and wider cabin with seating for four, and a more powerful engine. The current Z 143 L flew for the first time on April 24 1992, and is similar in structure to the Z 242, but again differs in having a larger cabin with seating for four and a more powerful Textron Lycoming O-540 engine.

 ',' Czech Republic ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Yakovlev Yak-42 ',87841403.0,'img/0097777-v40-6.jpg',' The Yak-42 trijet was developed as a replacement for Tupolev''s Tu-134 twinjet and Antonov''s An-24 turboprop.

The Yak-42 is an all new design although, like the Yak-40, it features a three engine configuration for increased redundancy and good short field performance. A moderately swept wing was a compromise between the need for good field performance and high speed cruise capabilities. An integral airstair, APU and double main undercarriage are all incorporated into the Yak-42 design for austere airfield operations. The Lotarev turbofan meanwhile was one of the first true turbofans to be developed in the Soviet Union.

The first of three prototypes flew on March 7 1975. Development flying revealed the need for increased wing sweep back, and the change of wing sweep angle and suspected development problems with the new three shaft turbofans delayed service entry to late 1980.

Most production was of the initial Yak-42. The Yak-42D was introduced in 1989 and became the standard production model. It features increased fuel capacity, taking range with 120 passengers to 2200km (1185nm).

The Yak-42T is a freighter design study. It would be fitted with a main deck freight door, and capacity would be 12 tonnes.

The Yak-42D-100 meanwhile is a development with a four screen AlliedSignal EFIS cockpit among other improvements. One was displayed at the 1993 Paris Salon (as the Yak-142). A VIP/corporate jet development is also offered.

The Yak242 was an all new design study with the Yak-42''s cross section, two PS90A turbofans and seating for up to 180.

 ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Yakovlev Yak-18T ',92452701.0,'img/1179236-v40-6.jpg',' One of the very few four seat light aircraft to be built in the Soviet Union during the Cold War years, the rugged Yak-18T has its basis in the Yak-18 series of two seat trainers.

The Yak-18 first flew in 1946 and went on to be built in massive numbers (including more than 8000 for the Soviet air force which used it as its standard military basic trainer for many decades). Most production was of the Yak-18A. Several single seat models were built for competition aerobatics, including the Yak-18P, Yak-18PM and Yak-18PS. Many have since appeared in the west.

The four seat Yak-18T was the last production model, and the most extensively modified. Compared with the single and two seat Yak-18 models, the Yak-18T introduced a much enlarged cabin with seating for four, tricycle undercarriage (single seat Yak-18PMs had tricycle undercarriage also), plus the 265kW (355hp) Vedneyev (now VOKBM) M14 nine cylinder radial engine.

First flight occurred in mid 1967 and the Yak-18T was then subsequently placed in series production in Smolensk. The Yak-18T went on to become the standard basic trainer with Aeroflot flight schools, while small numbers also entered service with the Soviet air force as liaison and communications aircraft. After approximately 200 were built, mainly for Aeroflot, production ceased in the late 1980s.

In 1993 the Smolensk Aircraft Factory placed the -18T back into production against a number of new contracts, including 20 for the Philippines air force. Several Yak-18Ts have also found their way into the west.

Meanwhile Technoavia offers its own development of the Yak-18T, the SM94, but production is dependant on orders being placed.

Compared with western four seat light aircraft, the Yak-18T is much larger, heavier and less economic to operate with a far more powerful engine, although it was never intended for private pilot operation. Its strong construction and military background has given it an aerobatic capability, while its general handling characteristics are docile.

 ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Aviation Traders ATL-98 Carvair ',39426097.0,'img/0094415-v40-6.jpg',' Aviation Traders developed the Carvair in response to Channel Air Bridge''s requirement for an air ferry capable of transporting passengers and their cars between the United Kingdom and continental Europe.

Although its external appearance is quite different, the Carvair is a conversion of the Douglas DC-4 airliner (or C-54 Skymaster in military guise), large numbers of which were available after World War 2. The airframe from the wings rearward is that of a standard DC-4, except for a lengthened vertical tail for enhanced controllability. The major modifications performed on the forward fuselage centred on a new lengthened nose section with a hydraulically operated cargo door and an elevated flightdeck (similar in appearance to that which would appear on the Boeing 747 several years later) which allowed nose loading for cars.

First flight of the Carvair conversion was on June 21 1961, the type subsequently entering service with British United Air Ferries (into which Channel Air Bridge had been merged, it later became British Air Ferries and was known as British World Airways, which ceased trading in December 2001) in March 1962. Deliveries to other operators included three for Aer Lingus of Ireland and two for Aviaco of Spain, with other aircraft operated by French, Australian and Luxembourg carriers.

Aviation Traders also proposed a Carvair type conversion of the Douglas DC-6, DC-6B and DC-7, with the option of reengining with RollsRoyce Dart turboprops, although these plans were never carried through.

In 1998 one Carvair was operated by Hawkair Aviation in British Colombia, Canada, registered C-GAAH. Another operates from Bear Creek/Tara Field in Georgia in the USA, while a third is stored in South Africa. All are ex Ansett machines.

 ',' United Kingdom ');

INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Antonov An-225 Mriya ',6285460.0,'img/0568023-v40-6.jpg',' Antonov An-225 "Mriya" is the world''s largest aircraft. When it was built, it surpassed any airliner built before by 50%.  It was designed for the transportation of the Russian Space Shuttle "Buran" by the Antonov Design Bureau (HQ in Kiev, Ukraine), which already had built good and large cargo aircraft such as the Antonov An-124 "Ruslan". The basic configuration of the An-225  is the same as the An-124, except the An-225 is longer, has no rear ramp/door assembly, and incorporates a 32-wheel landing gear system (two nose and fourteen main wheel bogies, seven per side, each with two wheels).

An-225 "Mriya" ("Mriya" is Ukrainian word for "dream) is also capable to transport other oversized objects/cargo. It is not a military aircraft, but it could find many military uses, because of the ability to transport cargo that no other aircraft is capable to.

The plane had the first flight in early 1988 and entered service in 1989. It''s first flight took 75 minutes. After the cancellation of the Buran space program, the only An-225 built was stored in spring 1994, and it''s engines were used for An-124s. In 2001 the aircraft was made airworthy again, and made it''s new first flight on May 7. There were rumors that the European Space Agency had plans to launch the unmanned British HoTOL (Horizontal Take-Off and Landing) from the An-225, though these rumors appear to be unfounded. Although, some possibilities for deployment have already been found. Plenty of customers are to be found in the USA. According to Bruce Bird, Director of the Charter Division of Air Foyle, parts of rocket launchers like the Delta and Atlas could be transported in the An-225. Lockheed''s planned Venture Star could be transported on its back. Additionally the Mrija could serve as a launch platform for the X-34B. Furthermore big sections of aircraft could be transported in it. The complete assembled fuselage of a Boeing 737 can be fitted in the hold.

A second An-225 was partly built, but was stored before it was finished.  It is possible that more aircraft of the type will be built, depending on market demand. ',' Ukraine ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Zlin Trener & Akrobat ',1620190.0,'img/0186046-v40-6.jpg',' The renowned Zlin series of two seat Trener trainers and single seat Akrobat aerobatic aircraft was a great success, winning numerous world aerobatic championship titles during the 1960s.

The original Z 26 Trener was designed in response to a Czechoslovak government requirement for a two seat basic trainer for flying school and military use. The Z 26 was powered by a 78kW (105hp) Walter Minor 4III inline four cylinder engine, featured wooden construction and a fixed taildragger undercarriage. The prototype flew for the first time in 1947 and 16 production Z 26s were built before it was replaced from 1953 by the metal construction Z 126.

Development over a three decade production run resulted in numerous further improved variants. In 1952 Zlin introduced the Z 226 Trener6 which featured a more powerful 120kW (160hp) six cylinder Walter Minor 6III engine. The Z 226 was also built in single seat Z 226A Akrobat, glider tug Z 226B and Z 226T trainer forms.

The similar Z 326 TrenerMaster and single seat Z 326A Akrobat introduced retractable undercarriage, a feature that became standard on all subsequent models. Deliveries began in 1959. The Z 526 differed in that the pilot flew the aircraft from the rear, rather than the front seat, with optional tip tanks and a constant speed prop. The Z 526F introduced in 1968 had a 135kW (180hp) Avia M 137A engine, the otherwise similar Z 526L differed in being powered by a 150kW (200hp) Lycoming AIO360 flat four and was intended for export.

Single seat Z 526s were the Z 526A, Z 526AS, and Z 526AFS.

The Z 526 AFM was built between 1981 and 1984 and was powered by a 155kW (210hp) Avia M337 engine, had tip tanks and the Z 526AFS''s lengthened fuselage.

Final development was the Z 726 series, the Z 726 Universal had reduced span wing, the Z 726K a 155kW (210hp) Avia M 337 engine.

 ',' Czech Republic ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Weatherly 201/620 ',3671734.0,'img/0191119-v40-6.jpg',' The Weatherly 201 and 620 agricultural aircraft were built in relatively small numbers from the late 1960s.
The Weatherly 201 and its successors date back to the Weatherly WM-62C agricultural aircraft, 19 of which were built between January 1961 and late 1965. The WM-62s were agricultural conversions of the basic Fairchild M-62 airframe, fitted with a chemical hopper, spray booms and either a Wright W-670 or Pratt & Whitney R-985 radial engine.
Weatherly used its experience in designing and converting the WM-62s in developing its own agricultural aircraft design. The resulting Model 201 was a larger aircraft overall of conventional ag aircraft configuration, with a low wing, a Pratt & Whitney R-985 radial, integral chemical hopper and spray booms and an enclosed cockpit for the pilot. The initial production 201, the 201A, was certificated in 1967, followed by the 201B, and the improved 201C was granted its type certificate in 1975. A unique feature was the use of wingtip vanes which were developed to increase the effective swath width, while reducing the amount of chemicals lost from the spraying swath (they could be folded back beneath the wings for hangar storage.
The Model 620 replaced the 201C in production from 1980. The 620 featured a longer span wing with optional wingtip vanes and a larger chemical hopper, but the same R-985 engine. The 620A had a 65USgal fuel capacity, the 620B had a 4in stretched fuselage to give a 88USgal capacity.
The Pratt & Whitney Canada PT6A-11AG turboprop powered 620TP joined the 620 in production in 1980, and featured a longer nose and a slightly larger chemical hopper. This 620TP was available as the 620A-TP and 620B-TP.
The 620B-TP was replaced by the 620B-TG which is powered by a 496kW (665shp) Honeywell TPE331-1 turboprop. The 620B and 620B-TG are still in low-rate production.
 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Yakovlev Yak-40 ',87841403.0,'img/0219227-v40-6.jpg',' The Yak-40 was the first jet powered airliner in its class in service in large numbers anywhere in the world, preceding the ERJ-135 and 328JET by three decades.

Design of the Yak-40 resulted from a mid 1960s Aeroflot requirement for a replacement for the thousands of Lisunov Li-2s (Soviet built DC-3s), Ilyushin Il-12s and Il-14s (described separately) then in service. Aeroflot attached great significance to the Yak-40 program, as the aircraft was intended to operate regional services that accounted for 50% of Aeroflot''s passenger traffic.

A S Yakovlev (after whom the design bureau is named) led the Yak-40 design team, and the program''s existence was revealed on October 21 1966, when the first prototype made its maiden flight. The type went into production in 1967 and entered service with Aeroflot in September 1968. Production continued until 1978, with 1011 built by the Saratov aircraft factory, of which 125 aircraft were exported to 18 countries.


The Yak-40''s most noticeable design feature is its trijet configuration, with three specially developed Ivchenko AI-25 two shaft turbofans. The three jet engine layout was chosen for increased redundancy (and hence better one engine out performance, allowing good short field performance). The unswept, high aspect ratio wing is also designed for good field performance. An APU and a ventral airstair in the rear fuselage allow autonomous operation at remote airfields. A high power-to-weight ratio allows the Yak-40 a good hot-and-high performance - operating economics was a lesser priority.


The Yak-40 remained basically unchanged during its production life, but a number of developments were proposed, including the Yak-40M, a 40 seat stretched development. For a time a US company, ICX Aviation, planned to build the type in the USA with western avionics and three Garrett TFE731 turbofans. The Yak-40TL twin engine conversion was also proposed. The main difference would have been the replacement of the Yak-40''s three engines with two Lycoming LF 507s.

The Yak-40K is a cargo-passenger version with a port-side forward cargo door with a maximum payload of 3200kg (7055lb) in all freight configuration.

The Yak-40D has two additional fuel tanks to increase the total fuel capacity to 6000kg (13,200lb). The Yak-40DTS is a troop carrier and paramedic configuration. Other versions are equipped for calibration, meteorological research, testing and inspecting of radio-electronic equipment, and for use as an engine testbed.

Apart from airliner use, a number are in service as corporate or government transports with a VIP interior.


 ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Victa Airtourer ',50863276.0,'img/0207714-v40-6.jpg',' The popular Airtourer was designed by Australian Dr Henry Millicer (chief aerodynamicist of Australia''s Government Aircraft Factory) in response to a Royal Aero Club (in the UK) sponsored Light Aircraft Design competition.

Millicer''s design won the competition, and the Ultra Light Aircraft Association of Australia formed the Air Tourer Group to build a 50kW (65hp) Continental powered wooden prototype of the design, which first flew on March 31 1959.

The wooden prototype aroused the interest of Victa (a company more known for its lawnmowers), who in 1960 decided to commercially design and produce the Airtourer series in Australia. Victa''s first all metal prototype of the Airtourer first flew on December 12 1961, powered by a 70kW (95hp) engine. Production aircraft were powered by a 75kW (100hp) Continental engine, and the first production Airtourer 100 flew in June 1962. Type approval was awarded the following month. The more powerful Airtourer 115 flew for the first time in September 1962, powered by a Lycoming O-235.

Victa built 170 production Airtourers before its inability to compete against cheap American imports (which were aided by a favourable exchange rate) which were swamping the Australian market forced production to end. Plans to build the four seat Aircruiser development (described under Millicer) were dropped.

However New Zealand''s AESL (Aero Engine Services Ltd) purchased the Airtourer design and production rights in early 1967. AESL (later NZAI and now PAC) built the Airtourer 115, the more powerful 110kW (150hp) model Airtourer 150, and constant speed prop fitted Super 150. Later the 115 became the T2, the 150 the T4 and the Super 150 the T5. The T3 was powered by a 95kW (130hp) RR Continental O-240, while the T6 was a militarised version based on the T5 built for New Zealand. NZAI production ceased in 1974.

In December 1997 Australia''s Millicer Aircraft Industries purchased the Airtourer''s production rights and it plans to deliver new build M-10-140 and M-10-160 Airtourers from 1999. The Millicer Airtourer is described separately.

 ',' Australia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Vickers Viscount ',37250710.0,'img/0556710-v40-6.jpg',' Vicker''s Viscount was the first turboprop airliner from any nation to enter service.

The Viscount was one of the results of the UK''s wartime Brabazon Committee, which was set up to define requirements for British postwar commercial aircraft. Discussions between the committee and Vickers designers in late 1944, who had already been working on the VC-1 Viking airliner development of the Wellington bomber, resulted in what was eventually to become the Viscount. The committee''s requirement was for a 24 seat 1000 mile (1600km/868nm) range airliner, and by the end of 1945 Vickers had selected the Rolls-Royce Dart turboprop engine that was then under development to power the new aircraft.

In March 1946 the British government placed a contract with Vickers to build two prototypes of its design (then called Viceroy), one powered by Darts, the other by Armstrong Siddeley Mamba turboprops. By the time of the Dart powered prototype''s first flight on July 16 1948 the design had grown to seat 34 and was designated Type 630. The second prototype, the Type 663, was powered by two Rolls-Royce Tay jet engines. Airline indifference to the 34 seat Viscount and the availability of more powerful Dart variants however led Vickers to stretch the design to seat 40. This development was designated the Type 700, and first flew on April 19 1950.

Airline interest in the Viscount 700 was much stronger, and after receiving certification on April 17 1953 it entered service with BEA the following day. The Viscount was the subject of numerous large orders including from North America, its smoothness, good operating economics and pressurisation contributing to its success.

Capitalising on the 700''s success Vickers developed the stretched 800 with seating for up to 69, while the final Viscount development was the 810 with more powerful engines and higher weights.

 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Victa Aircruiser ',15736178.0,' The Victa Aircruiser was designed by Dr Henry Millicer, who had earlier designed the two seat Victa Airtourer (described separately), the most popular light aircraft designed and built in Australia. With Airtourer production in full swing in the early 1960s Victa commissioned Dr Millicer to develop a four seat light aircraft based on the Airtourer. This resulted in the Aircruiser 210CS, which flew for the first time on July 17 1966. The Aircruiser was later awarded full Australian certification equivalent to US FAR Part 23 standards.

The Aircruiser showed considerable promise and looked a worthy competitor to American four seaters, however Victa withdrew from light aircraft production in January 1967 due to the Airtourer''s inability to compete on price against alleged dumped imports to Australia, and the design and production rights to the Airtourer and Aircruiser were sold to AESL of New Zealand in 1970. AESL continued to build the Airtourer and used the Aircruiser as the basis for its CT-4 Airtrainer (described separately) but did not put the Aircruiser into production.

In 1994 Tony Peters, a flying school proprietor in Mount Gambier in South Australia, commissioned a market study into two and four seat light aircraft demand in Australia which found there existed a significant market for new aircraft. A syndicate was formed to purchase the Aircruiser design and type certificate, with Millicer Aircraft Industries established to place an upgraded development of the Aircruiser into production as the M-9-200 Shrike. The Shrike name was dropped in 1998 in favour of AirCruiser (with an upper case "C").

Originally plans envisaged the first M-9-200 being delivered in mid 1997 but minor delays and the decision to acquire the Airtourer design and place it into production as a priority meant that the first M-9-200 - the rebuilt Aircruiser prototype - was not due to fly until September 1999 with first customer deliveries planned for 2000. AirCruisers and AirTourers would be built in a new, purpose designed factory in Sale in Victoria.

Compared with the original Victa Aircruiser, the M-9-200 AirCruiser would have featured a fuel injected IO-360 engine, standard GPS, new wheels, brakes and controls. A retractable undercarriage variant was also planned.

However, in late 2000 Millicer ceased trading due to financial difficulties, before the M-9-200 had been flown. So, to the present day, only one Aircruiser was built.




 ',' Australia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Tupolev Tu-154 ',6528099.0,'img/0254805-v40-6.jpg',' Tupolev''s Tu-154 tri-jet remains the standard medium range airliner on domestic flights in Russia and other states of the former Soviet Union and to a lesser extent in eastern Europe and Iran.

The Tu-154 was developed to replace the turbojet powered Tupolev Tu-104, plus the An-10 and Il-18 turboprops. Design criteria in replacing these three relatively diverse aircraft included the ability to operate from gravel or packed earth airfields, to be able to fly at high altitudes above most Soviet Union air traffic, and good field performance. To meet these aims the initial Tu-154 design featured three Kuznetsov (now KKBM) NK-8 turbofans (which also powered the larger, longer range Il-62) giving a relatively good thrust to weight ratio, triple bogie main undercarriage units which retract into wing pods and a rear engine T-tail configuration.

The Tu-154 first flew on October 4 1968. The first production example was delivered to Aeroflot in early 1971, although regular commercial service did not begin until February 1972.

Three Kuznetsov powered variants of the Tu-154 were built, the initial Tu-154, the improved Tu-154A with more powerful engines and a higher max takeoff weight, and the Tu-154B with a further increased max takeoff weight. Tu-154S is a freighter version of the Tu-154B.

Current production is of the Tu-154M, which first flew in 1982. The major change introduced on the M was the far more economical, quieter and reliable Soloviev (now Aviadvigatel) turbofans. Low rate production continues. Meanwhile the proposed Tu-154M-2 with two PS-90A turbofans remains unbuilt.

 ',' Russia ');

INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Tupolev Tu-134 ',6528097.0,'img/0113295-v40-6.jpg',' For many years the Tupolev Tu-134 was the standard short haul jet airliner in the Soviet Union and eastern Europe.

The Tupolev design bureau was responsible for the Soviet Union''s first jet powered airliner, the Tu-104 (which was based on the Tu-16 `Badger'' bomber), and the Tu-104''s smaller brother the Tu-124. Both of these short range jetliners suffered from a number of performance shortfalls however, thus prompting development of the Tu-134.

The initial Tu-134 design was based fairly closely on the Tu-124, and for a time was designated the Tu-124A. However Tupolev decided to reconfigure the aircraft to feature rear fuselage mounted engines and a Ttail, resulting in the new designation.

Six development Tu-134s were built, with the first flying during 1962. Production began in 1964 although it was not until September 1967 that Aeroflot launched full commercial services.

Initial production was of the standard fuselage length Tu-134, while the stretched Tu-134A entered Aeroflot service in the second half of 1970. Seating up to 76 in a single class, the Tu-134A differed from the Tu-134 in having a 2.10m (6ft 11in) fuselage stretch, a reprofiled nose, more powerful D30 engines and an APU.

Other versions are the Tu-134B with a forward facing position for the third crew member between and behind the pilots, the Tu-134B1 which has a revised interior to seat up to 90 passengers without a galley, and the Tu-134B3 which can seat 96 with full galley and toilet facilities retained.

 ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Technoavia SM92 Finist ',68942317.0,'img/0112718-v40-6.jpg',' The Technoavia Finist is a STOL piston powered utility transport similar in concept to the venerable DHC2 Beaver, and is one of the first Russian aircraft designed from the ground up to meet western (both FAA and JAA) certification requirements. <p>The Finist (named after a small Russian bird) is the first product of the Technoavia Design Bureau. Technoavia was established in 1991 by Slava Kondratiev, a renowned Russian designer responsible for the world beating Sukhoi Su26, Su29 and Su31 series of aerobatic aircraft. Kondratiev provided finance for the new company by purchasing the rights and placing into production the four seat Yak-18T light aircraft (described separately). <p>The Finist is one of a diverse range of designs from Russian studios aimed at meeting worldwide requirements for a utility transport, but unlike most of its contemporaries it has flown and is in low rate production. The big yet elegant high wing aircraft features perhaps the best radial engine currently in production, the M14P, which also powers the Sukhoi aerobatic aircraft. The design features a high aspect ratio (10.5) wing with Fowler flaps and Frise ailerons, a large main cabin door on the left side and faired steel main landing gear units. Skis and floats will be offered as options. <p>The prototype Finist first flew on December 28 1993, while production deliveries began in January 1995. Technoavia is studying further developments of the basic aircraft, primarily a Pratt & Whitney Canada PT6 turbine powered model. <p>The SM-92P is an armed version ordered by the Russian border guards. Up to 300 may be required. <p>Like the much older and out of production Beaver, the Finist is aimed at performing a wide variety of STOL utility missions, and with western certification behind it, it may become a realistic prospect for replacing the world''s ageing fleet of utility GA aircraft. <p> ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Tupolev Tu-334 ',6528117.0,'img/0045273-v40-6.jpg',' The advanced technology Tu-334 100 seat jet was developed as a replacement for the aging Tu-134.

Development of a replacement for the Tu-134 began in the late 1980s, but it was not until August 1995 at the Moscow Airshow that the first prototype was displayed publicly. The aircraft made its first flight on December 8, 1999.

The Tu-334 was based on the much larger Tu-204 twinjet with Tupolev using as many Tu-204 features in the new design as practical to reduce development time and costs. Examples of this include an identical flightdeck and a shortened Tu-204 fuselage. In addition the Tu-334''s wing is based on the Tu-204''s, although the latter''s is a significantly larger unit.

Apart from commonality with the Tu-204, other notable Tu-334 design features were the rear fuselage mounted Progress D-436 turbofans, T-tail and fly-by-wire flight controls.

It was planned that the Tu-334 would be developed in a number of versions. The first was the basic Tu-334-100, while the Tu-334-120 was planned to be powered by the BMW Rolls-Royce BR710-48. The Tu-354 (previously Tu-334-200) would have been a stretched, 35m (115ft) long 110 to 126 seater (in a single class). Apart from the fuselage stretch, planned changes included more powerful D436T2 or BR715-55 turbofans, an increased span wing and four wheel main undercarriage units.

The Tu-334-100D would have been a longer range Tu-334-100 featuring the 100''s standard length fuselage but with more powerful engines, increased fuel capacity, a higher max takeoff weight and the increased span wings of the Tu-334-200. Tupolev also studied the Tu-334C, which would have been a freighter.

Development of the Tu-334 remained slow due to protracted budget problems and there were numerous delays.  Eventually, in 2009, after the rationalization of the Russian aviation industry, the TU-334 program was cancelled in favor of the Antonov An-148 and the Sukhoi Superjet 100.

 ',' Russia ');

INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Sukhoi Superjet 100 ',81616338.0,'img/2075758-v40-6.jpg',' The Superjet 100 design was launched in 2000, with the aim being to produce a modern regional airliner for the traditional Eastern European/CIS markets. It is also intended to be attractive to Western customers due to lower purchase and operating costs than competing Western designs, but with the required safety and performance features that were often perceived as lacking in older  designs from the Soviet era, preventing sales to that market.

Sukhoi worked with new partners, notably including Boeing, as they developed the aircraft for the post-Cold War airline environment. The aircraft that emerged is modern and targeted to compete with close competitors such as the Embraer ERJ-190/195 and Bombardier designs, as well as the smaller Airbus and Boeing designs such as the A318 and 737-600.

Development was more protracted than expected, but successful, with the first of four prototypes flying on 19 May 2008. Certification was reasonably  straightforward, with a few problems requiring attention, particularly with the new engines.

Customer deliveries began in 2011 when Armenian airline Armavia took delivery of the first production aircraft, with Aeroflot taking its first aircraft later the same year.  ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Sud SE-210 Caravelle ',73464407.0,'img/0335475-v40-6.jpg',' The Caravelle was the first jet airliner to enter production in continental Europe and pioneered the rear mounted engine layout.

The Caravelle was designed in response to a French Secretariat General of Commercial and Civil Aviation requirement for a 1600 to 2000km (865 to 1080nm) range airliner (allowing operations between France and its North African dependents) with a 6000 to 7000kg (13,228 to 15,432lb) payload requirement at a speed of 620km/h (335kt). SNCASE (Societe Nationale de Constructions Aeronautiques de Sud-Est, later Sud Aviation, and subsequently merged into Aerospatiale), responded with a trijet design designated the X120, with three rear mounted SNECMA Atar turbojets. This design then matured to feature two rear mounted Rolls-Royce Avons.

The French government ordered two flying and two static prototypes of the twinjet in 1953, resulting in the type''s first flight on May 27 1955. Entry into service of the SE-210 Caravelle I with Air France was on May 12 1959 on the Paris/Rome/Istanbul route.

The Caravelle III featured 50.7kN (11,400lb) Avon RA.29 Mk527s (one Caravelle III was powered by General Electric CJ805-23C turbofans, but production never eventuated). The 54.3kN (12,200lb) Avon RA.29 Mk531 powered VI-N and the VI-R with a modified windscreen and thrust reversers followed.

The Caravelle 10B introduced more fuel efficient Pratt & Whitney JT8D turbofans, while the 11R was a convertible passenger/freighter based on the 10. The ultimate Caravelle model was the 3.20m (10ft 6in) stretched Caravelle. It could seat up to 128 single class passengers.

 ',' France ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Socata TBM-700 ',45966402.0,'img/0242768-v40-6.jpg',' The TBM-700 is a high performance single engine turboprop powered light business and corporate transport.

The TBM-700 is mainly optimised as a business transport in competition with established twin turboprops, mainly Beech''s C90 King Air series. Unlike the similarly sized C90 King Airs though, the TBM-700''s single engine layout is a major conceptual difference. With its single PT6 turboprop, rather than two on the King Air, the TBM-700 offers significantly lower operating costs yet comparable performance.

The TBM-700 was originally developed in partnership between Socata (Aerospatiale''s General Aviation division) in France and Mooney in the USA, hence the TBM designation. The two companies formed TBM SA to build and market the TBM-700, with development responsibility for the project divided on a 70/30 basis between Socata and Mooney respectively.

The first of three TBM-700 prototypes first flew on July 14 1988. French certification was granted in January 1990. Shortly after the delivery of the first production aircraft in December 1990, Mooney withdrew from the program, leaving Socata with full responsibility for the aircraft.

The pressurised TBM-700 is of conventional design and construction, with a small amount of composite materials used in some areas. Flight controls, flaps and most of the empennage and fin are made from Nomex honeycomb and metal sheets. Leading edges and undercarriage doors meanwhile are made from a carbon and fibreglass composite. Entry to the cabin is through a split upward/downward opening door in the rear port fuselage.

Apart from the base aircraft the TBM-700 is offered as the TBM-700C freighter with a freight door and separate port side cockpit door. Development of the stretched TBM-700S ceased in 1995.







 ',' France ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Socata Tangara & Gulfstream GA7 ',32476355.0,' The GA7 Cougar light twin saw limited production with Gulfstream in the late 1970s and has re-emerged to enter production with France''s Socata as the TB 360 Tangara. <p>The GA-7 prototype first flew on December 20 1974, but three years passed before production began. By this time Grumman''s light aircraft lines had been acquired by Gulfstream, who delivered production GA7s from February 1978. <p>The GA7 design featured two 120kW (160hp) Lycoming O320s and the bonded honeycomb construction used on the Grumman AA1 and AA5. The initial GA7 design featured a sliding cockpit canopy and two cabin windows per side. Changes for production aircraft included the adoption of a conventional cabin roof enclosing an enlarged cabin with an entry door on the right hand side. The prototype''s single spar wing design was changed to a twin spar design allowing an integral wet wing fuel tank, and on production GA-7s the main undercarriage units retracted outwards, rather than inwards. <p>Gulfstream built two basic variants, the standard GA7 and the GA7 Cougar with a more comprehensive avionics fit and improved interior fittings. However sales of both aircraft were slow, in part because of the GA7''s relatively low combined power output of 240kW (320hp). Production ceased in 1979 with Gulfstream''s departure from light aircraft manufacture. <p>In 1995 Socata purchased the rights to the GA7 with the intention of placing it back into production as the TB 320 Tangara. In June 1996 Socata announced its plans to redevelop the aircraft as the TB 360 Tangara with 135kW (180hp) O-360s. <p>Three modified GA-7s have flown as Tangara prototypes so far, the first had a 120kW (160hp) and a 135kW (180hp) engine and flew in mid 1996, the third, which first flew in February 1997 was in full TB 360 configuration. Production has been postponed to 1999. <p>Socata is pitching the TB 360 at the light twin trainer market. <p> ',' United States of America and France ');

INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('VisionAire Vantage ',90246835.0,' The innovative Vantage is an all new single engine entry level corporate jet, designed to compete against the CitationJet and TBM 700 turboprop. <p>Self flying businessman James O Rice Jr established VisionAire in St Louis in 1988 after deciding that there existed a significant market for a low cost entry level business jet. Design aims with the new jet include jet comfort and altitude, good short field performance, a large cabin and low acquisition and operating costs. <p>The Vantage was designed by VisionAire with the assistance of Scaled Composites (whose president is Burt Rutan), with the aircraft''s definitive arrangement settled upon in 1993. In February 1996 VisionAire contracted Scaled Composites to design and build a proof of concept prototype, and this aircraft was rolled out from the latter''s Mojave, California facility on November 8 1996. <p>This aircraft successfully flew for the first time on November 16 1996 and it was used to demonstrate performance and handling characteristics before a production configuration was settled upon. VisionAire now aims to achieve certification for the Vantage in 2000. Scaled Composites will build Vantage''s wing and vertical and horizontal stabilisers at VisionAire''s new Ames, Iowa production facility where final assembly will be undertaken. AAR of Florida has been contracted to build production forward and rear fuselages. <p>The Vantage''s most notable feature is its single JT15D turbofan engine, which is buried in the rear fuselage and fed by two air inlets on either side of the fuselage. The JT15D has been in operation since 1982 on the Beechjet 400 and Citation V, and VisionAire says the proven in service engine would have a shutdown rate per aircraft of once every 250 to 500 years if flown 500 hours per annum. Other notable features include the mid fuselage mounted forward swept wing of relatively large area and graphite composite airframe. It will be certificated to FAR Part 23 Amendment 51. <p> ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Tupolev Tu-204 & Tu-214 ',37331774.0,'img/0098493-v40-6.jpg',' The Tupolev Tu-204 is a medium range narrowbody twinjet and was the first Russian airliner to fly with western engines.

Tupolev began development of the Tu-204 to meet an Aeroflot requirement for a replacement for the medium range Tu-154 trijet. This all new twin featured a supercritical wing, while engine designer Soloviev (now Aviadvigatel) specifically developed the PS-90 turbofan. Other Tu-204 design features include fly-by-wire and a six screen EFIS flightdeck. First flight was on January 2, 1989.

The Tu-204 is offered in a number of models. The base model is the Tu-204, while the Tu-204-100 and -200 have higher max takeoff weights, more fuel and greater range. The Tu-204C and Tu-204-100C are freighters fitted with a forward main deck freight door.  The Tu-214, Tu-214C combi convertible model, and Tu-214C freighter are manufactured in Kazan.

Tupolev was keen to develop a westernised development of the Tu-204 to broaden the type''s market appeal, resulting in the RollsRoyce RB211-535 powered Tu-204-120, which first flew on August 14, 1992. All but the first five feature Honeywell''s VIA 2000 EFIS avionics suite.

Rolls-Royce powered variants include the Tu-204-120C freighter, increased weight -220 and equivalent cargo -220C, and the -222 with Collins avionics. Air Cairo of Egypt became the launch operator when it took delivery of a Tu-204-120 and -120C in November 1998.

Tupolev also developed two developments of the shortened 166-seater Tu-204-300, an RB211-535E4 powered model and a 158kN (35,580lb) PS90P powered model (also known as the Tu-234). The Tu-204-300 prototype (converted from the Tu-204 prototype) was publicly displayed at the 1995 Moscow Airshow.

Other proposed developments include a Pratt & Whitney PW2240 powered model, a business jet and a maritime patrol platform.

 ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Sukhoi Su26, Su29 & Su31 ',75710146.0,'img/0177802-v40-6.jpg',' Sukhoi''s highly regarded aerobatic aircraft have won numerous international aerobatic events.

Sukhoi is perhaps better known as one of the two preeminent Russian high performance combat aircraft designers, but it turned its attention to design and flying a single seat aircraft for unlimited aerobatics competitions in the early 1980s. The prototype of the single seat Su26, the originator of the series, flew for the first time in June 1984, and remarkably competed in the World Aerobatic Championships held in Hungary only two months later.

Features introduced on the initial Su26 include the Vedneyev, now VOKBM, M14 nine cylinder piston radial engine, which is highly regarded for its simplicity, power to weight ratio, fuel economy and low oil consumption. The airframe itself is extremely strong, capable of withstanding +11 and 9g, while the wing''s aerofoil section is symmetrical and attached to the airframe at zero incidence and dihedral for similar positive and negative angle of attack flight characteristics.

Modifications to the Su26 including a squared off vertical tail and less glass led to the Su26M, which participated in the 1986 World Aerobatic Championships in the UK. The Su26MX is an export version. The success of the Su26 led Sukhoi to design a two seat, dual control development, the Su29, which first flew during 1991. Differences include the second seat, greater span wing and increased length. The Su-29M has lightweight ejection seats.

The ultimate development is the Su31, which first flew in June 1992 as the Su29T. The Su31 is a single seater based on the Su29 but with a more powerful engine. The basic version is the Su31T, the Su-31X is for export and the Su31U has retractable undercarriage. Production began in 1994.

 ',' Russia ');

INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Socata MS 180 & MS 250 Morane ',46887756.0,' Socata''s MS 180 and MS 250 Morane light singles are the first applications for new technology Morane Renault direct injection diesel piston engines which run on jet fuel or Avtur. <p>Morane Renault is the marketing name for the Societe de Motorisations Aeronautiques (SMA), jointly established in 1997 by Socata parent Aerospatiale and Renault Sport, the motorsport arm of the French car manufacturer, to develop new technology piston engines for use by Socata and other aircraft builders. <p>Morane Renault is currently developing three new diesel direct injection turbocharged engines, the direct drive 135kW (180hp) MR 180, and the geared 185kW (250hp) MR 250 and 225kW (300hp) MR 300. The major benefit of these engines is that they will run on jet fuel, which is cheaper and more readily available than Avgas. The engines will be computer controlled, allowing the use of a single power lever on aircraft they power. <p>The MR engines will cost about the same as conventional piston engines, but operating costs are predicted to be as much as 30 to 40% lower due to a 3000 hour TBO (time between overhaul), lower maintenance costs, better fuel efficiency and the affordability of jet fuel. <p>A Morane Renault engine got airborne for the first time aboard a modified Socata Trinidad on March 3 1998. This was an MR 250 derated to 150kW (200hp) due to a gearbox limitation. Morane Renault expects the engines to be certificated in late 1999. <p>Socata''s new Morane singles will be the first applications for the new technology engines. The MS 180 will be based on the fixed undercarriage TB 10 Tobago but powered by an MR 180, while the MR 250 powered MS 250 is based on the retractable undercarriage Trinidad. First deliveries are planned for 2000. <p>In addition, Socata plans to offer an MR 300 powered development of its Epsilon two seat trainer as the MS 300 and is looking at a development of the TB 360 with Morane power. <p> ',' France ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Sikorsky S61L & S61N ',7818933.0,'img/0153335-v40-6.jpg',' The Sikorsky S61N and S61L are based on SH3/S61A/B Sea King series originally developed in the late 1950s. They are two of the most widely used airliner and oil rig support helicopters built.

In September 1957 the US Navy awarded Sikorsky a development contract to produce an amphibious anti submarine warfare helicopter capable of detecting and attacking submarines. The prototype Sea King flew on March 11 1959, while production deliveries took place from September 1961. Power for initial production aircraft was supplied by two 930kW (1250shp) General Electric T58GE8B turboshafts.

Development of a civil version was undertaken almost concurrently, with the commercial S61L flying for the first time on November 2 1961. While based on the Sea King, the S61L is 1.27m (4ft 3in) longer allowing it to carry a substantial payload of freight or passengers. Power for initial production S61Ls was supplied by two 1005kW (1350shp) GE CT58140 turboshafts, the civil equivalent of the T58.

Unlike the Sea King, the S61L features a modified landing gear without float stabilisers. The otherwise identical S61N, which first flew on August 7 1962, retains the floats, making it suitable for overwater operations, particularly oil rig support. Both the S61L and S61N were subsequently updated to Mk II standard with improvements including more powerful CT58110 engines giving better hot and high performance, vibration damping and other detail refinements.

A third civil development of the S61 series to be offered was the Payloader, a stripped down machine optimised for aerial crane work. The Payloader features the fixed undercarriage of the S61L, but with an empty weight almost 900kg (2000lb) less than the standard S61N.

The S61 Shortsky is a unique shortened (1.6m/50in) conversion of the S61N and L, designed to increase single engine performance and external payload. The conversion first flew in February 1996 and



 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Slingsby T-67 Firefly ',84334398.0,'img/0618893-v40-6.jpg',' Prior to purchasing the manufacturing and development rights for the French Fournier RF-6B two seat aerobatic basic trainer in 1981, Slingsby specialised in sailplane construction and composite materials, but now concentrates much of its efforts on its successful T-67 Firefly.

The Firefly is a development of the Fournier RF-6B. The RF-6B first flew in March 1974, and Fournier built 45 RF-6B-100s powered by 75kW (100hp) Rolls Royce Continental O-200 flat fours through to the early 1980s. In 1980 Fournier flew a more powerful development of the RF-6B, the 87kW (116hp) Lycoming O-235 powered RF-6B-120. It was this aircraft that formed the basis for Slingsby''s T-67 Firefly.

Slingsby initially built nine T-67As, which were basically RF-6B-120s, before placing into production its own development of the type, the T-67B. The T-67B was the result of a fairly thorough redevelopment of the T-67A. The main difference was that the T-67B was made almost entirely from glassfibre reinforced plastics (GFRPs), Slingsby drawing on its very extensive experience in that field. The benefits of GFRP include better resistance to fatigue, less weight and less drag.

The definitive civil version of the Firefly is the T-67C. The T-67C is similar to the T-67B except for its more powerful 120kW (160hp) Textron Lycoming O-320 engine. Variants of the T-67C are the T-67C-1 with standard fuselage fuel tankage and one piece canopy, the T-67C-2 with a two piece canopy, and the T-67C-3 with wing tanks and three piece canopy. Many T-67Cs have been sold to flying schools and academies (including KLM) while others are in military service.

The military Firefly is the T-67M, which first flew in December 1982. The first model was the T-67M-160 with a 119kW (160hp) Textron Lycoming AEIO-320-D1B engine. With the introduction of wing fuel tanks and two-piece canopy, the designation was changed to T-67M Mk2. The next variant was the T-67M-200 with a 149kW (200hp) AEIO-360-A1E which made the first flight on May 16 1985. The final variant was the T-67M-260 (powered by a 195kW (260hp) AEIO-540) first flown in May 1991.

Many T-67M are used for military initial pilot training and screening, and 113 T-67M-260s  were delivered to the US Air Force as the T-3A Firefly, while some are used by civilian flight schools for airline and military training (the latter under government contract). T-67Ms have aerobatic capable engines and two blade constant speed propellers, among other changes, compared with the T-67C.

 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Sikorsky S58 ',49791927.0,'img/0111773-v40-6.jpg',' The Sikorsky S58 was one of the most successful piston powered mid size helicopters built.

Sikorsky developed the S58 in response to a US Navy requirement for an anti submarine warfare helicopter. What resulted was the S58, which features a single Wright R1820 radial piston engine mounted in the nose, one of the largest fuselages to be designed for a single piston powered helo and a raised flightdeck. As the XHSS1 the S58 flew for the first time on March 8 1954.

Large numbers of S58s were subsequently built to serve with the US Navy in anti submarine warfare roles as the SH34G and SH34J Seabat, and in utility roles with the US Marines as the UH34D Seahorse. The US Army operated large numbers as the CH34 Choctaw while many other allied countries operated the S58 in various military roles. The UK for example licence built a turboprop development called the Wessex, some of which saw civil service.

Modest numbers of piston powered S58s saw civil service with most were delivered to customers within the USA. The S58 offered a very large fuselage and lifting capacity, but its piston engine made it expensive to operate.

In 1970 Sikorsky announced it was developing a turboprop conversion package for the S58. Turboprop powered S58s are designated the S58T and were initially powered by a 1340kW (1800shp) Pratt & Whitney PT6T3, later aircraft a 1400kW (1875shp) PT6T6. The first S58T conversion flew for the first time on August 19 1970. Sikorsky set up a production line to convert customer S58s, offered kits for S58 operators to perform the conversion and purchased used S58s, converted them to turbine power and offered them for resale. Small numbers remain in commercial service.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Sino Swearingen SJ-30-2 ',96501089.0,'img/0274754-v40-6.jpg',' The promising but oft delayed Sino Swearingen SJ-30-2 is a seven place entry level corporate jet.

The SJ-30 concept was for an advanced technology and relatively high performance, yet low cost entry level corporate jet. It will compete against the Cessna CitationJet/CJ1 and Raytheon Premier I.

Development work dates back to the SA-30 Fanjet which was announced in October 1986. Swearingen Engineering and Technology, under the leadership of Ed Swearingen (designer of the Metro and Merlin turboprops) began to design and develop the SA-30 for Gulfstream. Gulfstream planned to market the aircraft as the SA-30 Gulfjet, however it withdrew from the program in September 1989. Instead the Jaffe Group took Gulfstream''s place. Construction of a prototype began in San Antonio, Texas, but in 1990 the Jaffe Group also withdrew from the then SJ-30 program.

The first SJ-30 prototype first flew on February 13 1991 and development progressed slowly until the 1994 announcement that Swearingen would form a joint venture with Taiwanese investors to create Sino Swearingen to build the SJ-30 at a new factory in Martinsburg, West Virginia.

Sino Swearingen decided to enlarge the basic SJ-30, resulting in the 1.32m (4ft 4in) stretched, increased wing span SJ-30-2. The SJ-30 prototype was modified to represent the SJ-30-2 and flew in this configuration in November 1996. The definitive, more powerful FJ44-2A turbofans were installed on this aircraft in September 1997. Three new build production representative prototypes are due to undertake a 1400hr flight test program (the first of these flew on November 30 2000), clearing the way for certification and first deliveries in the third quarter of 2003. An altitude of 49,000ft and a speed of M.83 in level flight had been reached in the test program.

Features of the SJ-30-2 include a Honeywell Primus Epic avionics suite with three 20 x 25cm (8 x 10in) colour, flat panel LCDs and IC-615 integrated avionics computer, a 32° swept wing, increased fuel capacity compared with the basic SJ-30 design, a Mach 0.80 cruise speed and a 4635km (2500nm) range.



 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Sikorsky S-92 Helibus ',69780194.0,'img/0192156-v40-6.jpg',' The S-92 Helibus is a new medium/heavy lift helicopter Sikorsky is developing in with a number of international partners

Development of the S-92 was first announced in 1992 when Sikorsky unveiled a mockup of the new helicopter. In 1993 however Sikorsky postponed launching the S-92 due to the international helicopter market downturn and instead began searching for international risk sharing partners. By 1995 Sikorsky had formed its Team S-92 grouping and formally launched the S-92 at that year''s Paris Airshow.

Sikorsky has built five prototype S-92s, four of which are flying aircraft. The first is a civil S-92A, which first flew on December 23 1998. The international utility/military S-92IU development will also be offered. S-92A certification to FAR/JAR Pt 29 and first deliveries are scheduled for 2002.

As originally envisaged the S-92 was to combine upgraded dynamic system components of the H-60/S-70 series with a larger cabin. However the S-92 is essentially an all new helicopter, with larger, composite construction, swept, tapered and anhedral tipped main rotor blades, new tail rotor, and a new four stage transmission based and the three stage S-70 unit.

Some 40% of the aircraft is of composite construction. The S-92''s main cabin is wider and longer than the S-70''s and features a rear loading freight ramp, while the cockpit will feature a Sanders EFIS system with four colour liquid crystal displays, with provision for a fifth. Power is from two FADEC equipped CT7-8D turboshafts.

Team S-92 members include risk sharing partners Mitsubishi Heavy Industries (7.5%, responsible for the main cabin), Gamesa of Spain (7% - cabin interior and transmission housing) and China''s Jingdezhen Helicopter Group (2% - tail pylon and tailplane), while Taiwan''s AIDC (6.5% - flightdeck) and Embraer (4% - sponsons and fuel system) are fixed price suppliers/partners.

The S-92 is similar in size to the S-61 and is aimed at being a modern replacement for the later helicopter. The S-92 is also in the same class as the popular Super Puma.

Canadian offshore operator Cougar Helicopters became the launch customer. Deliveries will start in 2002.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Sikorsky S62 ',49791927.0,'img/0208453-v40-6.jpg',' Although it resembles the much larger S61/H3 Sea King series, the single engine S62 was an earlier design, based upon the piston powered S55.

The S62 has the distinctions of being Sikorsky''s first production design powered by a turboshaft (rather than piston) engine and Sikorsky''s first amphibious helicopter, although it was only produced in small numbers.

The S62 takes the S55''s dynamic systems, including the rotor blades, main and tail rotor heads, main, intermediate and tail gearboxes and components of other systems including hydraulics and flight controls coupled with a General Electric CT58 turboshaft and a new, larger fuselage.

The new fuselage combined a hull and outrigger floats (housing retractable main undercarriage) giving the S-62 its amphibious capability and a larger more voluminous main cabin. The comparatively light weight of the turboshaft meanwhile meant that it could be mounted above the S-62''s fuselage, rather than in the nose as on the S55 and S58.

The S62 was built in three versions. The prototype flew for the first time on May 14 1958, and the first of the initial production version, the S62A, was delivered to Los Angeles Helicopters in 1961. Only one S62B flew, it differed from the S62A in having the dynamic systems of the S58 (described separately). The S62C was a commercial development of the US Coast Guard''s search and rescue HH52A with a more powerful engine.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Sikorsky S-55 & Westland Whirlwind ',58935758.0,' Like many Sikorsky helicopters, the S-55 started out as a military helicopter for the US armed forces that was later adapted for commercial service.

Sikorsky developed the S-55 in response to a US military requirement for a large general purpose helicopter. The US Defense Department awarded Sikorsky a contract to develop such a helicopter in 1948, and the first prototype flew for the first time on November 10 1949. The S-55 saw widespread US military service as H-19 in the Air Force, as H-19 Chickasaw in the Army, as HO4S in the Navy and Coast Guard, and as HRS in the Marine Corps. Civil certification for the commercial S-55 series was first awarded on March 25 1952.

The initial civil variant was the S-55, powered by a 450kW (600hp) Pratt & Whitney Wasp radial piston engine. Later civil variants include the S-55A which introduced a 520kW (700hp) Wright R-1300 radial piston engine, while the S-55C had a P&W R-1340 engine and the repositioned tail boom of the S-55A.

Westland in the UK licence built 400 S-55s as the WS-55 Whirlwind for mainly military but also commercial use. Early Whirlwinds were similar to the S-55 save for their Alvis Leonides radial engine, later developments were powered by a 785kW (1050shp) Rolls-Royce Bristol Gnome H.1000 turboshaft. S-55 licence manufacture was also undertaken in Japan by Mitsubishi and in France by Sud-Est.

In January 1971 Aviation Specialties was awarded a type certificate for its turbine powered conversion of the S-55, dubbed the S-55T. Aviation Specialties formed the Helitec Corp to market and convert aircraft, and approximately 40 were fitted with a Garrett AiResearch TSE331 turboshaft. The conversion reduced the S-55''s empty weight by approximately 410kg (900lb).

In 1993 VAT (Vertical Aviation Technologies Inc) started the development of a super quiet conversion of the S-55, the S-55QT Whisper Jet. Full certification was awarded in December 1999. The 3-bladed main rotor of the standard S-55 was replaced by a 5-bladed one, and the powerplant is an Allied Signal TSE 331-10 turbine engine. It is certified at a MTOW of 3492kg (7700lb). As the S-55QT was specially developed for sightseeing, an additional left side cabin door, center floor window, and larger cabin windows were fitted, and sightseeing-optimized systems and equipment were added. The first customer for the Whisper Jet was Papillon Grand Canyon Helicopters.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Short Skyvan & Skyliner ',49960669.0,'img/0132161-v40-6.jpg',' The boxy and rugged Short Skyvan and Skyliner date back to the postwar Miles Aerovan project.

Development of the Skyvan, or SC.7, began in 1959 when Short decided to design a small multirole transport with good STOL performance, featuring a squared sided fuselage to accommodate bulky loads. The new design incorporated the results of Miles'' research into high aspect ratio wings, with the Aerovan''s wing design adopted for the SC.7. It first flew in Series 1 prototype form powered by two Continental 290kW (390hp) GTSIO520 piston engines on January 17 1963.

Unlike the prototype, initial production aircraft were powered by 545kW (730shp) TurbomÃ©ca Astazou XII turboprops. The original piston powered Series 1 prototype was the first Astazou powered Skyvan to fly (with 390kW/520shp Astazou IIs), in October 1963. The reengined prototype was designated the Series 1A, while early Astazou powered production aircraft were designated Series 2.

Early on in the SC.7''s production run Shorts decided to switch the powerplant choice to 535kW (715shp) Garrett TPE331201s, resulting in the definitive Series 3 (first flight December 15 1967). Many Series 2 Skyvans were also converted to Garrett power.

The basic Series 3 and the higher takeoff weight Series 3A can perform a number of utility missions including passenger transport, ambulance, aerial survey and freight work, and are called Skyvans. The Skyliner airliner features an improved level of interior equipment and furnishing, while military Skyvans are designated Series 3M and 3M200 with a higher max takeoff weight.

 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Sikorsky S-76 ',6693369.0,'img/0389307-v40-6.jpg',' Sikorsky''s S76 is a popular mid size corporate and oil rig support helicopter.

Sikorsky began development work on the S76 (for a time named Spirit) in the mid 1970s and used technologies and experience gained from the military S70 Black Hawk program. The resulting S-76A was powered by two Allison 250C30S turboshafts and could seat 12. First flight was on March 13 1977 and FAA certification was awarded in November 1978.

The first improved model was the S76 Mark II (introduced in March 1982) with more powerful Allison engines and 40 detail refinements. The S76B is powered by two Pratt & Whitney Canada PT6B36s (the 101st and last B was due to be delivered in December 1998), while the S76C is powered by two Turboméca Arriel 1S1 engines. The S76A+ designation covers undelivered S76As subsequently fitted and delivered with Arriel engines, and S76As converted to Arriel power.

Current production is of the S76C+ with 18% more powerful FADEC equipped Arriel 2S1 engines. Certification of the C+ was awarded in mid 1996. Forthcoming improvements include composite blades, a quiet tail rotor with curved blades, an active noise and vibration control system, and an advanced health and usage monitoring system. A three LCD screen integrated instrument display system (IIDS) for engine and rotor information is now standard, supplementing the four screen Honeywell EFIS suite.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('SIAI-Marchetti S-205/208 ',92583583.0,'img/0234462-v40-6.jpg',' SIAI-Marchetti intended that this series of four seat light aircraft would provide it with a re-entry into the GA market.

When SIAI-Marchetti began work on the S-205, a modern four seat light aircraft design, in the mid ''60s, the company intended to develop a series of aircraft with various powerplant and other options, such as retractable undercarriage and constant speed propellers. To this end the company was modestly successful, with several hundred S-205s and larger S-208s built, with most sold to European customers.

The first of three S-205 prototypes flew for the first time during 1965. This initial aircraft was powered by a 135kW (180hp) Lycoming O-360 and featured a fixed undercarriage. In production it became the S-205-18F (18 for 180hp, F for fixed undercarriage). The first production S-205-18F flew in February 1966 and deliveries commenced later that year. The model lineup was expanded to include the 150kW (200hp) fuel injected IO-360 powered and higher max takeoff weight S-205-20F, and the retractable undercarriage S-205-18R and S-205-20R. The most powerful member of the S-205 family was the S-205-22R. This aircraft was powered by a 165kW (220hp) Franklin 6A-350-C1 flat six and was also assembled in the USA by Waco as the four seat S-220 Sirius and five seat S-220-5 Vela.

Production of the S-205 initially ceased in 1975, although SIAI-Marchetti returned the S-205-20R to production from 1977 until 1980 to meet an order for 140 for the Italian Aero Club.

The S-208 is based on the S-205 but has a larger cabin with seating for five. First flown in 1968, it is powered by a 195kW (260hp) Lycoming O-540 and has retractable undercarriage, a third cabin window per side, optional tip tanks and strengthened structure. Deliveries commenced in 1968, and 44 were built for the Italian air force as S-208M. Production closed in 1975 and then resumed in 1977 alongside the S-205-20R until finally ceasing in 1980.





 International Directory of Civil Aircraft



 ',' Italy ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Short Belfast ',35936608.0,'img/0060931-v40-6.jpg',' With a maximum takeoff weight of over 100 tonnes (220,500lb), Short''s Belfast is one of the largest turboprop powered aircraft built, behind the massive 250 tonne (551,250lb) max takeoff An-22 (described separately) and Douglas'' C133 Cargomaster of the 1950s.

The Belfast was developed in response to a Royal Air Force requirement for a heavy lift freighter capable of carrying a wide range of military hardware, including artillery pieces, 200 plus troops, helicopters and/or guided missiles over relatively long ranges. Short had studied a number of large freighter designs during the late 1950s, and what became the Belfast began life as the SC.5/10, design work on which began in February 1959.

Development of the SC.5/10 design resulted in a first flight of the Belfast on January 5 1964. Design features of this big aircraft included four RollsRoyce Tyne turboprops mounted on a high wing, an 18 wheel undercarriage (comprising two eight wheel main bogeys and two wheel nose undercarriage system) and beaver tail rear loading doors and ramp. When the Belfast entered service with the RAF in January 1966 it was the largest aircraft to be operated by that service.

The Belfast''s military career was relatively short lived, and all 10 were retired in 1976. Heavylift (then TAC Heavylift) acquired five Belfasts for commercial service in 1977, and three were placed into service in 1980. Marshall of Cambridge performed a number of modifications on the Belfast which allowed it to be certificated to civil standards on March 6 1980. Since then Heavylift''s Belfasts have given the company a useful heavylift capability to carry heavy and awkward sized loads, bettered only by its An-124s. One remained in use in 1998.

 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Short 330 ',62153278.0,'img/0056471-v40-6.jpg',' The Short 330, or the `Shed'' as at least one regional airline affectionately dubbed it, is an inexpensive and reliable 30 seat airliner, if somewhat slower than most of its pressurised competition.

The Short 330 is a stretched development of the SC.7 Skyvan. Beginning life designated the SD330, the 330 retained the Skyvan''s overall configuration, including the slab sided fuselage cross section, supercritical, braced, above fuselage mounted wing design (lengthened by 2.97m/9ft 9in) and twin tails. Compared with the Skyvan though the fuselage is stretched by 3.78m (12ft 5in), allowing seating for over 10 more passengers. Improved performance over the fairly slow Skyvan results from two Pratt & Whitney PT6A turboprops driving five blade props, pointed nose and retractable undercarriage. More than 60% greater fuel capacity boosts range significantly over the Skyvan.

An engineering prototype of the 330 flew for the first time on August 22 1974, while a production prototype flew on July 8 1975. The first true production aircraft followed that December. The 330 entered airline service with Time Air of Canada in August 1976.

Initial Short 330s were powered by PT6A45As and 45Bs and are known as 330100s, while definitive 330-200s feature more powerful PT6A45Rs. The 200s also feature a number of detail improvements, while items previously available as options were made standard equipment.

Various freighter versions of the 330 have been developed, including the Sherpa with a rear loading ramp (in service with the US Air Force and Army as the C23), and the military 330UT.

 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Scottish Aviation Twin Pioneer ',27118311.0,'img/0217128-v40-6.jpg',' The Scottish Aviation Twin Pioneer utility transport saw limited commercial and military service, mainly in the UK and some Commonwealth countries.

Despite its name, the Twin Pioneer is an all new aircraft compared with the Scottish Aviation Pioneer. The original Pioneer was a high wing single engined five seat light aircraft powered by an Alvis radial engine which was built in small numbers for the Royal Air Force for liaison duties.

The Twin Pioneer is also powered by Alvis radials and features a high wing, but is much larger, capable of seating up to 16 passengers in the main cabin. Designed for both civil and military applications, the Twin Pioneer was also one of the few postwar aircraft to feature a high wing and tailwheel undercarriage, while its triple vertical tail arrangement makes it easily recognisable.

The prototype Twin Pioneer flew for the first time on June 25 1955, and the first production examples were delivered from April 28 1956. By mid 1964, when production ceased, 94 of three different models had been built. Britain''s Royal Air Force was the largest customer, taking delivery of 39 Twin Pioneers.

The RAF used its Twin Pioneers for a variety of transport and liaison roles, and they could carry 13 troops, or 11 paratroops, or six stretchers and five sitting casualties or medical attendants. Another military operator was Malaya/Malaysia.

The initial Twin Pioneer production model was the Series 1, powered by two 410kW (550hp) Alvis Leonides 514/8 radials. The Series 2 was powered by Pratt & Whitney R-1340 radials. Final production was of the Series 3 (described above), powered by 475kW (640hp) Leonides 531/8 radials. In RAF service the Series 1 was designated Twin Pioneer CC1, and the Series 3 was the Twin Pioneer CC2.

In 2002 only a handful of Twin Pioneers remained in service, including two Series 3s registered in Australia.

 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Schweizer 330 ',53750290.0,' The Schweizer 330 is the ultimate expression of the Hughes/Schweizer 300 series of two/three seat light piston engine helicopters that dates back to the mid 1950s.

The Schweizer company, a firm well known for its production of gliders over the last five decades, acquired the production and manufacturing rights to the Hughes 300, which it had been building under licence since 1983, from McDonnell Douglas in November 1986. In 1987 Schweizer announced it was developing an improved turbine powered version.

The new model was dubbed the 330 and was designed to fulfil a number of utility roles, including law enforcement, observation and patrol, aerial photography, utility transport and agricultural spraying, missions all ably filled by the earlier and smaller 300.

The Schweizer 330 uses the dynamic components, rotors, controls and systems of the proven 300C, combined with an Allison 250C20 turboshaft. The engine has been derated to just 165kW (220hp), giving the 330 excellent hot and high performance. For example the powerplant will reach its max rated power output right up to 18,000ft. Other changes compared with the 300C include what is essentially an all new fuselage, new vertical tail surfaces and new tail fairing.

The 330 first flew in the first half of 1988, being publicly demonstrated flying for the first time that June. FAA certification was awarded in September 1992 and first deliveries took place from mid 1993.

The improved 330SP was announced in May 1997. Compared to the basic 330 it features a larger main rotor hub, increased chord main blades and raised skids. These modifications can also be retrofitted to existing 330s.

To enhance its appeal as a trainer the 330 is offered with a third set of flight controls, allowing the carriage of two pupils and an instructor on training flights.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Saab 340 ',93771766.0,'img/0121542-v40-6.jpg',' The Saab 340 proved to be a highly popular regional airliner that helped to pioneer the 30 seat turboprop class but slow sales in the late 1990s has forced Saab to cease production.

In 1979 SaabScania of Sweden and Fairchild in the USA reached an agreement to conduct joint feasibility and development studies on a 30 to 40 seat commuter airliner. The resulting SF340 design was launched in September 1980 with the aim of capturing 25 to 30% of its market. Within the 65/35 SaabFairchild partnership split Saab was responsible for the fuselage, fin and final assembly, while Fairchild was responsible for the wings, engine nacelles and empennage. The two companies selected the General Electric CT7 (a commercial development of the T700 which powers Sikorsky''s S70 series of military helicopters) to power the new airliner.

The first of three SF340 prototypes first flew on January 25 1983, while the first production aircraft flew in early March 1984. US and European certification was awarded that June. From November 1 1985 Saab assumed overall responsibility for the SF340 following Fairchild''s decision to divest itself of its aircraft divisions. Saab initially retained the SF340 designation but later changed it to 340A.

The first improved development of the Saab 340 was the 340B. More powerful engines improved hot and high performance, while other changes included a greater span tailplane, a higher max takeoff weight and better range. Deliveries began in September 1989.

The last development of the 340 was the 340B Plus, which introduced changes developed for the larger Saab 2000, including an improved cabin interior. The first 340B Plus was delivered in March 1994. Lack of sales and profitibility however forced Saab to cease 340 and 2000 production, with the lines winding up in 1998.

 ',' Sweden ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Socata GY-80 Horizon & ST-10 Diplomate ',52451225.0,'img/0187992-v40-6.jpg',' The Horizon and Diplomate are relatively high performance retractable undercarriage four seaters which were built in relatively modest numbers.

The initial GY-80 Horizon began life as a privately developed design penned by Yves Gardan, who had also been responsible for a number of other postwar light aircraft designs. Gardan built a prototype as a private development which flew on July 21 1960. Two years later, Sud Aviation (now Aerospatiale) acquired the design and production rights for the GY-80 and placed the type into production. Sud Aviation built three preproduction development aircraft before placing the GY-80 into production in late 1963.

A key aspect to the GY-80 was its simple design and method of construction. The GY-80 was of conventional appearance but slightly unusual construction, with an aluminium skinned steel tubular framework for the cabin area, and monocoque tailcone bolted aft. It featured a retractable tricycle undercarriage, Frise slotted ailerons and Fowler flaps. The flaps are permanently connected to the undercarriage linkage which is wound up and down manually with a handle protruding from the instrument panel. To reduce maintenance costs, the flaps, ailerons and horizontal tail pieces were interchangeable (in theory, but they needed to be modified if they were previously used at any other position). The Horizon was built using car assembly techniques, with just 11 production jigs.

Three versions of the Horizon were built, differing in powerplant and fuel tankage. These were the 110kW (150hp) Lycoming O-320-A powered GY-80-150, the 120kW (160hp) O-320-B2B powered GY-80-160, and the 135kW (180hp) Lycoming O-360-A powered GY-80-180. These were built firstly by Sud Aviation, and then by its newly established light aircraft division, Socata, from 1966.

Socata flew an improved development of the GY-80, initially called the Super Horizon 200, on November 7 1967. This new development featured a stretched cabin and a more powerful 150kW (200hp) fuel injected Lycoming IO-360-C. In production between 1969 and 1974, the Super Horizon was renamed Provence, and then the ST-10 Diplomate, the latter becoming the type''s definitive name.

 ',' France ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Rockwell Commander 112 & 114 ',13555884.0,'img/0172222-v40-6.jpg',' The Rockwell Commander 112 and 114 are high performance, retractable undercarriage light aircraft. <p>Rockwell''s General Aviation Division began development of the original Commander 111 and 112 during the late 1960s, and announced its new range in late 1970. Both models featured conventional construction and a low wing configuration but the 111 had fixed undercarriage and the 112 had retractable gear. The prototype 112 first flew on December 4 1970, and was powered by a 135kW (180hp) Lycoming O360, while a prototype 111 flew for the first time late in 1971. The loss of the 112 prototype during flight testing due to the structural failure of the tail unit delayed certification and production of both models until a fix was found. Deliveries of production aircraft took place from late 1972. <p>Production 111s were powered by 135kW (180hp) O360s, production 112s were powered by more powerful 150kW (200hp) IO360s. Only a few 111s were built before Rockwell decided to concentrate on the higher performance retractable gear 112. The updated 112A appeared in 1974 with a higher max takeoff weight, improved cabin ventilation and detail refinements, while the turbocharged 112TC was introduced in 1976. <p>Also introduced in 1976 was the 114, which is basically a 112 with a more powerful six cylinder IO540. The 114 remained in production basically unchanged until production ceased in 1979, by which stage it had been named the Gran Turismo Commander. Meanwhile the improved 112B had appeared in 1977, featuring an increased max takeoff weight and the extended wingtips introduced on the 112TC. By that stage the 112TC was designated the 112TCA, later it became known as the Alpine Commander. <p>The Commander Aircraft Company has been building the improved 114B and 114TC since 1992, but these are described separately. <p> ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Saab 2000 ',53511045.0,'img/0286308-v40-6.jpg',' The Saab 2000 was a stretched 50 seat, faster development of the successful 340.

The Saab 2000, with a cruise speed of over 665km/h (360kt), is one of the fastest turboprop airliners developed. It combines near jet speeds, including near jet climb and descent rates, with turboprop economy. Saab launched development of the 2000 in mid December 1988 with a launch order from Crossair for 25 (plus a further 25 on option) following definition and design studies that revealed a market for a high speed regional turboprop.

The initial Saab 2000 development plan would have seen the 2000 in service in the second half of 1993, but delays pushed this back until the second half of 1994. The Saab 2000''s first flight took place on March 26 1992, and certification from Europe''s Joint Airworthiness Authorities and the USA''s FAA was granted in March and April 1994 respectively. Service entry with Crossair occurred a few months later.

While retaining the same cross section as the Saab 340, the 2000 is 7.55m (24ft 9in) longer (seating 15 more passengers), while the same wing section was retained but the 2000''s wing span is 15% greater than the 340''s, and the engines are positioned further outboard.

The 2000 was the first civil application of the advanced Allison (now Rolls-Royce) AE-2100 turboshaft (derived from the military T406 developed for the revolutionary V-22 Osprey tiltrotor), driving slow turning six blade props. The flightdeck features a Collins Pro Line 4 EFIS avionics suite with six colour CRT displays. Cabin noise is reduced by an active noise control system comprising 72 microphones and 36 speakers which generate anti phase noise.

Several European aerospace firms participated in the Saab 2000 manufacturing program including CASA which designed and built the wing, Westland, which manufactured the rear fuselage, and Valmet of Finland which built the tail.

Lack of sales and profitability forced Saab to cease 340 and 2000 production, with the lines winding up in 1998. The last 2000 was delivered to Crossair in April 1999.

In 2000, 54 were in airline service with three used as corporate transports.



 ',' Sweden ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Rockwell Sabreliner ',61552895.0,'img/0085515-v40-6.jpg',' The Sabreliner was successfully developed for both military and civil use.

North American Aviation began work on the Sabreliner as a private venture but it was formally launched in August 1956 in response to the US Air Force''s UTX (Utility Trainer Experimental) requirement for a utility jet aircraft capable of performing transport and combat readiness training missions. A civil configured prototype (designated NA264) flew for the first time on September 16 1958 powered by General Electric YJ85 turbojets. Soon after the US Air Force ordered the Sabreliner into production, and it and the US Navy went on to order several Pratt & Whitney JT12 turbojet powered versions, including the T39A pilot proficiency and support transport and the T39B/D radar trainer.

The first civil aircraft, the NA265-40, was equivalent to the T39A and was certificated in April 1963. The Series 40 followed from June 1966 and featured a higher cruising speed and greater internal cabin space. The Series 60 was stretched by 97cm (3ft 2in) and is identifiable by its five, rather than three, cabin windows per side. The Series 60A introduced aerodynamic changes over the 60. The Sabreliner 75 meanwhile is based on the 60 and 60A, but has a deeper fuselage with greater headroom.

Turbofan power was introduced to the Sabreliner family in 1973 (by which time North American had become part of Rockwell International) with the introduction of the General Electric CF700 turbofan powered 75A. The 75A also introduced aerodynamic, cabin, equipment and systems improvements. The Series 65A meanwhile is similar to the 60A and 75 but is powered by Garrett AiResearch TFE73131D turbofans. It was delivered from December 1979. Sabreliner production ceased in 1981.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Schweizer 269/300 ',3552906.0,'img/0159053-v40-6.jpg',' The Hughes/Schweizer 300 is the most successful three seat helicopter built, with over 3400 produced by the two manufacturers over three decades

Development of this versatile utility helicopter dates back to the mid 1950s when Hughes flew the two seat Model 269 for the first time in October 1956. The basic design sparked US Army interest and it ordered five as the YHO2HU for evaluation in the scout and observation roles. Deliveries of the commercial equivalent Model 269A began in 1961.

The 269A program received a huge boost when Hughes won a US Army contract for a light helicopter primary trainer. In all 792 were built as the TH55A Osage and more than 60,000 US Army helicopter pilots learnt to fly in the type.

Hughes followed the two seat 269A with the slightly larger three seat 269B, which it marketed as the Hughes 300, which first flew in 1964. The 300 was followed from 1969 by the improved 300C, which introduced a more powerful 140kW (190hp) Lycoming HIO360 engine and increased diameter main rotor, giving an increase in payload of 45%, plus performance improvements. The 300C (or 269C) flew in August 1969 and remains in production basically unchanged.

Since 1983 the 300C has been built by Schweizer in the USA. Schweizer built the 300C initially under licence for Hughes, and then acquired all rights to the helicopter in 1986. Under Schweizer''s stewardship more than 250 minor improvements have been made to the 300C, but the basic design has been left unchanged. Schweizer also offers a version optimised for police work. Named the Sky Knight it is available with options such as a search light and infrared sensors.

The latest 300 model is the 300CB trainer powered by a HO360C1A and delivered from late 1995.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Robinson R22 ',96324343.0,'img/0077784-v40-6.jpg',' The Robinson R22 has undisputedly been the world''s most popular light helicopter since its introduction in the late 1970s. <p>The R22 was designed by the founder of the Robinson Helicopter Company, Frank Robinson. The R22 was conceived to be an efficient, cheap to acquire (with a purchase cost comparable to two/four seat light aircraft), reliable and economical to operate multi purpose two seat light helicopter. <p>Design work on the R22 began in the 1970s, and an 85kW (115hp) Lycoming O235 powered prototype flew for the first time on August 28 1975. Certification of the R22 was delayed somewhat to March 1979 however by the loss of the prototype. Despite this setback though the R22 was an overnight success, and several hundred had been ordered by the time the first were delivered from October 1979. <p>A number of variants and developments of the R22 have been offered. These include the improved R22 Alpha introduced in 1983, and the more powerful R22 Beta from 1985. The R22 Mariner is equipped with floats, the R22 Police version is fitted with special communications gear, a searchlight, siren and loudspeaker, the R22 Agricultural is fitted with tanks and booms for agricultural spraying, while the R22 IFR is fitted with IFR instrumentation for helicopter IFR flight training. <p>The latest R22 model is the R22 Beta II, powered by a 120kW (160hp) O360 derated to 98kW (131hp) for takeoff for improved hot and high performance (as takeoff power can be maintained up to 7500ft). The Beta II was introduced into production in 1995 and certificated in early 1996. <p>R22 uses are varied and include helicopter pilot training, cattle mustering, traffic reporting and police work. <p> ',' United States of America ');



INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Robin DR-400/500 ',14263963.0,'img/1185593-v40-6.jpg',' The Robin DR-400 series of light aircraft owes its origins to the Jodel series of wooden construction light aircraft.

Avions Pierre Robin was formed by Pierre Robin and the principle designer of Jodel Aircraft, Jean Delemontez, in October 1957 as Centre Est Aeronautique. The company''s initial production was of developments of the basic Jodel series of tail draggers, and it was these aircraft that evolved into the DR-400 series. Initial production was of the DR-100 and the DR-1050/1051, while the DR-220, DR-221 and DR-250 featured the Jodel''s basic wing with a four seat fuselage. The final links between the Jodels and the DR-400 were the DR-253 and DR-300 series, tricycle developments of the DR-220 series.

First flight of the DR-400 occurred during June 1972, both a DR-400-125 and a DR-400-180 taking flight that month. Essentially, the DR-400 was an improved DR-300 with a forward-sliding canopy replacing the doors of the previous model.

Since that time a number of developments have been offered. The least powerful version is the DR 400-120, and it remains in production today as the DR-400-120 Dauphin 2+2. Powered by an 84kW (112hp) O-235, the DR-400-120 is really a two seater, although it can seat two children on a rear bench seat. The DR-400-125I has a 93kW (125hp) fuel injected IO-240 and was revealed in 1995. The DR-400-140 Dauphin is powered by a 120kW (160hp) O-320 and is a full four seater. The four seat DR-400-160 Chevalier meanwhile also features a 120kW (160hp) Lycoming O-320 and seats four. It first flew in June 1972. With a different prop, more fuel capacity and slightly different wing it became the DR-400-160 Major from 1980.

The four/five seat DR 400-180 Regent and DR-400-180R Remo 180 are powered by the 135kW (180hp) (Textron) Lycoming O-360, the Remo being optimised for glider towing. Also optimised for glider tug work is the DR-400-200R Remo 200, the most powerful DR-400 model (powered by a 150kW/200hp IO-360, driving a constant speed prop).

The DR-500 President was unveiled at the 1997 Paris Airshow as the DR-400-200I. It features a 150kW (200hp) IO-360 driving a constant-speed prop and widened and taller cabin. Deliveries began in 1998.




 ',' France ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Republic RC3 Seabee ',82446262.0,'img/0026833-v40-6.jpg',' One of the few amphibious light aircraft to be produced in any sort of numbers, the Republic Seabee was built by the same company that was responsible for the legendary World War 2 P47 Thunderbolt fighter.

The Seabee was conceived during the latter stages of World War 2 when Republic began to look beyond its massive wartime contracts to a basis for sustained peacetime production. The original concept was one that was quite popular during the 1940s - to provide a four seat light aircraft that would cost little more to purchase and operate than a family car. To an extent Republic succeeded in its aims, more than 1000 Seabees were built in just one year of production.

The original prototype Seabee was designated the RC1 (Republic Commercial design number one) and first appeared during 1944. The RC1 was a three seat design powered by a 130kW (175hp) six cylinder Franklin 6ALG365 piston engine. First flown during November 1944, the conventional all metal construction RC1 for a time was dubbed the Thunderbolt Amphibian.

A comprehensive testing and development program ensued, during which the RC1 was punishingly tested. One test that illustrated that the RC-1 encompassed Republic aircraft''s legendary abilities to absorb punishment involved intentionally making a wheelsup landing on a concrete runway. The RC1 passed this test without incident, the only damage being a small metal shaving from the keel.

While the RC1''s structural integrity was beyond dispute, Republic nevertheless decided to redesign the RC1, mainly to significantly reduce production and acquisition costs. What evolved was the RC3 Seabee, a four seater powered by a 160kW (215hp) Franklin 6A8215B8F piston engine. Aside from the increased seating capacity, the Seabee differed from the RC1 in being lighter, built with far fewer components (450 compared with 1800 in the RC1), required 25% less tooling to manufacture and, most importantly, had an acquisition cost half that of what the RC1''s would have been.

Seabee production began in mid 1946, but lasted only until October 1947, when ironically Republic decided to concentrate on its once more lucrative military business, despite healthy Seabee sales.

The decision to cease Seabee production also terminated development plans for twin engined and landplane developments.

 ',' United States of America ');

INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Raytheon Hawker Horizon ',79288577.0,' Raytheon''s Hawker Horizon is an all new `super mid size'' corporate jet.

Design work on what became the Horizon was already underway when Raytheon Corporate Jets and Beech merged in early 1995 to form Raytheon Aircraft. The new design, initially labelled PD376 and later Horizon 1000, was one of three projects the new Raytheon Aircraft was working on, along with what became the Premier I. Raytheon worked closely with potential customers for the replacement for the Hawker 1000 in the design definition stage, and their input directly influenced the direction of the new aircraft.

Raytheon formally announced the Hawker Horizon immediately prior to the National Business Aircraft Association''s annual convention in November 1996. The Horizon is due to make its first flight in late 1999, followed by certification and first deliveries in the northern spring of 2001.

One of Raytheon''s design philosophies in developing the Horizon is to combine the earlier Hawkers'' popular characteristics with advanced technologies. Experienced Hawker designers formed the core of the Horizon''s design team and the aircraft has been deliberately designed to look and feel like a Hawker.

Compared to the Hawker 1000 the Horizon will have a wider, slightly longer fuselage with a flat floor and stand up headroom and a two tonne heavier max takeoff weight. The Horizon will feature an all composite fuselage which will be manufactured using the automated fibre placement technology developed for the Premier I. The composite fuselage saves weight and increases cabin volume. The empennage features an aluminium sub structure and carbonfibre skin.

Power will be from two digitally controlled Pratt & Whitney Canada PW308A turbofans. P&WC is a risk sharing partner in the program, as is avionics integrator Honeywell (the Horizon will feature Honeywell''s Primus Epic avionics suite with five flat panel colour LCDs).

The Horizon''s new metal construction supercritical 30o sweep, aft loaded wing will be built by Fuji Heavy Industries of Japan, another risk sharing partner, and will pass beneath the fuselage. Other risk sharing partners include Messier-Dowty (landing gear), Sundstrand, Vickers and AlliedSignal (APU and environmental control system).

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Raytheon Beechjet 400 ',36489568.0,'img/0074813-v40-6.jpg',' The Raytheon Beechjet traces its origins back to the Mitsubishi Diamond 2 bizjet, which Beechcraft acquired the design and production rights to in the mid 1980s.

The original Mitsubishi MU300 Diamond 1 flew for the first time in August 1978, powered by two 11.1kN (2500lb) P&WC JT15D4 turbofans. The subsequent Diamond 2 flew on June 20 1984, with the first production aircraft flying in January 1985. Only 11 Diamond 2s were built before Beech purchased the design and production rights, resulting in the Model 400 Beechjet.

Beech reengined the Diamond 2 with P&WC JT15D5 turbofans, developed a new interior, and incorporated a number of other minor refinements. Deliveries of the Beechjet began in June 1986, with low rate production continuing until that model was replaced by the Model 400A, which was delivered from November 1990.

The new 400A incorporated a number of improvements over its predecessor. A higher max takeoff weight and greater operating ceiling improved performance, while repositioning the rear fuselage fuel tank increased cabin volume. The flightdeck features Collins Pro Line 4 EFIS with three colour displays - two primary flight displays (PFDs) and a multifunction display (MFD) with a second MFD optional.

Following customer feedback Raytheon developed a new luxury standard interior for the Beechjet which was introduced in 1996.

The Beechjet 400A also serves as the basis for the military T-1 Jayhawk tanker and transport aircrew trainer - 180 were delivered between 1992 and 1997. The Japan Air Self Defence Force has also taken delivery of 12 T-400 aircrew trainers (Beechjet 400Ts).

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Raytheon Hawker 1000 ',63875474.0,'img/0173577-v40-6.jpg',' The Hawker 1000 was the largest member of the DH/HS/BAe-125/Hawker 800 series of corporate jets.

The Hawker 1000 was based on the smaller Hawker 800, and until 1997 the two types were in production side by side in the famous de Havilland plant in Hatfield. The 1000 differs from the 800 in a number of respects however and features a stretched fuselage. The 1000 is identifiable via its seven main cabin windows per side, whereas the 800 has six, and the 0.84m (2ft 9in) stretch (achieved by small fuselage plugs in front of and behind the wing) allowing an increase in max seating to 15. However as it is optimised for long range intercontinental work, the typical Hawker 1000 configuration seats one less than the smaller Hawker 800.

Other important changes include Pratt & Whitney Canada PW-305 turbofans (in place of the AlliedSignal TFE-731 on the Hawker 800), extra fuel in the extended forward wing fairing, new lightweight systems, revised and more efficient cabin interior with increased headroom, EFIS cockpit and certification to the latest US FAR and European JAR requirements.

British Aerospace launched the BAe-125-1000 program in October 1989. The first BAe-125-1000 development aircraft first flew on June 16 1990, with a second following on November 26 that year. These two were followed by the first production aircraft which participated in an 800 hour flight test development program, culminating in UK certification being granted on October 21 1991 (FAA certification followed on October 31 1991). The first production aircraft was delivered in December 1991.

As is the case with the BAe-125-800, the BAe-125-1000 became the Hawker 1000 from mid 1993 when Raytheon purchased British Aerospace''s Corporate Jets division. However, the 1000 never enjoyed the popularity of the 800 and production ceased in 1997 with the delivery of the 52nd aircraft.

The 1000''s largest customer is Executive Jet Aviation (including the NetJets fractional ownership program), which early 2002 has 27 in service (including 13 of the last 14 built).

 ',' United Kingdom and United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Socata Rallye ',4611441.0,'img/0921404-v40-6.jpg',' The prolific Rallye family is Europe''s most successful light aircraft series, and today remains in production in Poland as the PZL-Okecie Koliber (described separately).

Morane-Saulnier originally designed the Rallye in response to a late 1950s French government competition for a light aircraft. Morane Saulnier''s proposal resulted in the Rallye, which flew for the first time on June 10 1959. This first MS-880A prototype was powered by a 67kW (90hp) Continental C-90 flat four.

Sud Aviation''s subsidiary Socata (who took over the Rallye after Morane-Saulnier collapsed in the mid 1960s) developed a wide range of Rallye models. The main two/three seat production version was the 75kW (100hp) Continental O-200 powered MS-880B Rallye Club. Other Rallye Clubs were the 78kW (105hp) Potez powered MS-881 and 85kW (115hp) Lycoming O-235 powered MS-883. A more powerful Rallye Club development was the 110kW (145hp) Continental O-300 flat six powered Super Rallye (later to become the Rallye 150S, then 150ST and later still the Garnement with 155kW (155hp) O-320).

The first true four seater was the MS-890 Rallye Commodore, which differed from the Super Rallye in having a higher max takeoff weight and strengthened structure. Deliveries began in 1964. Developments of the Commodore included the 110kW (150hp) Lycoming O-320 powered MS-892 Commodore 150 (later the Rallye 150GT), the 135kW (180hp) O-360 powered MS-893 Commodore 180 (later the Rallye 180GT and then the Gaillard), the 165kW (220hp) powered MS-894 Rallye Minerva (later the Rallye 220GT and sold in the US as the Waco Minerva) and the 175kW (235hp) O-540 powered Rallye 235GT (later the Gabier).

Product improvements led to the Rallye Club based Rallye 100S with two seats and 100ST with three seats, both replaced by the 82kW (110hp) engined Rallye 100ST Galopin, the Rallye 125 2+2 seater, the glider towing 180T Galerien and the tail dragger Gaucho ag sprayer. French production ceased in 1983.

 ',' France ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Raytheon Beechcraft King Air 300 & 350 ',31755286.0,'img/0176533-v40-6.jpg',' The King Air 300 is an updated version of the successful B200 series, and it itself was replaced by the further improved King Air 350, the latest model in this long running and successful line of corporate and utility transports. <p>Design of an improved development of the successful King Air B200 began in August 1981, the 14 month design effort culminating in the first flight of the modernised 300 model in October the following year. Improvements to the B200 were many, with the main change being the installation of more powerful PT6A60A turboprops in place of the 42s of the earlier model. Other changes included reprofiled and more aerodynamically clean engine cowls and exhausts and extended wing leading edges, plus minor internal changes. Both empty and max takeoff weights were also increased. <p>The max weight was reduced for the 300LW or `Light Weight'', intended to minimise the effects of weight based airways user fees, particularly in Europe. The 300AT was an airline pilot trainer. <p>The King Air 300 has been replaced by the 350, its major improvements being a stretched fuselage lengthened by 86cm (2ft 10in) and the addition of winglets. The latest member of the King Air family, it had its first flight in 1988, and has been in production since late 1989. The King Air 350C features a builtin airstair and a 132 x 132cm (52 x 52in) freight door. The 350 is also available in a range of special missions and military variants. <p>The `Super'' prefix was dropped from the King Air name in 1996. <p> ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Raytheon Beechcraft King Air 200 ',81357899.0,'img/0158149-v40-6.jpg',' The King Air 200 is a continuation of the King Air line, with new features including the distinctive Ttail, more powerful engines, greater wing area and span, increased cabin pressurisation, greater fuel capacity and higher operating weights compared to the King Air 100.

Beech began design work on the Super King Air 200 in October 1970, resulting in the type''s first flight on October 27 1972. Certificated in mid December 1973, the King Air 200 went on to be the most successful aircraft in its class, eclipsing such rivals as the Cessna Conquest and Piper Cheyenne. Today the King Air 200 is the only one of the three in production.

The improved B200 entered production in May 1980, this version features more efficient PT6A42 engines, increased zero fuel max weight and increased cabin pressurisation. Sub variants include the B200C with a 1.32m x 1.32m (4ft 4in x 4ft 4in) cargo door, the B200T with removable tip tanks, and the B200CT with tip tanks and cargo door. The Special Edition B200SE was certificated in October 1995 and features an EFIS avionics suite as standard.

Various special mission King Air 200s and B200s have been built, including for navaid calibration, maritime patrol and resource exploration. In addition several hundred Super King Airs have been built for the US military under the designation C12. C12s perform a range of missions from electronic surveillance to VIP transport.

The 1500th commercial King Air 200 was built in 1995. In 1996 Raytheon dropped the `Super'' prefix for all 200, 300 and 350 model King Airs.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Ruschmeyer R 90 ',7679173.0,'img/0114077-v40-6.jpg',' The R 90 is an all new four seater that was built in the early to mid 1990s before Ruschmeyer filed for bankruptcy.

The R 90 was a new design based on the Ruschmeyer''s earlier MF85, making use of a range of modern technologies and materials. The MF85 series was powered by Porsche engines, but the unavailability of these powerplants led to the development of the Textron Lycoming powered R 90.

The Ruschmeyer R 90 possesses an aerodynamically clean airframe made possible by its glass fibre (with Rohacell core) construction. The advanced wing design features a `rain tolerant'' laminar flow aerofoil design, wet wing fuel tanks, upturned wingtips (for increased lateral stability, not drag reduction), small ailerons and inboard Fowler flaps.

The initial R 90230 RG production model was powered by a fuel injected Textron Lycoming IO540 flat six driving an advanced four blade composite construction propeller. A silencer on the engine, the four blade prop and the engine being derated to 170kW (230hp) from 195kW (260hp) combine to give low interior and exterior noise levels. Even though the engine has been derated, because of the R 90''s comparatively light structure its performance is quite strong.

All production R 90s were the high performance retractable undercarriage R 90230 RG. This model first flew on August 8 1988, with German certification awarded in June 1992.

Members of the planned R 90 family include the fixed gear, 175kW (235hp) O540J powered R 90230 FG and the fixed undercarriage 135kW (180hp) IO360 (flat rated to 150kW/200hp) powered R 90180 FG. The R 90350T RG, to be powered by a 185kW (250hp) turbocharged engine and capable of 435km/h (235kt) cruising speed, and the high performance five/six seat R 95 were also under development. An Allison 250B17 turboprop powered development, the R 90420 AT, was also flown.

However Ruschmeyer was forced to file for bankruptcy in early 1996 and production has ceased.

 ',' Germany ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Short 360 ',62153281.0,'img/0147536-v40-6.jpg',' The Short 360 is a stretched, larger capacity and improved 36 seat derivative of the 30 seat Short 330.

The relative success of the rugged Short 330 prompted the Northern Ireland based manufacturer to study and subsequently develop a stretched derivative. Short announced it was developing the new airliner in mid 1980, and a prototype 360 flew for the first time almost a year later on June 1 1981.

The first production 360 flew in August 1982 and certification was awarded on September 3 that year. The 360 entered service with Suburban Airlines in the US in November 1982.

The two Short airliners are very close in overall dimensions and size, but the later 360 is easily identified by its new conventional tail unit mounted on a revised rear fuselage. The 360 is also 91cm (3ft) longer than the 330, allowing two more seat rows and six extra passengers to be carried, while the extra length reduces drag. Power is supplied by two Pratt & Whitney PT6A65Rs, and the 360''s wing span is slightly greater. Otherwise the 330 and 360 are very similar, and share a high degree of commonality.

Short marketed a number of 360 developments, the first of which was the 360 Advanced with 1062kW (1424shp) PT6A65ARs. The 360 Advanced was introduced in late 1985, but was soon followed by the further improved 360300, which entered service in March 1987. The 360300 introduced advanced six blade propellers, more powerful PT6A67R engines giving a higher cruise speed and improved hot and high performance, plus other aerodynamic improvements. The 360300 was also built in 360300F freighter form.

 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Robin HR 200 & R 2000 Alpha ',93167407.0,' This series of light two seat aerobatic aircraft was designed during the 1970s specifically for flying school use, and has been developed in two major variants, both of which are back in production. <p>The original HR 200 was the second all metal aircraft designed for Robin by Christophe Heintz (previous Robins had been designed by Jean Delemontez, who was also responsible for the earlier Jodel series). It first flew on July 19 1971 powered by an 80kW (108hp) O235, while the first production aircraft flew in April 1973. <p>Three initial versions were built, the 80kW (108hp) powered Club or HR 200/100, the more powerful Acrobin 125 or HR 200/125 (with a 95kW/125hp O235) and the Acrobin 160 or HR 200/160 (with a 120kW/160hp IO320). The HR 200 remained in production until the late 1970s, and is once again on offer. Robin has now recommenced production of the HR 200/120 as the Robin 200, with power supplied by an 88kW (118hp) Textron Lycoming O235L2A and a new instrument panel. <p>The R 2000 Alpha series meanwhile was a redevelopment of the HR 200. The HR 200''s basic fuselage was retained, but changes included an all new wing and a enlarged rudder and vertical tail to improve spinning characteristics. The prototype R 2000 was powered by a 135kW (160hp) IO320 and flew for the first time on January 15 1976. Deliveries of production aircraft began in 1977. <p>Three developments of the R 2000 series were built, the R 2100, the R 2112 and R 2160 Alpha Sport, with the main differences between the three being the powerplant fitted. The R 2100 is powered by an 80kW (108hp) O235, the R 2112 has an 84kW (112hp) O235, and the R 2160 has a 120kW (160hp) O320. Of the three, the R 2160 Alpha Sport has been the most popular. Production of the R 2000 series (by Robin factories in France and Canada) originally ceased in 1983, however Robin restarted production of the R 2160 in 1994. <p> ',' France ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Raytheon Beechcraft Bonanza ',24659553.0,'img/0157580-v40-6.jpg',' First conceived in the late 1950s as a lower cost derivative of the Vtail Bonanza, the conventional tail Debonair and Bonanza family remains in production today.

Compared with the equivalent Model 35, the first model 33 Debonair introduced a conventional three surface tail, a less powerful engine and a more austere interior fit. It first flew on September 14 1959 and was included in Beech''s model range the following year.

The subsequent A33 and B33 Debonairs offered a small number of changes, while the C33 introduced a third cabin window and restyled interior. The Debonair was dropped from the range in 1967, by which time the C33A had been released, an aircraft very similar in performance and trim level to the Vtail Bonanzas, and the name Bonanza was adopted for this model range as well. Development of the 33 continued with the E33 and 155kW (285hp) E33A, the aerobatic E33C, the economy G33 and the F33, available in 155kW (285hp) A and aerobatic C models. The F33A remained in production until 1996.

The larger six seat Model 36 was first released in 1968, featuring a stretched cabin, 155kW (285hp) engine and greater takeoff weights. This aircraft remains in production today as the A36 (with an annual production rate of around 80 units). The turbocharged 225kW (300hp) A36TC first appeared in 1979, production switched to the current B36TC in 1981.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Raytheon Beechcraft Baron ',37438531.0,'img/0122899-v40-6.jpg',' The successful and long running Baron line is widely regarded as the most successful of its class, and has comfortably outlasted its main rivals from Piper and Cessna in production. <p>Development of the Baron began in the late 1950s, the first to fly, the Model 9555 on February 29 1960, essentially being a reengined development of the Model 95 Travel Air (Beech''s first light twin, which first flew in August 1956). As a result the Baron can lay claim to Bonanza and T34 Mentor lineage, as the Travel Air combined the fuselage of the former with the tail of the latter, plus twin engines, a new wing and other new features. Some 720 Travel Airs were built from the late 1950s to the late 1960s. <p>The first Barons were delivered during early 1961, although these early production examples were soon followed off the line in 1962 by the improved A55. The subsequent B55 of 1965 is a definitive Baron model and remained in production until 1982, during which time it was continually refined. During the B55''s model life other variants entered production, these included the more powerful C55, D55 and E55. In the meantime the turbocharged Baron 56TC appeared in 1967 and the A56TC in 1970, although these were produced only in limited numbers. <p>The Model 58 is a stretched version of the 55, and first entered production in 1970. It remains in production today, having evolved somewhat in production during that time. Versions include the pressurised 58P and the turbocharged 58TC. Both are powered by 240kW (325hp) Teledyne Continental TSIO520s. Current production (now under the Raytheon Aircraft Company banner) runs at around 40 per year. <p> ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Raytheon 390 Premier I ',14601598.0,'img/0260977-v40-6.jpg',' The Model 390 Premier I is the first all new product of the Raytheon Aircraft Beech/Hawker combine to fly, and is an all new entry level corporate jet designed to compete head on with Cessna''s highly successful CitationJet/CJ1 series.

Design work on the Premier I began in early 1994 under the designation PD-374. Development go-ahead was authorised in early 1995, and initial details of the new jet were released in mid 1995. Raytheon publicly launched the Premier I at the NBAA (National Business Aircraft Association) convention in Las Vegas in September 1995, where a full size cabin mockup was on display.

Construction of the first Premier I began in late 1996 and rollout was on August 19 1998. Four Premier Is were used in the flight test program with the first flying on December 22 1998. Certification was achieved in early 2001.

The Premier I was designed using CATIA computer aided design. Features include its composite carbonfibre/epoxy honeycomb fuselage, swept metal construction wings, T-tail and two WilliamsRolls FJ-44 turbofans.

The composite fuselage is an important feature for a number of reasons. Firstly, advanced production techniques (using computer controlled automated machines) means a Premier I fuselage can be constructed in just one day, whereas a conventional airframe would require one to two weeks to complete. The composite construction also allows greater (approx 13%) internal cabin space compared with a conventional construction fuselage of the same external dimensions.

The Premier I is certificated for single pilot operations. The flightdeck features the new Collins Pro Line 21 EFIS avionics suite with two 20 x 25cm (8 x 10in) flat panel LCDs.

Raytheon intends that the Premier I will form the basis of a new family of business jets.

 ',' United States of America ');

INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Raytheon Beechcraft 1900 ',53133261.0,'img/1765550-v40-6.jpg',' The Beech 1900 19 seat commuter was chosen along with the smaller 1300, both developments of the King Air 200, and the C99 for Beech''s reentry into the regional airliner market in 1979.

The most obvious change from the King Air 200 to the 1900C is the substantially lengthened fuselage (17.63m/57ft 10in compared to 13.34m/43ft 9in). Other changes include more powerful engines, a modified tail with tailets, and stabilons on the lower rear fuselage.

Development of the 1900 commenced in 1979, with first flight occurring on September 3 1982. US FAA certification was awarded in November 1983, prior to the 1900C''s entry into service in February the following year. The first ExecLiner corporate transport version was delivered in mid 1985.

During the course of 1900C production a wet wing was introduced increasing fuel capacity by 927 litres (204Imp gal/245US gal), while military transport, maritime patrol and electronic surveillance versions were offered.

Beech announced the improved 1900D at the US Regional Airlines Association meeting in 1989, with the prototype, a converted 1900C, first flying on March 1 1990. Production switched to the improved model in 1991, with first deliveries (to Mesa Air) that November. The main change introduced on the 1900D was the substantially deeper fuselage with standup headroom. In addition it also introduced larger passenger and freight doors and windows, twin ventral strakes and auxiliary horizontal fixed tails, while more powerful engines and winglets improve hot and high performance.

The 1900D has sold particularly well. For example the 1900D''s biggest customer is Mesa Airlines, a United Airlines feeder, which has placed total firm orders for 118. A 1900D delivered to Impulse Airlines in Australia in March 1997 was the 500th 1900 built.

 ',' United States of America ');

INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('PZL-Mielec M-18 Dromader ',48047798.0,'img/0428775-v40-6.jpg',' The M-18 Dromader agricultural aircraft has been one of Poland''s most successful aircraft exports.

PZL-Mielec designed the Dromader in collaboration with Rockwell International in the US during the mid 1970s. From the outset the aim was to certificate the aircraft to western standards. The first prototype of the basic single seat M-18 first flew on August 27 1976, a second prototype flew that October. Poland awarded certification for the Dromader during September 1978, and series production began the following year.

The basic Dromader design was conventional, with power supplied by a nine cylinder radial engine, while the outer wing panels were based on those on the Rockwell Thrush Commander.

The basic single seat M-18 was in production for five years until 1984 when it was replaced by the two seat M-18A, but has been available to special order since. The two seat M-18A was developed to allow the carriage of either a mechanic or chemical loader to austere fields. In the meantime PZL-Mielec had developed a firebombing derivative which first flew in 1978. The M-18AS trainer has a second cockpit for flight instruction. Since 1996 the M-18B, with a 5300kg (11,684lb) max takeoff weight, has been the standard production model. The M-18BS is a two seat trainer based on the M-18B. The M-18C with 895kW (1200hp) Kalisz K-9 engine flew in 1995 but has not entered production.

In the USA, Melex (part owned by PZL-Mielec) developed a PT6A-45 turboprop development dubbed the M-18/T45 Turbine Dromader. The Turbine Dromader first flew during 1985 and the US FAA issued it a Supplementary Type Certificate in April 1986. Others have been converted with a PT6A-65, TPE331-10 or T53-L-7 turbine engine.

 ',' Poland ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('PZL WarszawaOkecie PZL104 Wilga ',29977322.0,'img/0123950-v40-6.jpg',' The rugged STOL PZL104 Wilga has been one of Poland''s most successful light aircraft exports. <p>Poland''s Light Aircraft Science and Production Centre in Warsaw began development of the Wilga in the early 1960s as a replacement for the general purpose Czechoslovak L60 Brigadyr utility. The prototype Wilga 1 was powered by a 135kW (180hp) Narkiewicz WN6B radial and flew for the first time on April 24 1962. A fairly extensive redesign of the basic aircraft followed, and a modified Wilga 2 with a new fuselage and tail and a 145kW (195hp) WN6RB engine flew in August 1963. That December the 170kW (225hp) Continental O470 powered Wilga C or (Wilga 32) flew and Lipnur Gelatnik later built 39 in Indonesia. <p>Poland''s first production Wilgas were the 3A four seat utility and 3S ambulance which introduced the 195kW (260hp) Ivchenko designed AI14 radial. Soon after PZL reconfigured the Wilga''s cabin and landing gear, resulting in the definitive production version, the Wilga 35. The prototype Wilga 35 first flew on July 28 1967. <p>The Wilga 35 remains in production essentially unchanged, and several variants have been offered, while the Wilga 80 is identical to the 35 other than its further rear positioned carburettor air intake. The Wilga 35A and 80A are designed for flying club operations and are fitted with a hook for glider towing, the 35H and 80H are float equipped, the 35P is usually fitted with four seats, the 35R and 80R are agricultural aircraft fitted with a 270kg (595lb) under fuselage chemical hopper and spray bars, and the 35P is an ambulance variant capable of carrying two stretchers. <p>The PZL-104M Wilga 2000 is an improved development aimed at western customers. It is powered by a 225kW (300hp) Textron Lycoming Continental IO540 flat six in a reprofiled nose, and features AlliedSignal avionics and extra fuel. First flight was on August 21 1996, while FAA certification was awarded in 1997. <p> ',' Poland ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Pitts S-1/2 Special ',84648960.0,'img/0815700-v40-6.jpg',' The designer of the original Pitts Special aerobatic biplane, Curtiss Pitts, could hardly have appreciated that his design would continue in production for many decades, and that it would come to be considered by the general public for a long time as the definitive aerobatic and display flying aircraft.

The original prototype of the S-1 Special first flew in September 1944. The aircraft was of steel tube construction with fabric covering over wooden spars, while the two wings were braced with wire. Power in early aircraft was supplied by 65 to 95kW (90 to 125hp) four cylinder Continentals or Lycomings. Later models were higher powered and of conventional metal construction.

The early Pitts Special aircraft were custom built, differing in detail and powerplant employed. Examples are e.g. "Little Stinker" built for Betty Skelton in 1947 with a 65kW (90hp) Continental and "Black Beauty" built for Caro Bailey with a 95kW (125hp) Lycoming O-290-D. These models featured two ailerons and flat bottom wings.

The first model for which drawings were available, from 1962, was the S-1C. Like the original S-1, this model had two ailerons and flat bottom wings. The homebuilder could choose between several engines of different horsepower.

A second model for which only plans were available, was the S-1D. This differed from the S-1C in having four ailerons and a slightly longer fuselage.

Factory production (initially by Aerotek) of the basic single seat S-1 Special started with the S-1S with a 135kW (180hp) Lycoming IO-360-B4A, driving a fixed pitch prop, and featuring symmetrical instead of flat bottom wings, with four ailerons. Plans and kits of this version were also available, as the S-1SE (originally named S-1E).

The S-1T was introduced to production in 1981, and introduced a 150kW (200hp) Lycoming (now Textron Lycoming) AEIO-360-A1E driving a constant speed prop and with symmetrical wings with four ailerons. Also the wings were moved forward 11.5cm (4.5in) compared with the S-1S. The S-1T was also available as a kit, as the S-1TE.

The two seat S-2 Special is of the same configuration as the single seat S-1 but is larger overall, and generally regarded as a more capable aerobatic aircraft due to its larger size and heavier weight, more power and aerodynamic changes. For this reason the S-2 is also built in single seat 195kW (260hp) AEIO-540 powered S-2S form (kit version S-2SE), while two seat models are the S-2 with a 135kW (180hp) Lycoming O-360-B4A with fixed pitch propeller (kit version S-2E), the S-2A with a 150kW (200hp) IO-360-A1A with constant speed propeller (kit version S-2AE), and the S-2B with a 195kW (260hp) AEIO-540 engine and with wings and landing gear moved forward 10cm (4in). The S-2B is fully aerobatic with two occupants. The S-2C has aerodynamic changes including square wingtips, fin and tailplanes, flattened belly, refined engine cowl and redesigned windshield. It cruises 24km/h (13kt) faster than the S-2B.

The Pitts Special has been factory built by Aerotek, Christen, and currently Aviat.

Plans and components for the S-1C and S-1SS (S-1S with the aileron technology of the S-1-11B Super Stinker) are currently available from Steen Aero Lab.




 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Piper PA-60 Aerostar ',51647237.0,'img/0794244-v40-6.jpg',' The Aerostar - which in its higher powered forms can lay claim to being the fastest piston twin GA aircraft built - was designed by Ted Smith, who was also responsible for the Aero Commander twins.

Smith''s original intention in designing the Aerostar was to develop a family of single and piston twins, twin turboprop and even twin jet powered versions of the same basic aircraft. However the Aerostar appeared in piston twin form only. Smith began design work on the Aerostar in late 1964, with a prototype making its first flight two years later in November 1966.

The prototype was powered by 120kW (160hp) Lycoming IO-320s, but the Aerostar was placed into production from 1968 as the Aerostar 600 with 215kW (290hp) IO-540s. The turbocharged Aerostar 601 followed the 600 into production shortly afterwards, while the turbocharged and pressurised 601P went into production in 1972. By this time Butler Aviation had acquired the production rights of the Aerostar in 1970, producing a small number as Butler Aerostars. Smith bought the line back again in 1972, and his new company Ted R Smith and Associates resumed Aerostar manufacture, including of the improved 601B with the same span wings as on the 601P, until Piper acquired the Aerostar line in March 1978.

Piper continued production of the 600A, 601B and 601P at Ted Smith''s Santa Maria plant, and introduced the 602P with low compression TIO-540-AA1A5 engines.

When Piper transferred production to its new Vero Beach, Florida factory in early 1982, only the 602P was in production, and this was redesignated the PA-60-602P. The PA-60-700P was the last Aerostar version, and just 25 were built. In production between 1983 and 1985, the 700P has more powerful engines, a higher max takeoff weight and optional extra fuel capacity.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('PZL Swidnik W3 Sokol ',41507928.0,'img/0147620-v40-6.jpg',' The W3 Sokol (Falcon) utility is the first helicopter to be fully designed and built in Poland, and is PZL Swidnik''s most promising sales prospect in the near to medium future.

Developed during the mid 1970s, the Sokol made its first flight on November 16 1979, and has since been certificated in Poland, Russia, the US and Germany. Following a fairly protracted development program, low rate production of the Sokol commenced during 1985. Initial sales of the general purpose Sokol were within Poland and in the Eastern Bloc, before the collapse of communism allowed PZL Swidnik to broaden its sales base. To do this PZL Swidnik developed the improved W3A Sokol aimed at achieving western certification. Certification to US FAR Pt 29 standards was granted in May 1993, while German certification was granted in December that year.

The Sokol is of conventional design and construction, with two PZL10W turboshafts, which are based on the Russian designed TVD10B turboprops that power the Polish built An-28. Composites are used in the tail and main rotor blades.

The Sokol is offered in a number of variants and is capable of performing a typical range of helicopter missions, including passenger transport, VIP, cargo, EMS, medevac, firefighting and search and rescue (the W3 RM Anaconda).

An upgraded version of the Sokol is currently under development. The SW5 (a provisional designation) would have twin FADEC equipped 745kW (1000shp) Pratt & Whitney Canada PT6B-67B turboshafts, Sextant supplied avionics, a simplified rotor head and greater use of composites.

 ',' Poland ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('PZL Swidnik SW4 ',37536223.0,'img/0131528-v40-6.jpg',' The origins of PZL Swidnik''s SW4 five seat light utility helicopter date back to the early 1980s. <p>Swidnik began development of a new four/five place light utility helicopter in 1981. This original SW4 was to have been powered by a 300kW (400shp) PZL Rzeszow GTD350 turboshaft and was built in mockup form. It would have had a top speed of 240km/h (130kt) and a max range with auxiliary fuel of 900km (485nm). <p>The collapse of the Iron Curtain allowed Swidnik to substantially redesign the SW4, based around the Allison 250 turboshaft. Aside from the powerplant, design changes included a more streamlined fuselage and revised tail and tailboom. <p>The first prototype, a non flying ground test aircraft, was rolled out in December 1994. Two flying prototypes have been built, the first of which was completed in 1996 and first flew on October 26 that year. <p>PZL Swidnik aims to attain US FAA FAR Part 27 certification for the SW4 which will allow it to enter production in 1999. The program was delayed somewhat when PZL Swidnik decided to redesign the rotor head, enlarge the horizontal stabiliser and improve the hydraulic system. <p>Once the basic Allison powered SW4 is certificated and in production PZL Swidnik aims to offer a Pratt & Whitney Canada PW200 powered variant. A twin engine model is also planned to allow the helicopter to meet forthcoming European regulations which will restrict single engine helicopter operations under some conditions. <p>The SW4 is expected to be able to fulfil a range of utility missions ranging from executive transport to medevac and police roles. Border patrol and military pilot training are other planned missions. <p> ',' Poland ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Piper PA-46 Malibu/Malibu Mirage ',56916146.0,'img/0687925-v40-6.jpg',' According to Piper the all new PA-46 Malibu was the first pressurised cabin class piston single. It promised to be one of the first of a new generation of light aircraft introduced from the early 1980s before recession and oppressive liability laws in the USA strangled the GA industry. Nevertheless, the PA-46 has sold relatively strongly.

Announced in November 1982, the Malibu was intended to compete against Cessna''s pressurised P210 Centurion, plus older light business twins. Designed with the aid of CAD/CAM (Computer Aided Design/Computer Aided Manufacture), an unpressurized experimental prototype, the PA-46-300T, flew for the first time on November 30, 1979. The prototype for the first production model, the pressurized PA-46-310P, first flew in August 1982. Certification was awarded in September 1983, with production deliveries from that November.

Features of the first production model PA-46-310P included the specially developed turbocharged 230kW (310hp) Continental TSIO-520, a high aspect ratio wing, a relatively roomy cabin with club seating for four behind the pilot, a rear airstair style door, IFR avionics as standard, and cabin pressurisation.

The improved PA-46-350P Malibu Mirage, first flight December 21, 1987, replaced the 310P Malibu in production from October 1988. The major change introduced on the Malibu Mirage was the 260kW (350hp) Textron Lycoming TIO-540-AE2A, while other changes included a new electrical system and revised interior.

Since 1994 New Piper has made a number of minor improvements to the Malibu Mirage including to the brakes, autopilot and air-conditioning. In 1999 the Mirages gained the strengthened wing of the turboprop Malibu Meridian development, allowing an 18kg (40lb) increase in max takeoff weight. The Mirage is also offered with conventional and EFIS avionics packages. Production ceased temporarily in 2001 to allow Piper to concentrate on introducing the Meridian to production, but was later resumed. Production is continuing alongside the turboprop PA-46-500TP Malibu Meridian (see separate entry).

A turboprop conversion is available from Jetprop as the DLX (see Malibu Meridian entry).



 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Piper PA-46 Malibu Meridian ',2058025.0,'img/0229340-v40-6.jpg',' The Malibu Meridian is the first major aircraft program from New Piper Aircraft Inc and is a high performance turboprop development of the popular Malibu Mirage.

New Piper announced development of the Meridian at the 1997 NBAA convention. The aircraft was rolled out at Piper''s Vero Beach, Florida facilities on August 13 1998 and this aircraft (an aerodynamically conforming prototype) flew for the first time on August 21 that year. Three further Meridian prototypes will enter the flight test program during 1999. Certification was awarded on September 27 2000, with the first customer delivery on November 7 2000.

The Meridian''s most obvious feature compared with the Malibu is its Pratt & Whitney Canada PT6A-42A turboprop. The -42A has a thermodynamic rating of 901kW (1209shp) but on the Meridian is derated to 373kW (500shp) for takeoff, which allows the engine to maintain max power through to the aircraft''s 30,000ft ceiling, giving a 485km/h (262kt) cruising speed.

Major sections of the Meridian''s fuselage are common with the Malibu''s but the turboprop features a number of significant changes, including a stainless steel firewall, chord lengthening wing root gloves which increase wing area to ensure a relatively low stall speed, increased area horizontal tail and rudder, and increased fuel capacity.

The Meridian also has a completely new instrument panel. Standard equipment includes a three axis S-TEC 550 autopilot which is coupled to the dual 13cm (5in) colour LCD Garmin GNS 530 integrated GPS displays incorporating IFR GPS and VOR/ILS receiver with glidescope, and a Meggitt Engine Instrument Display System comprising dual LCDs presenting engine information (such as torque, temperatures and pressures, propeller RPM, outside air temperature and fuel level at destination and time to destination calculations).

An optional Electronic Flight Display System (EFDS) presents flight information on four Meggitt colour LCDs (two per side), comprising dual primary flight displays and dual navigation displays. Conventional flight instrumentation is standard.

A rival turboprop Malibu is the Jetprop DLX which is a conversion of piston-engined PA-46s. The first 88 conversions are powered by a Pratt & Whitney PT6A-34, from the 89th aircraft the 417kW (560shp) PT6A-35 or the lower cost 410kW (550shp) PT6A-21 are installed.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Piper PA-44 Seminole ',41513341.0,'img/0559334-v40-6.jpg',' The PA-44 Seminole was developed during the heyday of the GA industry in the mid to late 1970s but fell victim to the depressed market from the early 1980s plus the growing reliability and popularity of high performance big singles. As a result it has been built in only fairly modest numbers.

A contemporary of the Gulfstream GA-7 Cougar and Beechcraft 76 Duchess, the Seminole was conceived in part as a PA-30 Twin Comanche replacement, aimed at the self flying businessperson, plus the twin engine training market. Developed from the mid 1970s, the Seminole is a twin engined development of the PA-28R Arrow series, with the Arrow''s single engine replaced by two counter rotating 135kW (180hp) Lycoming O-360s, plus a new T-tail and semi tapered wings. The first flight of the prototype was made during May 1976, and production machines, designated PA-44-180, were delivered from May 1978.

The turbocharged PA-44-180T was introduced from 1980. Aside from turbocharged TO-360s, the Turbo Seminole introduced prop de-icing and an oxygen system. Just 86 PA-44-180Ts were built when Piper ceased production for the first time in late 1981. Piper reopened the Seminole line in 1988, with 30 non turbocharged PA-44s built before Piper once more suspending production in 1990, due to its parlous financial position at the time.

Once again the PA-44-180 Seminole is back in production, with manufacture restarting in 1995, although sales have been relatively modest. Piper currently offers two avionics packages for the Seminole, a standard fit and an Advanced Training Group package.

Interestingly the PA-44 is the only T-tail Piper currently in production, even though in the late 1970s most Piper aircraft had been modified to feature a T-tail.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Piper PA-36 Pawnee Brave ',89739493.0,'img/0236110-v40-6.jpg',' The PA-36 Pawnee Brave was designed in the late 60s at the company''s Vero Beach facility as a larger aircraft than Piper''s first purpose-designed agricultural aircraft, the PA-25 Pawnee, although of the same overall configuration.

The result of Piper research on PA-25 Pawnee operations, the first PA-36 prototype, the PA-36-260 Pawnee II, was powered by a 195kW (260hp) Lycoming O-540-E engine, and made the first flight on November 17, 1969. The Lycoming engine was later in the development program replaced by a 210kw (285hp) Continental Tiara 6-285 engine, and the aircraft became the PA-36-285. A second prototype had the same engine, and Piper decided to use this engine for the series production.

The PA-36 has a welded chrome-molybdenum steel tube fuselage structure with metal underskins and plastics side panels, and a sturdy overturn pylon is part of the structure. The wings have a conventional two-spar structure, with light alloy laminated spars, and light alloy covering, except for glassfibre leading-edges and wingtips. A hopper with a capacity of 30 or 38 cu.ft is in front of the pilot.

In mid 1972 the PA-36-285 received FAA approval, and in 1973 production got under way, while at the same time the name was changed from Pawnee II to Pawnee Brave.

As the Continental Tiara engine was quite problematic, Piper certificated a 225kW (300hp) Lycoming IO-540 powered version, the PA-36-300, which replaced the Tiara engined version on the production line from the 1977 model year.  From the 1978 model year, the name Pawnee Brave was changed to Brave 300.

A more powerful version was available from 1978, powered by a 280kW (375hp) Lycoming IO-720 in a restyled cowling, as the Brave 375, and from 1982 the 300kW (400hp) IO-720 powered Brave 400 followed.

Pawnee Brave production ceased in January 1983.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Piper PA-42 Cheyenne III/400 ',41699958.0,'img/0642982-v40-6.jpg',' Aimed directly at Beech''s successful King Air twin turboprop series, the PA-42 Cheyennes are larger developments of the earlier PA-31T Cheyennes (in turn themselves turboprop developments of the PA-31 Navajo).

The PA-42 Cheyenne III was announced in September 1977. The first production Cheyenne III flew for the first time on May 18 1979 and FAA certification was granted in early 1980. Compared with the Cheyenne II the PA-42 was about 1m (3ft) longer, was powered by 537kW (720shp) PT6A-41 turboshafts and introduced a T-tail, the most obvious external difference between the PA-31T and PA-42. Deliveries of production Cheyenne IIIs began on June 30 1980.

Development and improvement of the III led to the PA-42-720 Cheyenne IIIA, with PT6A-61 engines, a higher service ceiling and revised systems and interior.

The higher powered and significantly faster PA-42-1000 is basically similar to the PA-42-720 except for its far more powerful 745kW (1000hp) Garrett TPE331 turboprops driving four blade propellers. Piper''s largest and fastest production aircraft to date, the PA-42-1000 was initially called the Cheyenne IV, before becoming known as the Cheyenne 400LS, and then simply the Cheyenne 400. First flown on February 23 1983, the Cheyenne 400 was delivered from late 1984. Production of the PA-42 ended in February 1993.
 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Piper PA-38 Tomahawk ',32975605.0,'img/0714213-v40-6.jpg',' The PA-38 Tomahawk (nicknamed Tommy for short) was the first all new two seat trainer built by one of the USA''s big three GA manufacturers in almost three decades when it was introduced.

The PA-38-112 Tomahawk was designed as a relatively inexpensive to acquire and operate two seat trainer to tackle the firmly established definitive basic trainer in the 1970s, the Cessna 150 and 152, and to take over the spot in Piper''s model range then occupied by two seat variants of the PA-28 Cherokee series.

Design input for the Tomahawk came from a questionnaire Piper distributed randomly to 10,000 flight instructors during the mid 1970s. With their responses in mind (ideal characteristics included night lighting, dual toe brakes, a fuel selector accessible to both student and instructor, low noise levels, position lights and the ability to spin), Piper developed the PA-38. The resulting aircraft featured a T-tail and NASA Whitcomb GA(W)-1 design low set wing of constant chord and thickness (also featured on the competing but less succesful Beech Skipper), a cabin wider than the Cherokee''s (and thus much wider than the Cessna 150/152''s) with 360° vision and a Lycoming O-235 powerplant. Many parts, such as the main undercarriage wheels and elevators, were interchangeable.

Piper announced the development of the Tomahawk during late 1977 and first deliveries were made in early 1978. Despite an initial mixed reaction to the new trainer from the flying public, the Tomahawk was an instant sales success with over 1000 built in the first year of production alone. In service the Tomahawk proved to be economical to operate, but the aircraft was dogged by quality control problems (some 19 Airworthiness Directives were issued by the FAA in the PA-38''s first four years) and unpredictable stalling characteristics, resulting in a number of stall/spin accidents.

Flow strips were added to the wing on late production Tomahawks Is in September 1978 to improve the much criticised stall characteristics, while a number of other problems, including the poor quality control, were addressed in the improved Tomahawk II, which was introduced for the 1981 model year. Enhancements included improved sound proofing, windscreen defrosting, door latching and nose wheel design.

Piper ceased production of the Tomahawk during 1983.

 ',' United States of America ');





INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Piper PA-34 Seneca ',77139924.0,'img/0295912-v40-6.jpg',' The most successful six place light twin since its introduction, the Seneca is a twin engine development of the Cherokee Six.

Seneca development began when Piper flew a converted trimotor Cherokee Six, designated PA-32-3M, fitted with two additional 85kW (115hp) Lycomings O-235 on either wing. The subsequent twin engine prototype PA-34-180 Twin 6 first flew with two 135kW (180hp) Lycomings, while the definitive standard third Seneca prototype, the PA-34-200 Twin 6, first flew in October 1969 with fuel injected 150kW (200hp) IO-360s. Production deliveries of the initial PA-34-200 Seneca began in late 1971.

Handling and performance criticisms were addressed from the 1974 model year with the PA-34-200T Seneca II which introduced changes to the flight controls and, more importantly, two turbocharged Continental TSIO-360-Es. Piper originally planned that the follow-on PA-34-220T Seneca III would feature a T-tail, but these plans were dropped and the main changes introduced were counter rotating 165kW (220hp) TSIO-360s and a revised interior and instrument panel. Introduced in 1981, the Seneca III was replaced by New Piper''s improved PA-34-220T Seneca IV in 1994 with aerodynamic refinements, axisymetric engine inlets and a revised interior.

The current PA-34-220T Seneca V was introduced in January 1997. It features intercooled turbocharged L/TSIO-360-RB engines which maintain rated power to 19,500ft, and seating for five, with a standard entertainment/executive workstation with extendable worktable and optional phone/fax. A sixth seat in place of the workstation is optional.

The Seneca was also built or assembled by other manufacturers, AICSA in Colombia, Chincul in Argentina (as the PA-A-34), Embraer in Brazil (as the EMB-810), and PZL-Mielec in Poland (as the M-20 Mewa, partly with PZL/Franklin engines).

Conversions are made by Seguin as the Princess, and by Robertson as the Super Seneca I and II.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Piper PA-31T Cheyenne ',30075840.0,'img/0281214-v40-6.jpg',' The Piper Cheyenne family of turboprop corporate aircraft is based on the popular Navajo and Chieftain piston twins.

Although the first Cheyenne was not delivered until mid 1974, work on a turboprop version of the Pressurized Navajo dates back almost a decade earlier to the mid 1960s. The prototype of the Cheyenne flew for the first time on August 29 1969, but Piper had to redesign the flight controls to handle the increased loads on the airframe due to the higher speeds. Production deliveries were further delayed due to flooding at Piper''s Lock Haven plant in June 1972.

Certification had been granted on May 3 1972, while the first production aircraft (powered by 462kW/620shp PT6A-28s) first flew on October 22 1973.

Piper introduced the lower powered (373kW/500shp PT6A-11s) and less expensive Cheyenne I in 1978, and renamed the original Cheyenne the Cheyenne II. Refinements to the Cheyenne I made in 1983, including more power at altitude, revised cowlings and interior, resulted in the Cheyenne IA.

Meanwhile the stretched Cheyenne IIXL had been introduced in 1979. Compared with the standard length Cheyennes, the IIXL was 61cm (2ft) longer, featured an extra cabin window on the left side, 180kg (400lb) increased max takeoff weight and 560kW (750shp) PT6A-135s. An improved IIXLa was planned, but did not enter production.

The further stretched and T-tail PA-42 Cheyenne III was also introduced in 1978, and is described separately.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Piper PA-31 Navajo/Pressurized Navajo ',36270350.0,'img/0297060-v40-6.jpg',' The highly successful Navajo six/eight seat cabin class twin has been adapted to a number of commuter, charter, air taxi, light freight and executive transport roles, and has spawned a series of developments.

The PA-31 was developed at the request of company founder William T Piper, and the program for a new larger twin was given the project name Inca. The first prototype PA-31 made the type''s first flight on September 30 1964 and was Piper''s largest aircraft to be built to that time.

Deliveries began began in the first half of 1967. The first model was the PA-31-310, powered by two 230kW (310hp) turbocharged Lycoming TIO-540-A1A engines. A small number of the PA-31-300 with two normally aspirated 225kW (300hp) IO-540-M engines were also built in 1968 and 1969. The PA-31-310 had five cabin windows per side and Piper''s distinctive Tiger Shark engine nacelles with optional nacelle lockers. The PA-31-310 was further improved in late 1971 in the Navajo B and in 1974 in the Navajo C and the PA-31-325 Navajo C/R with counter rotating 242kW (325hp) TIO-540-F engines.

The PA-31P-425 Pressurized Navajo was aimed at the corporate market and had three windows on the right side and two on the left side of the cabin, geared  turbocharged and fuel injected TIGO-541-E1A engines, a higher takeoff weight and strengthened structure and undercarriage, optional extra fuel, a lengthened nose, and most importantly a cabin pressurisation system. First flown in March 1968, first deliveries took place from 1970, and it remained in production until 1984.

Meanwhile production of the PA-31-310 had ceased in 1983. Further developments of the Navajo, including the Chieftain, Mojave and Cheyenne, are described separately.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('PZL Swidnik (Mil) Mi2 & Kania ',23772986.0,'img/0562956-v40-6.jpg',' Poland''s most successful helicopter was originally developed in Russia by Mil, and in its Allison powered Kania (Kitty Hawk) version has achieved US certification.

Mil originally designed the light utility Mi2 in Russia during the early 1960s, resulting in a first flight in September 1961. In January 1964 an agreement between the USSR and Poland transferred development and production to the latter country, which commenced in 1965. The Mi2 evolved since that time and remained in low rate production into the 1990s. The main civil variant is simply designated Mi2, Swidnik also developed a diverse number of military variants.

The Kania (Kitty Hawk) is a substantial upgrade of the basic Mi2, and features Allison 250C20B turboshafts, western avionics, composite main and tail rotor blades, and has won US FAR Pt 29 certification. Developed in cooperation with Allison, the Kania first flew on June 3 1979, and US certification was granted in February 1986. The Kania has never entered full scale production but remains on offer, both as new build aircraft and as an upgrade of existing Mi2s.

 ',' Poland & Russia ');

INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Piper PA-28R Cherokee Arrow ',48937015.0,'img/0245567-v40-6.jpg',' The PA-28R originally began life as a retractable undercarriage variant of the PA-28 Cherokee.

The original PA-28R-180 Cherokee Arrow was a relatively simple adaptation of the existing PA-28-180 Cherokee D, but incorporated electro-hydraulically operated retractable undercarriage (complete with a self lowering system that safeguarded against the pilot failing to do so, automatically lowering when airspeed reached 170km/h/91kt and a certain engine manifold pressure), a fuel injected version of the PA-28-180''s O-360, a constant speed propeller and an increased max takeoff weight.

Production switched later to the more powerful 150kW (200hp) IO-360-C1C powered PA-28R-200 Cherokee Arrow II. Changes included the same 12.7cm (5in) stretched fuselage introduced on the Cherokee Challenger and Cherokee Charger, with greater rear legroom and baggage capacity, plus larger horizontal tail and dorsal fin fillet.

The PA-28R-201 Arrow III first flew in September 1975, and was introduced from 1976. The major change (also introduced on the fixed undercarriage PA-28s at that time) was a new longer tapered span wing, while the maximum takeoff weight was increased. The turbocharged PA-28R-201T was also offered.

The PA-28RT-201 and -201T Arrow IV introduced a new all moving T-tail. Production of the Arrow IV ceased in 1982, and resumed again in 1989, but ceased once more in 1992. Instead Piper returned the conventional-tailed Arrow III back into production. Very small numbers were built in the early 1990s while Piper was under bankruptcy protection. Since the emergence of New Piper Inc in 1995 the Arrow III has been part of the expanded Piper line-up, although only small numbers have been built.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Piper PA-25 Pawnee ',68106916.0,'img/0372901-v40-6.jpg',' The Piper PA-25 Pawnee was one of the first single seat light aircraft to be specifically designed and built for agricultural spraying and dusting. It was also one of the most successful, with several thousand built, and with licence production in a number of countries.

The PA-25 Pawnee was originally designed by Fred Weick as the AG-3, and flew in prototype form during 1957. The design was originally powered by a 110kW (150hp) Lycoming O-320, the fuselage structure was designed to absorb impact forces in a crash, the high cockpit had excellent all round vision, the braced wing was fitted with spray bars, while a jump seat could be fitted in the hopper.

Initial production was of the 110kW (150hp) powered Pawnee, which was delivered from August 1959. This was replaced by the 175kW (235hp) powered PA-25-235, and from 1968 the 195kw (260hp) PA-25-260 was available. The Pawnee B (235hp) introduced an enlarged hopper, the Pawnee C (235 or 260hp) followed with oleo type shock absorbers, while the ultimate Pawnee model, the Pawnee D (235 or 260hp) had the fuel tank moved from the fuselage to the wing.

Production ceased in 1982.

Many Pawnees have nowadays found their way to a glider airflield where they are very popular as glider tugs due to their good power/weight ratio.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Piper PA-28 Cherokee Series ',38215084.0,'img/0743954-v40-6.jpg',' The initial PA-28-150 and PA-28-160 Cherokees were introduced in 1961 as replacements for Piper''s PA-22 TriPacer and Colt.

Unlike the PA-22 series the new PA-28 was a low wing design with metal construction. The prototype Cherokee was powered by a 120kW (160hp) engine, and flew for the first time on January 14 1960. Production aircraft were powered by either 110kW (150hp) or 120kW (160hp) engines and were delivered from early 1961.

From 1962 a 135kW (180hp) version was added to the lineup. The 127kW (235hp) flat six Lycoming O-540 powered Cherokee 235 was introduced in 1963, while the two seat trainer optimised Colt replacement PA-28-140 entered the marketplace in 1964. With these models the basic PA-28 lineup was in place (the retractable PA-28R and larger PA-32 are described separately).

Subsequent variants include the Cherokee B and Cherokee C, the 180D, 235C, 140 Flite Liner two seat trainer PA-28-140, -180F, -235E, PA-28-180 Cherokee Challenger and PA-28-235 Cherokee Charger, the PA-28-180 Cherokee Archer and PA-28-235 Cherokee Pathfinder, PA-28-151 Cherokee Warrior which introduced the new tapered wing that would become a feature of subsequent PA-28s, PA-28-181 Cherokee Archer II and PA-28-236 Dakota (the Cherokee prefix was later dropped for the Archer II and Warrior), the PA-28-161 Warrior II, PA-28-201T Turbo Dakota and PA-28-161 Cadet.

Small numbers of Warriors, Dakotas and Archers were built in the early 1990s. The PA-28-181 Archer III, which features a new, streamlined cowling, was introduced in 1994. The 1999 models gained new paint, improved interior and a new avionics package. The PA-28-161 Warrior III features a new instrument panel and was introduced in late 1994. Since 1995 Piper has had new owners, and the brand has enjoyed a strong resurgence.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Piper PA-30/39 Twin Comanche ',90766919.0,'img/0572381-v40-6.jpg',' As its name implies, the Twin Comanche is a twin engine development of the PA-24 Comanche. When in production, it was Piper''s premier four/six place light twin, replacing the Apache 235 and positioned beneath the larger and more powerful Aztec.

The Twin Comanche was originally proposed as early as 1956, when the single engine Comanche was undergoing initial development, however the project was delayed while Piper worked on the Comanche and the Aztec twin. So it was not until 1962 that a Comanche was converted to a twin configuration with two 120kW (160hp) IO-320s (originally two 110kW (150hp) engines were planned), with first flight on November 7 1962. First flight of a production Twin Comanche was in May 1963, with first deliveries later that year.

The Twin Comanche differed little from its single engine brethren other than changes associated with its twin engine layout, and it quickly proved to be very popular. Improvements to the PA-30 resulted in the introduction of the Twin Comanche B in 1965, which featured a stretched fuselage allowing seating for up to six, as on the equivalent Comanche B single, while turbocharged engines and wingtip tanks were offered as options as the Turbo Twin Comanche B.

From 1970 the Twin Comanche C featured a slightly higher cruising speed and interior improvements, while the PA-39 Twin Comanche C/R was fitted with counter rotating engines.

Production of the Twin Comanche ceased in 1972 - by which time only the PA-39 was available - due to the flooding of Piper''s Lock Haven factory.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Piper PA-23 Apache/Aztec ',28148217.0,'img/0186830-v40-6.jpg',' The origins of the PA-23 Apache (one of the first widely available GA twins and Piper''s first "Indian") and the larger and more powerful Aztec lie in the early postwar Twin Stinson design.

Piper acquired the assets of Consolidated Vultee''s Stinson Aircraft division in 1948, and inherited a design study for a modern four place light twin. Piper left the design dormant for a few years until 1952 when it built a prototype aircraft, cn 23-01, based on the Stinson design. The low wing four seat twin was powered by 93kW (125hp) Lycoming O-290-D engines, had fabric covering, fixed undercarriage and a twin fin tail design.

Unsatisfactory flight trials led Piper to substantially redesign cn 23-01, introducing first more powerful 100kW (135hp) engines, then increasing power to (110kW) 150hp, metal construction, retractable undercarriage and a conventional tail unit. The redesigned twin flew for the first time on March 2 1952. Production deliveries began in March 1954.

The first variant was the PA-23-150 with some detail changes in subsequent model years before production switched to the more powerful PA-23-160 in late 1958. The Apache G and H introduced a third cabin window. A subsequent Apache development was the PA-23-235 Apache 235, a lower powered development of the PA-23-250 Aztec, introduced in 1962.

The Aztec is an enlarged and more powerful development of the Apache powered by two six cylinder 185kW (250hp) O-540s, and Aztecs were first delivered from early 1960. The Aztec B introduced a longer nose and seating for six, the Aztec C fuel injected engines, the optional Turbo Aztec C was turbocharged, while the Aztec D, E and F and corresponding turbo models introduced detail changes.

A military version for the US Navy was the UO-1, later renamed the U-11A. Except for radio, oxygen and propeller anti-icing equipment, this model was similar to the civil Aztec. Twenty were delivered in 1960. Some other air forces used Aztecs in small numbers.

A special version for the UK market with a gross weight of 2265kg (4995lb) instead of 2360kg (5200lb) was the PA-E23-250.

Production of the Aztec ceased in 1982.

Several Apache conversions with higher-powered engines, extended nose cone, fully enclosed wheel doors, square tipped rudder, etc were available as the Seguin Geronimo, the Miller Jet Profile and the Wilson Jet Profile. Some aircraft were only partly modified.

A floatplane modification of Aztecs adding also an additional door is offered by Melridge Aviation and Jobmaster Company as the Aztec Nomad.



 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Piper PA-24 Comanche ',89653689.0,'img/0413445-v40-6.jpg',' Piper''s PA-24 Comanche was a high performance retractable undercarriage single designed to challenge the established high performance Beech Bonanza.

Piper''s first low wing single engine design, the Comanche featured a retractable tricycle undercarriage, swept back tail, flying tail or "stabilator" horizontal tail surfaces, laminar flow wing and all metal construction, a stark contrast to Piper''s earlier high wing fabric covered designs. The Comanche first flew on May 24 1956 and was delivered to customers from late 1957 in PA-24-180 form.

Since then through to the cessation of production in June 1972 (due to flooding of Piper''s Lock Haven plant), a number of progressively higher performance variants were released. These included 1958''s 185kW (250hp) PA-24-250 and the 300kW (400hp) PA-24-400.

Just 148 400s were built, despite Piper claiming it to be the fastest production four seat single available at the time. Its massive eight cylinder IO-720 engine consumed fuel at a prodigious rate, meaning that it was expensive to operate, and there were problems with cooling the rear cylinders. Today however it has something of a mini cult status.

Following the PA-24-400 was the PA-24-260 from 1964, with a 195kW (260hp) O-540 or IO-540, and finally the Rajay turbocharger fitted PA-24-260 Turbo C, available from 1970.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Piper Cub ',33121509.0,'img/0534297-v40-6.jpg',' The simple and economical Cub is one of the most well loved light aircraft of all time, and helped make flying an affordable pastime for thousands of pilots in the years surrounding World War 2.

The Piper Cub began life as the Taylor E-2, designed by C.G. Taylor. In the middle of 1930, his company, Taylor Brothers Aircraft Corporation, went bankrupt. Businessman William Piper, who had made large profits from the oil industry, purchased the assets of the company and formed Taylor Aircraft Company with C.G. Taylor as the Chief Engineer.

Mr. Piper wanted to produce a simple and economic training aircraft, and the result was the E-2. The prototype was powered by a tiny 15kW (20hp) Brownbach Tiger Kitten engine. The aircraft was grossly underpowered with this engine, but at least, as Tiger Kitten equals Cub, it was the source of the model name for the E-2. After the Tiger Kitten had been replaced by a Salmson D-9 engine, real flight was finally achieved. However, as this French engine was built to metric sizes, the new 28kW(37hp) Continental A-40 was installed in the second E-2, and with this engine the Taylor E-2 Cub was certified on June 15 1931.

The company continued building the E-2 under the Taylor banner from 1931 to 1936, 348 being built in total.

While C.G. Taylor was ill, Walter Jamouneau reworked the E-2 Cub in early 1935, and the new type was named the J-2 Cub. It featured a revised tail shape, a fuselage with a faired-in rear turtledeck and a closed cockpit, a new airfoil wing with rounded wingtips, a redesigned cowling and a wider track undercarriage. Mr. Taylor was not happy with these developments and therefore decided to leave the company to form Taylor-Young Company.

The first experimental J-2 was a conversion of an E-2 and first flew in early 1935. The first production aircraft followed in December the same year. The aircraft was powered by the 28kW (37hp) Continental A40-3.

Effective November 1 1937 the company name was changed to Piper Aircraft Corporation, while continuing production of the J-2.

During 1936-37, the J-2 was improved and updated, resulting in the J-3 Cub. The affordable J-3 became a runaway sales success and several thousand were sold before the USA''s entry into WW2. From then on, all J-3 production was for the US Army Air Force, originally as the O-59 which quickly became the L-4. Also the US Navy ordered the aircraft, as the NE-1.

Prewar Piper also built the J-4 Cub Coupe with side by side seating and the three seat J-5 Cub Cruiser.

Postwar Piper reverted to civilian production with the J-3 later becoming the PA-11 Cub Special. Late build PA-11s were powered by a 65kW (90hp) Continental C-90 and had increased range. The PA-12 Super Cruiser has seating for three and a more powerful Lycoming O-235 engine, while the four seat PA-14 Family Cruiser formed the basis for the Super Cub.

 ',' United States of America ');

INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Piaggio P-166 ',32195783.0,'img/0243787-v40-6.jpg',' The Piaggio P-166 has been built in only small numbers but has been used in a wide variety of utility missions.

Intended for civil use when designed in the late 1950s, the P-166 features a large cabin which has been put to use in a variety of civil, military and quasi military roles, while its gull wing with tip tanks and pusher engines configuration like that on the P-136 amphibian, ensures it is easily identified.

The prototype P-166 first flew on November 16, 1957, and deliveries of the initial P-166AL-1 production model took place from April 1959. Just 23 were built before production switched to the P-166BL-2 Portofino, which featured more powerful 285kW (380hp) engines and an increased max takeoff weight of 3800kg (8377lb). Five Portofinos were built, while several earlier P-166s were converted to that standard with the more powerful engines.

The Italian Air Force received 51 of the military model, the P-166ML-1, for communication and training duties. This had an extra cockpit door, a larger main loading door, and a strengthened floor.

The P-166S Albatross was built for the South African Air Force as a search-and-rescue and surveillance version, twenty of which were built.

The P-166CL-2 was introduced in 1964 and featured a larger cabin and 3950kg (8708lb) max takeoff weight. It could seat 12 passengers but only two were built. It had an external landing gear pod.

The P-166DL-2 had an increased fuel capacity in the wingtip tanks, and a higher MTOW of 4100kg (9039lb).

The turboprop LTP-101 powered P-166DL-3 first flew in 1976 and was certificated in 1978. Alitalia has taken delivery of several for use as crew trainers, but most have been for the Italian government and military. Production of the radar and FLIR equipped P-166DL-3/SEM continued into the 1990s for the Italian Coastguard and it remains available on demand.

The 459kW (615shp) Pratt & Whitney PT6A-121 powered P-166DP-1 first flew in May 1999, eight have been ordered by the Italian Customs and Coastguard.

 ',' Italy ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Partenavia P-68 ',89532435.0,'img/0575104-v40-6.jpg',' Partenavia developed the P.68 as a multirole low maintenance and aerodynamically efficient twin capable of performing a number of utility roles.

The resulting P.68 Victor first flew on May 25 1970 and demonstrated performance similar to that of aircraft in its class (such as the Seneca) which had retractable undercarriage, but without the added weight and complexity of retractable gear. The high wing design also incorporated a large degree of glass fibre reinforced plastic construction in non load bearing areas. Thirteen preproduction P.68As were built between 1971 and 1973 before improved production standard P.68Bs, with a longer cabin, increased takeoff weight and redesigned instrument panel, were delivered from 1974. A retractable undercarriage variant, the P.68R, was trialled over 1976/77 but did not enter production.

The P.68C replaced the B in 1979 and introduced a longer nose to house weather radar and more avionics, extra fuel, revised cabin interior and redesigned wheel fairings. The turbocharged TC was introduced in 1980 and features two turbocharged 157kW (210hp) TIO360s. Observer versions of both the P.68B and P.68C have been built, these featuring a clear nose section for helicopterlike visibility.

A turboprop development, the AT.68TP300 Spartacus, first flew in 1978, and led to the larger AP.68TP Viator, which is in Italian government service.

 ',' Italy ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Pilatus PC6 Porter & Turbo Porter ',59021784.0,'img/0063789-v40-6.jpg',' The Pilatus Porter and Turbo Porter STOL utilities are renowned for their exceptional STOL performance and low speed handling and have sold strongly on the strength of their performance.

The high wing taildragger Porter was designed to perform a range of utility roles, and flew for the first time on May 4 1959. The first production aircraft built were delivered from 1960 and were powered by a six cylinder GSO480 piston engine, but it was not long after that a turboprop powered development flew.

The first PC6/A Turbo Porter flew in May 1961, powered by a 390kW (523shp) Turboméca Astazou II turboprop. The majority of PC6s are PC6/Bs, powered by the Pratt & Whitney Canada PT6A. PC6/Cs were powered by a 310kW (575shp) AiResearch TPE331, and were first delivered in 1965.

Smaller numbers of piston powered Porters have been built with Lycoming GSO480s and IGO540s in parallel with Turbo Porters.

The PC6/B was first delivered from 1964 and remains in production today. Initial models were powered by the 410kW (550shp) PT6A6 or 20. The PC6/B2H2 was first flown in 1970 and introduced the PT6A27 and an increased maximum takeoff weight.

Current Porter production is of the PC6/B2H4 with a further increase in max takeoff weight, larger dorsal fin fillet, revised wingtips, strengthened airframe structure and improved undercarriage.

 ',' Switzerland ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Pilatus PC12 ',75008144.0,'img/0055593-v40-6.jpg',' The PC-12 is a King Air class and size turboprop aimed at corporate transport and regional airliner operators. It is the latest in a line of single engined PT6 powered Pilatus products.

Pilatus announced it was developing the PC-12 at the National Business Aircraft Association''s annual convention in October 1989. First flight of the first of two prototypes occurred on May 31 1991. Certification was originally planned for mid 1993 but a redesign of the wings with the addition of winglets to ensure performance guarantees were met pushed this back, with Swiss certification awarded on March 30 1994 and US FAA FAR Part 23 approval following on July 15 1994.

Compared to the King Air 200 twin, its major competitor, the PC-12''s most significant design feature is its use of a single PT6A-67B turboshaft. Internally the PC-12''s cabin is also longer (by 6cm/2.4in) and wider (by 15cm/6in) than the King Air 200''s, and the same height. The cockpit features EFIS displays and the PC-12 is certificated for single pilot operation while each PC-12 built features a standard cargo door in the rear fuselage. Weather radar is an option but has been fitted to all production aircraft thus far. From 1997 the increased 4.5 tonne MTOW has been standard. New, smaller winglets were introduced in 1998.

The PC-12 is offered in standard nine seat airliner form, in a four passenger seat/freight combi version and as a six place corporate transport. A pure freighter model is under consideration. The PC-12 Eagle is a military special missions platform.

Most PC-12s built thus far have been corporate transports but recent important regulatory changes in Australia, Brazil, Canada and the USA have cleared single engine turboprops for IFR RPT operations in those nations. This has opened up new potential markets for the PC12 as a regional airliner, replacing older King Airs and elderly piston twins such as the Navajo Chieftain and Cessna 400 series.

 ',' Switzerland ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Piaggio P.180 Avanti ',85100213.0,'img/0013548-v40-6.jpg',' The innovative Avanti has been a slow seller despite its modern features, and jet like performance but turboprop operating costs.

Development of the Avanti dates back to program launch in 1981. Gates Learjet participated in Avanti development from 1983 and would have built the Avanti''s forward fuselage, but instead withdrew from the program in January 1986. Not deterred by Gates'' withdrawal, Piaggio assumed total control of the program, and all tooling and three forward fuselages for what would have been the Learjet P.180 were transferred to Italy.

Piaggio flew the first of two P.180 prototypes on September 23 1986, the second flew in May 1987. Italian certification was granted in March 1990, the first production Avanti flew that May and the first customer delivery took place in September 1990.

The unorthodox Avanti remains unique for a corporate aircraft in that it features three flying surfaces - the canard foreplane, wing and tail. This arrangement not only offers the benefits of the canard, but meant the wing could be positioned in the rear of the fuselage, so that it didn''t intrude on available interior cabin space. The small natural laminar flow wing was designed by the Ohio State University. The pusher engine configuration was chosen to reduce cabin noise.

Composites are used in a number of areas, including the tail, engine nacelles, canards, outboard wing flaps, landing gear doors and the tail cone, but generally, unlike the Beech Starship, most construction is conventional. A three screen Collins EFIS flightdeck is standard, a five screen suite is offered as an option.

Twice Piaggio has increased the P.180''s maximum weight, thus improving its payload range.

In November 1998 Piaggio was purchased by Tushav of Turkey, which planned to develop a stretched, jet powered development.

 ',' Italy ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Noorduyn Norseman ',83797784.0,'img/0288269-v40-6.jpg',' The rugged Norseman bush aircraft first flew in the mid 1930s, and so its long in service record is equal to that of the legendary Douglas DC-3.

The Norseman was designed by Robert Noorduyn, who was born in Holland and later worked for several prominent aircraft companies in England and the USA, including Armstrong Whitworth, British Aerial Transport, Sopwith, Fokker (in the USA where he worked on the F-7/3m), Bellanca and Pitcairn. In 1934 Noorduyn formed Noorduyn Aircraft Ltd (Noorduyn Aviation from 1938). Later in 1934 Noorduyn began work on the Norseman, resulting in the first flight of the float equipped prototype Norseman I from the St Lawrence River on November 14 1935.

The Norseman I prototype was powered by a 315kW (420hp) Wright Whirlwind, featured spruce wing spars and a metal tubing fuselage frame with fabric covering. It was the first Canadian aircraft with flaps.

Further development resulted in the heavier Norseman II production aircraft, and the 335kW (450hp) P&W Wasp Junior powered Norseman III. The 415kW (550hp) Norseman IV was the subject of significant Royal Canadian Air Force and civil orders in 1938.

The USA''s entry into WW2 in late 1941 saw the US Army Air Force take delivery of 746 Norsemans in YC-64, UC-64A (originally C-64A), and UC-64B variants. These aircraft operated in many theatres and were sometimes equipped with floats or skis. Other air forces that operated the Norseman were Canada, Australia, Brazil, Netherlands East Indies, Honduras, Indonesia, Norway, Sweden, and the US Navy.

The Norseman V, which was produced from the end of WW2 by Noorduyn and later by CCF, is the civil equivalent of the UC-64A.

With the aircraft no longer needed for war, Noorduyn production ceased in 1945 and its Cartierville plant was taken over by Canadair. However through to 1959 Canadian Car and Foundry built small numbers of Norseman Vs for civil customers.

CCF developed a new version, the Norseman VII, with all-metal wings and tailplane, a 91.4cm (3ft) longer cabin, and the engine moved forward 30.5cm (12in). The aircraft was converted from a Norseman V, and the first flight was made in Montreal in the autumn of 1951. It was however never certificated and not taken into production.

After the war many ex military Norsemans found gainful use with civil operators, and even to this day approximately 18 fly in Canada.

 ',' Canada ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Pacific Aerospace CT-4 Airtrainer ',27240455.0,'img/0384911-v40-6.jpg',' Dubbed the Plastic Parrot in Royal Australian Air Force service, the CT-4 Airtrainer was primarily designed as a military trainer, but is also in limited civilian use.

The CT-4 was developed from the Australian Victa Airtourer series (described separately). Victa had developed the four place Aircruiser (first flight in mid 1966) based on the Airtourer, but development work ceased and instead the production rights for the Aircruiser were purchased by Aero Engine Services Ltd (or AESL) of New Zealand in 1969, which already had the rights to the Airtourer series.

AESL made a number of changes to the basic Aircruiser design, including adding a new clamshell canopy, structural strengthening for aerobatic work, and stick controls, making it suitable for military basic training. The first such CT-4 Airtrainer flew on February 23 1972. This prototype was powered by a 157kW (210hp) Teledyne Continental IO-360-D engine.

On April 1 1973 AESL merged with Air Parts (NZ) Ltd as New Zealand Aerospace Industries Ltd. Delivery of the first production model, the CT-4A, started in October 1973. The CT-4A differed from the CT-4 prototype in having an IO-360-H engine, a longer cockpit canopy, a larger dorsal fin fairing, and some other improvements. Primary customers were the Australian, New Zealand and Thai air forces. The CT-4B was a version with some minor modifications for civil certification. Production by New Zealand (also known as NZAI) continued until 1977.

In 1990 Pacific Aerospace Corporation (the successor to NZAI) resumed production of the CT-4B against an order from the BAe/Ansett Flying College (later BAe Flight Training) in Tamworth, Australia, providing the impetus for further developments of the line.

A turboprop Allison 250 powered CT-4C (a conversion of an ex RAAF CT-4A) flew on January 21 1991, and a retractable undercarriage version, the CT-4CR was proposed but not built. Development of the 225kW (300hp) IO-540 powered CT-4E was aimed for the US Air Force''s Enhanced Flight Screening competition. Thirty two CT-4Es have been built, including 13 for the Royal New Zealand Air Force to replace CT-4As (10 of which were refurbished and sold to British Aerospace Flight Training in Australia). Production is continuing.

 ',' New Zealand ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Pacific Aerospace Fletcher FU-24 & Cresco ',10831349.0,' Fletcher in the USA originally developed the FU-24 largely for agwork in New Zealand.

The FU-24 flew for the first time in June 1954, and production and deliveries began during 1955, following certification on July 22. Seventy 195kW (260hp) Continental IO-470-D powered FU-24s and dual control FU-24As were built in the USA before Fletcher ceased production in 1964, and Air Parts (now Pacific Aerospace) of New Zealand acquired the production rights.

Initial New Zealand production was of two models, one powered by a 215kW (285hp) Continental, the other a 225kW (300hp) unit. The subsequent FU-24-950 was powered by a 300kW (400hp) eight cylinder Lycoming IO-720, and was followed up by the similarly powered FU-24-954 from 1979.

Like many ag aircraft, the Fletcher was a natural candidate for conversion to turboprop power. The resulting Cresco first flew on February 28 1979 powered by a 450kW (600shp) Avco Lycoming (now Textron Lycoming) LTP-101. Nine such aircraft were built, while a tenth was fitted with a 560kW (750shp) PT6A-34AG.

Although PAC announced it would cease aircraft manufacture in 1994, PAC''s new owners have placed the Cresco back into production. Initial production was of the LTP-101 powered Cresco 08-600, now the focus is on the PT6A powered Cresco 08-750.

PAC also offers turbine FU-24 conversions with PT6s or Walter 601s.

 ',' New Zealand ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Mooney M-20J to M-20S ',42895924.0,'img/0122900-v40-6.jpg',' Mooney''s new owners, the Republic Steel Company, placed the M-20 line back into production in late 1973.

All three then current models, the Ranger, Chaparral and Executive, were returned to production, but new design efforts centred around the M-20F Executive design. The first model developed was the M-20J 201, with improvements aimed at reducing drag giving a theoretical top speed of 323km/h (175kt), or 201mph. The 201 entered production in 1976, replacing the Executive, while the Ranger remained in production until 1979.

Subsequent models included the M-20K 231 from late 1978, powered by a turbocharged Continental TSIO-360 six cylinder engine, and the 201LM (Lean Machine) from 1986 with only basic options. The 201 evolved into the M-20J 205 with rounded cabin windows and redesigned wingtips, giving a slight increase in top speed. A Special Edition ''SE'' luxury options package was also offered. The M-20K 252TSE (Turbo Special Edition) was a development of the 231 with a top speed of 405km/h (220kt), or 252mph, and combined the 205''s airframe mods with a 155kW (210hp) turbocharged, intercooled Continental TSIO-360. The Porsche PFM-3200 powered M-20L was built between 1987 and 1991.

The current top of the line model is the Bravo - formerly the M-20M TLS/Bravo (Turbo Lycoming Sabre) - which was introduced in 1989 and features a slightly stretched fuselage, a turbocharged and intercooled Textron Lycoming TIO-540 and three blade prop.

The Allegro - formerly the M-20J MSE 205 - development is powered by a 150kW (200hp) Textron Lycoming IO-360A3B6D.

Introduced in 1994, the M-20R Ovation is based on the Bravo fuselage but is powered by a 210kW (280hp) Continental IO-550G flat six.

In 1997 Mooney introduce the short lived 370km/h (200kt) cruise M-20K Encore which was powered by a turbocharged TSIO360.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Mooney M-20 to M-20G ',60237302.0,'img/0202904-v40-6.jpg',' Before Al Mooney started his own company, he had already designed seventeen aircraft when he was working for Alexander, Bellanca, Monocoupe and Culver, including the popular Culver Cadet and a series of target drones for the army during WWII. The first product of the new Mooney Aircraft Corporation was the 1948 wooden single seat M-18 Mite. But he wished to extend his ideas for efficient, affordable aircraft to a larger, four seat design of metal and wood construction with fabric covering.

This was the Mooney M-20 which first flew on August 10 1953. The M-20 was powered by a 105kW (145hp) six cylinder Continental O-300 flat six engine, had retractable undercarriage and introduced the distinctive forward swept tail. It was placed into production soon after with a 110kW (150hp) Lycoming O-320, and a prolific series of developments followed.

These included the 700 plus M-20As with a 135kW (180hp) O-360, and the similarly powered M-20C Mark 21. Very successful with 400 built in its first year, the Mark 21 featured an all metal structure and higher takeoff weight. A lower spec fixed undercarriage version, the M-20D Master was also offered. The subsequent M-20E Super 21 flew for the first time in July 1963 and featured a more powerful fuel injected 150kW (200hp) IO-360 engine, combining the M-20E''s clean aerodynamics and the more powerful engine to give a claimed top speed of 317km/h (171kt). From the mid 1960s all models gained a small fin fillet and a larger squared off rear cabin window.

The M-20F Executive 21 of 1965 was based on the M-20E Super 21 and had a 25cm (10in) fuselage stretch and an extra cabin window on each side, new cabin fittings and extra fuel. In 1967 the range was renamed, the M-20C becoming the Ranger, the M-20F continued as the Executive, the M-20E was discontinued for a time until reappearing as the Chaparral, and a new model, the M-20G Statesman (with the Executive''s fuselage and a 135kW/180hp engine) appeared (although only 183 were built).

For a time from 1970 Mooney was known as the Aerostar Aircraft Corporation, and the Ranger became the Aerostar 200, the Chaparral the 201 and Executive the 220. However this company ceased production in early 1972, and it was not until 1973 that revised models were built under the Mooney banner again (described separately).
 ',' United States of America ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Millicer M10 AirTourer ',41592684.0,' The Millicer M10 AirTourer is a modern development of the Victa Airtourer, a popular Australian built aerobatic two seater. <p>Millicer Aircraft Industries was set up in the mid 1990s to place the four seat Victa Aircruiser into production as the Millicer M9 Shrike. Millicer received a favourable response to its plans to reintroduce the Aircruiser to production but at the same time realised that there existed even greater demand for the two seat Airtourer. In December 1997, following protracted negotiations, Millicer acquired the design rights to the Airtourer from the Airtourer Cooperative (who had earlier purchased the design from New Zealand Aerospace Industries) and since then has focused its primary efforts on improving the basic aircraft and returning it to production. Work on the AirCruiser (the Shrike name was dropped) continues at a slower pace. <p>Millicer is developing two basic AirTourer models, the basic M10-140 and the higher performance M10-160. The M10-140 is powered by a 105kW (140hp) Textron Lycoming O-320 (derated from 110kW/150hp, reducing noise), driving a two blade fixed pitch propeller, while the M10-160 features a 120kW (160hp) fuel injected IO-320 driving a constant speed propeller. <p>The new AirTourers feature substantial changes over their predecessors. These include a wet wing (in place of old bag type tank in the centresection), electric flaps, revised undercarriage, strengthened structure, modified wing tips, a new panel, new electrical system and others. <p>A prototype of the M10-160 (a rebuilt Airtourer rather than an all new aircraft) was the first of the new AirTourers to fly, which took place in September 1997, by which stage work on the first M10-140 was well advanced with first flight expected in February ''99. <p>Production AirTourers and AirCruisers will be built in a new purpose designed factory at West Sale Airport in Victoria. Millicer plans to build seven new build AirTourers in 1999 with production ramping up in 2000. <p> ',' Australia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Mitsubishi MU-2 ',66963339.0,'img/0319033-v40-6.jpg',' The MU-2 was one of postwar Japan''s most successful commercial aircraft types.

Development of the MU-2, Mitsubishi''s first indigenous postwar design, began in the late 1950s. Designed as a light twin turboprop transport suitable for a variety of civil and military roles, the MU-2 first flew on September 14 1963. This first MU-2 and the handful of MU-2As built were powered by Turboméca Astazou turboprops, all other models from the MU-2B onwards had Garrett TPE331s.

The MU-2 lineup can be divided up into two basic types, the standard fuselage and stretched fuselage models. The MU-2B, E, F, K, M, P and Solitaire feature the short fuselage, the others, including the Marquise, the stretched fuselage. The first stretched fuselage MU-2G flew on January 10 1969.

The MU-2 was progressively improved and upgraded throughout its production life. Notable changes include improved and more powerful TPE331 engines, and four blade propellers from the N and P models.

Mitsubishi established a production facility for MU-2s in San Angelo, Texas in the USA in 1967 to build MU-2s for the North American and world markets. The San Angelo Mitsubishi International facility became the sole source of MU-2 production until 1986 when the line finally closed.

Mitsubishi certificated all the civil TPE331 powered MU-2s as variants of the MU-2B and they were thus given the MU-2B type number followed by a number. However, these MU-2s were also given a separate marketing designation with a sequential suffix letter. The MU-2B-10 is e.g. the MU-2D, and the MU-2B-36A is the MU-2N.

Four MU-2Cs and 16 MU-2Ks were delivered to the Japanese Army as LR-1s for the liaison and photo reconnaissance role, while 29 MU-2Es were delivered two the Japanese Air Force as search-and-rescue MU-2Ss, equipped with an extended "thimble" nose radome, increased fuel capacity, bulged observation windows, and a sliding entry door for dropping rafts.

In 2000 over 500 MU-2s were in use as corporate transports (mainly in the USA), while many have been converted as freighters.

 ',' Japan ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Mil Mi-26 ',2001517.0,'img/2210790-v40-6.jpg',' Mil''s Mi-26 is the largest helicopter in the world by a significant margin, with a maximum takeoff weight greater than that of the Fokker F-100, more than twice that of the Boeing Chinook and an internal freight hold close in size to that in the L-100 Hercules.

Development of the Mi-26 began in the early 1970s and resulted in a first flight on December 14 1977. Although mainly in military use, the original design requirement stated that the helicopter would be for civil use, and that it should have a maximum takeoff weight one and a half times that of any previous helicopter. Pre-production machines were built from 1980, production machines sometime after that. The first Mi-26s are understood to have become operational with the Soviet military during 1983.

The Mi-26 is notable for its eight blade main rotor, powerful 7457kW (10,000shp) D-136 turboshaft engines and massive size, and several civil versions have been developed or proposed. These include the basic freighter Mi-26T, Mi-26A with automated approach and descent avionics, Mi-26MS medevac version, Mi-26P 63 passenger airliner, Mi-26TM flying crane with undernose gondola to allow supervision of sling operations, and Mi-26TZ fuel tanker.

The improved Mi-26M is under development and features new 10,700kW (14,350shp) class ZMKB Progress D127 turboshafts, better hot and high performance, increased maximum payload, composite main rotor blades, improved aerodynamics and EFIS flightdeck.

The Mi-26 has been exported to several countries, mostly for military service. They were delivered to the Air Forces of e.g. Uzbekistan, Kazakhstan, Ukraine, Belarus, Peru, India, Cambodia, and Mexico.

 ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('North American Rockwell 100 Darter/Lark Commander ',32653364.0,'img/0278286-v40-6.jpg',' Aero Commander developed the high wing four seat 100 series in an effort to expand its product range.

The Aero Commander 100 began life as a three seat design from Volaircraft of Aliquippa, Pennsylvania in the USA. The basic design was known as the Model 10 Volaire and flew for the first time during 1960. Features included a high wing, 360° all round visibility and metal construction. A handful of production aircraft, the Volaire 1035 powered by a 100kW (135hp) O-290-D and the four seat 110kW (150hp) O-320 powered Volaire 1050, were built before Aero Commander purchased the design and manufacturing rights for both on July 12 1965.

Aero Commander only made a small number of changes before the 1050 was placed into production as the Commander 100 (the 1035 was renamed the 100A) in the second half of 1965. From May 1968 Aero Commander incorporated a small number of changes including revised windscreen and rear cabin window designs and other mods and this model was renamed the Darter Commander .

By the time the first major changes to the basic design were introduced, Aero Commander had been taken over by North American Rockwell in 1967 and had become their Aero Commander Division. The name Aero Commander disappeared when the Division was renamed the General Aviation Division on September 9 1969. Darter production continued into 1969.

North American Rockwell also introduced the improved 100-180 Lark Commander in 1967 (FAA Type Approval was awarded on Sept 26 that year). Changes included a more powerful 135kW (180hp) O-360-A2F engine, a swept back fin, reprofiled cowling and 91kg (200lb) increase in max takeoff weight. The aerodynamic changes gave the Lark Commander a much more sleeker appearance, and the more powerful engine boosted performance. However Rockwell dumped Lark production in 1971, as it had been outsold and out performed by the less powerful Piper Cherokee and Cessna 172.

Rockwell sold the design and production rights for both the Darter (which had been out of production since 1969) and the Lark to Phoenix Aircraft in 1971, but the latter company did not undertake production.




 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Mil Mi-8/17 ',3662023.0,'img/0268287-v40-6.jpg',' Built in greater numbers than any other Russian helicopter, the Mi-8/Mi-17 series (NATO codename "Hip") was designed primarily as a military transport, but is also in widespread civil use.

The Mi-8 was designed as a replacement for the piston engined Mi-4, with design work beginning in May 1960. First flight of the prototype (powered by a single Soloviev turboshaft driving a four blade main rotor) occurred in June 1961, while a production standard Mi-8 flew in August 1962 and production began shortly afterwards. Versions of the Mi-8 built for civil use have square windows and include the Mi-8P passenger version, Mi-8T utility transport, Mi-8TM upgraded passenger transport with weather radar and Mi-8S Salon executive transport.

Production of the Mi-8 ceased in favour of the re-engined Mi-17, which was first publicly revealed to the west at the 1981 Paris Airshow. The Mi-17 introduced TV3 turboshafts and the tail rotor was relocated to the port side of the tailboom. Civil versions include the base Mi-17, and the essentially similar Mi-17-1 and Mi-17M, which both feature more powerful TV3-117VM turboshafts, and are built by Ulan Ude Aviation and Kazan Helicopters respectively. Both have been actively marketed in the west.

The Kazan/Mil developed Mi-17KF Kittiwake is designed to meet western certification standards and features an EFIS instrument panel with colour displays, designed and integrated by Kelowna Flightcraft in Canada, rounded "dolphin" nose with space for radar, and a rear loading ramp in place of the clamshell doors. The latter two features are also incorporated on the Kazan/Mil Mi-17MD and Mi-17N.


 ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Mil Mi-34 ',2001518.0,'img/1245152-v40-6.jpg',' At the time of its first flight, the Mi-34 was the smallest helicopter yet designed by Mil.

Despite only entering series production in 1993, the Mi-34 development story dates back to the mid 1980s, with a first flight in 1986. The Mi-34 was first exhibited to the west at the Paris Airshow in 1987 and has made a number of appearances at major airshows, including Farnborough, since that time.

The Mi-34 is the first helicopter designed in a former eastern bloc country that can loop and roll. More than 60 have been delivered, with missions including pilot training, observation and liaison missions. Many have been delivered to Russian government agencies and the police.

Power for the Mi-34 is supplied by the same M14 radial that powers the Sukhoi Su26, Su29 and Su31 aerobatic aircraft (described separately) among other Russian light aircraft designs. Mil has also studied variants of the Mi-34 with a Textron Lycoming TIO540 flat six piston engine and an Allison 250C20R turboshaft (as the Mi-34A).

The twin engine Mi-34 VAZ meanwhile was announced in mid 1993 along with a number of other Mil civil and military helicopters. The Mi-34 VAZ is essentially similar to the standard Mi-34 but is powered by twin VAZ430 rotary engines. While a rotary is perhaps an unusual choice of powerplant, the Mi-34 VAZ was being developed with the VAZ car factory, which may explain the engine selection. The Mi-34 VAZ also introduced a new carbonfibre star plate based rotor head. No known production has been undertaken.

 ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('NAMC YS-11 ',85033588.0,'img/0151329-v40-6.jpg',' The only Japanese airliner to enter production since WW2, the YS-11 achieved a degree of success in its domestic market and in North America.

The YS-11 was a product of the Nihon Aircraft Manufacturing Company (or NAMC), a consortium of Fuji, Kawasaki, Mitsubishi, Nippi, Shin Meiwa (now Shin Maywa) and Showa. NAMC formed on June 1, 1959 to design and develop a short to medium range airliner, with particular attention being paid to meeting the specific operating requirements of the Japanese domestic airlines.

NAMC selected the Rolls-Royce Dart over the Allison 501 to power the new airliner. Fuji was given responsibility for the tail unit, Kawasaki the wings and engine nacelles, Mitsubishi the forward fuselage and final assembly, Nippi the ailerons and flaps, Shin Meiwa the rear fuselage and Showa the light alloy honeycomb structural components.

The YS-11 first flew on August 30 1962 (a second prototype flew that December), and was awarded Japanese certification in August 1964. By that time the first production aircraft were under construction, and the type entered service with Toa Airways (now JAS) in April 1965. Initial production was of the YS-11-100, the follow up YS-11A-200 (first flight November 1967) was designed for export markets and featured an increased max takeoff weight. The YS-11A-300 was a combi passenger/freight model, while the YS-11A-400 was a pure freighter with a forward freight door.

The YS-11A-500, -600 and -700 were equivalent to the -200, -300 and -400, but with a 500kg (1100lb) greater max takeoff weight. Production ceased in February 1974.

By late 1998, 66 YS-11s remained in commercial service. The largest operators were All Nippon (6) and Japan Air Commuter (12).

 ',' Japan ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('North American/Ryan Navion ',19575447.0,'img/0268993-v40-6.jpg',' The Navion was designed in the late 1940s and built by four different companies through until the mid 1970s.

The company responsible for the original Navion was North American Aviation (famous for its WW2 P51 Mustang fighter). The end of WW2 saw massive military contracts cancelled en masse and so North American designed the original four seat NA145 to diversify out of military production. The NA145 Navion was powered by a 140kW (185hp) Continental and North American built more than 1100 in 1946 and 1947. North American also built a number of L17 observation aircraft based on the Navion for the US military.

Production and development of the Navion then transferred to Ryan. The standard Ryan production model was the Navion 205 or Navion A, which differed from the North American NA145 in that it was powered by a 155kW (205hp) Continental E185. More than 100 were built between 1948 and 1950. Ryan also built a few hundred Navion Super 260s or Navion Bs between 1950 and 1951, these aircraft were powered by a 195kW (260hp) Lycoming GO435. In addition Ryan also built almost 200 L17s (some saw military service in Korea).

The basic Navion design resurfaced in 1960 when the Navion Aircraft Company developed a five seater variant called the Rangemaster. The Rangemaster was powered by the same 195kW (260hp) Lycoming engine as the Navion Super 260, but instead of the rear sliding canopy of earlier Navions, the Rangemaster had a reprofiled, more streamlined five seat cabin. Later production Rangemasters had a smaller tail.

The Rangemaster was last built by the Navion Rangemaster Aircraft Corporation between 1974 and 1976 in improved G and H form.

Camair in the USA also converted a small number of Navions of various models to twin engine configuration, the first flew in 1953.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Piper PA-18 Super Cub ',74991270.0,'img/0490213-v40-6.jpg',' The Super Cub is one of Piper''s most successful and long lived aircraft programs, with production spanning over four decades.

The PA-18 Super Cub was the ultimate development of Piper''s original aircraft, the J-3 Cub (described separately). The four seat development of the Cub, the PA-14 Family Cruiser, was the basis for the Super Cub, but the later differed in having seating for two in tandem (as on the Cub), all metal wings and, in its initial form, a 65kW (90hp) Continental C-90 in the PA-18-90 or a 80kW (108hp) Lycoming O-235 engine in the PA-18-105. The Super Cub flew for the first time in 1949, and certification was awarded on November 18 that year. The first production Super Cubs were delivered from late 1949, the type replacing the PA-11 Cub Special on Piper''s production lines.

The 100kW (135hp) Lycoming O-290 powered PA-18-135 appeared in 1952, while the definitive 110kW (150hp) Lycoming O-320 powered PA-18-150 was certificated on October 1 1954 and delivered from the following year.

The Super Cub remained in production with Piper through until 1981, when almost 7500 had been built over an uninterrupted 32 year production run. Piper continued building Super Cubs on behalf of Texas based WTA who held the manufacturing and marketing rights from 1981 until 1988. In 1988 Piper resumed marketing responsibility for the Super Cub and continued low rate production. Financial troubles meant that Super Cub production ceased in 1992, before resuming once more the following year. Finally in late 1994 Piper announced that the Super Cub would not form part of its model line for 1995 and that it would cease production after the last of 24 on order for distributor Muncie Aviation were completed.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('MD Helicopters MD-600N ',15963935.0,'img/0753448-v40-6.jpg',' The MD-600N is a stretched eight seat development of the five seat MD-520N helicopter.

McDonnell Douglas Helicopter Systems (MD Helicopters since 1999) first announced it was developing a stretched MD-520N in late 1994, and unveiled the first flying prototype of the new helicopter, at that time designated the MD-630N, at the Heli Expo in Las Vegas in January 1995. This prototype, a modified MD-530F, had made its first flight on November 22 1994. The MD-630N created high levels of interest at the Heli Expo and McDonnell Douglas gave the go-ahead for the production aircraft, redesignated the MD-600N, in March 1995.

The prototype was modified to MD-600N standard with a production standard engine and tail boom and flew in November 1995, followed the next month by the first MD-600N production prototype. Unfortunately this second prototype was destroyed by fire following a forced landing in May 1996, caused by the main rotor contacting the tail boom during extreme control reversal tests.

Thus the third prototype, which first flew on August 9 1996, featured modifications to increase the main rotor-tail boom clearance. Certification was awarded on May 15 1997 with first deliveries beginning in June that year. Further performance improvements were certificated in mid 1998.

McDonnell Douglas stretched the MD-520N fuselage by inserting a plug aft of the cockpit/cabin bulkhead and stretching the NOTAR tail boom. The larger fuselage allows for an extra (middle) row of seats. Other differences compared with the MD-520N include a new six blade main rotor (the MD-520N has a five blade unit) and a more powerful Allison (now Rolls-Royce) 250 turboshaft.

Since the 1997 merger with Boeing the former McDonnell Douglas civil helicopter lines were up for sale. Bell''s plans to acquire the Boeing civil helicopter lines were thwarted by the US Federal Trade Commission (FTC) in 1998. However, in early 1999 Dutch owned MD Helicopters acquired the lines.

MD Helicopters developed a yaw stability augmentation system for the MD-600N to reduce pilot workload, which became available as an option from mid 2001.

Substantial numbers of the MD-600N were delivered to e.g. the United States Border Patrol and the Turkish Police.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('MD Helicopters MD-520N ',15963855.0,'img/1068816-v40-6.jpg',' The MD Helicopters MD-520N introduced a revolutionary advance in helicopter design as it dispensed with a conventional tail rotor in favour of the Hughes/McDonnell Douglas'' developed NOTAR (NO TAil Rotor) system.

Development of the revolutionary NOTAR system dates back to late 1975 when Hughes engineers began initial concept development work. In December 1981 Hughes flew an OH-6A fitted with NOTAR for the first time. This prototype was modified several times, notably in 1985 when it was fitted with the more streamlined MD-500E forward fuselage, an Allison 250-C20B turboshaft, a second blowing slot and a new fan. By then Hughes had become McDonnell Douglas.

Although the concept, which uses the Coanda effect, took some time to refine, the NOTAR system is simple in theory and works to provide directional control the same way a wing develops lift. Low pressure air is forced through two slots on the right side of the tailboom, causing the downwash from the main rotor to hug the tailboom, producing lift, and thus a measure of directional control. This is augmented by a direct jet thruster and vertical stabilisers.

NOTAR system benefits include far lower external noise (the MD-520N is the quietest certificated helicopter in the world), increased safety due to the lack of a tail rotor, improved handling and performance, reduced vibration and easier maintainability.

McDonnell Douglas originally intended to develop the standard MD-520N alongside the more powerful hot and high optimised MD-530N (both were launched in January 1989 and were based on the conventional MD-500E). The MD-530N was the first to fly, on December 29 1989, the MD-520N first flew on May 1 1990. Development of the MD-530N was suspended when McDonnell Douglas decided that the MD-520N met most customer requirements for the 530N. Certification for the MD-520N was awarded on September 13 1991, and the first was delivered on December 31 that year.


Following the 1997 Boeing/McDonnell Douglas merger, Boeing sold the former MD civil helicopter lines to MD Helicopters in early 1999.

At the 2000 Farnborough Airshow MD Helicopters announced enhancements to the MD-520N including an improved Rolls-Royce 250-C20R+ engine with 3-5% more power for better performance on warm days, and, with changes to the diffuser and fan rigging, increased range and payload capability.


 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('McDonnell Douglas MD-81/82/83/88 ',7892602.0,'img/0269439-v40-6.jpg',' The popular MD-80 series is a stretched and improved development of the McDonnell Douglas DC-9.

The origins of the MD-80 lie in 1975 testing where a standard DC-9 was fitted with improved, more efficient, higher bypass ratio JT8D-200 series turbofans. MDC originally proposed fitting the new engines (which meet Stage 3 noise limits) to a development designated the DC-9-55, which would have featured two JT8D-209s and a 3.86m (12ft 8in) stretched fuselage over the 50.

Instead MDC developed the DC-9 Super 80 (or DC-9-80), combining the new engines with a further stretched fuselage, increased span wing and other improvements. Launched in October 1977, the Super 80 first flew on October 18 1979. Certification for the initial Super 80 model, the 81, was granted in July 1981. The first customer delivery was to Swissair in September 1980.

McDonnell Douglas renamed the DC-9-80 the MD-80 in 1983. The MD-80 designation however is a generic designation for the series and does not apply to a certain model type. The specific MD-80 models are the initial MD-81, the MD-82 with more powerful JT8D-217s, the extended range MD-83 with extra fuel and more efficient JT8D-219s, and the MD-88 (first flight August 1987) with the JT8D-219s of the MD-83 with an EFIS flightdeck and redesigned cabin interior, with other improvements. The shorter fuselage but longer range MD-87 is described separately under McDonnell Douglas.

Initial sales of the Super 80 were slow until American Airlines placed an initial order for 67 MD-82s (with options on 100) in early 1984 (American now operates a fleet of 260 MD-80s), kickstarting what went on to become a highly successful program - the 1000th MD-80 was delivered in March 1992.

Following the 1997 merger of Boeing and McDonnell Douglas the future of the Douglas airliners were reviewed. In December 1997 Boeing announced its decision to drop the MD-80 and MD-90 once current orders were fulfilled. An April 1998 TWA order for 24 MD-83s will see the MD-80 remain in production until January 2000.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('MD Helicopters MD-500/530 ',29165082.0,'img/1013752-v40-6.jpg',' One of the world''s most successful and useful light turbine helicopters, the Hughes/McDonnell Douglas/MD Helicopters 500 series began life in response to a US Army requirement for a light observation helicopter.

Hughes won the US Army observation helicopter contest against competition from Bell and Hiller with its Allison 250 powered YOH-6A Cayuse, which first flew in February 1963. By then Hughes was already working on a civil variant, to be marketed as the Hughes 500. However, the engineering and certification designation for all military and civil variants of this helicopter type is Hughes Model 369. It was offered in basic five and seven seat configurations, and a 500U utility version. The 500 and 500U were powered by an Allison 250-C18A engine.

In 1970 the 500C followed with a more powerful 250-C20 turboshaft. From 1976 deliveries were of the 500D, an improved version with again a more powerful engine, the 250-C20B, a T-tail, and new five blade main and optional four blade tail rotors. The 500D was followed by the 500E from 1982 with recontoured nose and various interior improvements including greater head and leg room. The 530F (first delivery January 1984) is a more powerful version optimised for hot and high work.

McDonnell Douglas acquired Hughes Helicopters in January 1984, and in August 1985 the Hughes name disappeared. From then on the 500E and 530F were built as the MD-500E and MD-530F Lifter. After the 1997 merger with Boeing, the line was up for sale. Bell''s plans to acquire the Boeing civil helicopter lines were thwarted by the US Federal Trade Commission (FTC) in 1998. Then in January 1999 Boeing announced the sale of the light helicopter lines to MD Helicopters, a newly formed division of Netherlands based RDM Holdings. The sale was finalised in february 1999. In April 2000 MD Helicopters contracted Kaman to build the fuselages for the single engine MDs.

Military variants are marketed under the MD-500 Defender name.

License production was undertaken in Argentina by RACA, in Italy by BredaNardi (later merged with Agusta), in Japan by Kawasaki, and in South Korea by Korean Air.
 ',' United States of America ');

INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('McDonnell Douglas DC-9-40/50 ',23159264.0,'img/0467175-v40-6.jpg',' The DC-9-40 and DC-9-50 are stretched developments of the DC-9-30 and predecessors to the later further lengthened MD-80 and MD-90 series.

The DC-9-40 was developed in response to a Scandinavian Airlines System (SAS) requirement for a larger capacity development of the DC-9. Compared with the DC-9-30, the DC-9-40 is 1.88m (6ft 2in) longer, raising seating capacity in a single class configuration to 125. Apart from the fuselage stretch and more powerful engine options, the -40 was the much the same as the -30. First flight occurred on November 28 1967, and the -40 entered service with SAS on March 12 the following year.

The DC-9-50 is the largest member of the DC-9/MD-80/MD-90/717 family to bear the DC-9 designation. Launched in mid 1973, the DC-9-50 is a further 2.44m (8ft 0in) longer than the DC-9-40, or 4.34m (14ft 3in) longer than the DC-9-30, and has maximum seating for 139 passengers. Delivered from August 1975, the DC-9-50 introduced a new look cabin interior designed to make more efficient use of the space available and give the impression of a more spacious interior, plus other improved features such as an improved anti skid braking system and quieter engines compared with the DC-9-40.

The DC-9-40 and -50 sold only in fairly modest numbers before the arrival of the further stretched MD-80 series. The largest DC-9-40 customer was SAS, while Northwest continues to operate a large fleet of DC-9-40s and -50s (it is currently the largest DC-9 operator in the world).

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('McDonnell Douglas MD-90 ',53577338.0,'img/0073317-v40-6.jpg',' The MD-90 is the largest member of the Douglas/McDonnell Douglas/Boeing DC-9/MD-80/MD-90/717 family, and is a stretched, IAE V2500 powered development of the MD-80.

The MD-90 program was launched in November 1988, first flight occurred on February 22 1993, and certification was awarded on November 16 1994. Launch customer was Delta, which has 31 on firm order, while other major customers include Saudi Arabian Airlines and Japan Air System.

Most important of the changes introduced on the MD-90 are the two V2500 turbofans. At 111kN (25,000lb) thrust on the MD-90-30, the V2500s are the largest, heaviest and most powerful engines to be rear mounted on any airliner yet. More importantly though, the V2500 is highly regarded for its efficiency and fuel economy.

Other changes to the MD-90 include the 1.4m (4ft 6in) fuselage stretch forward of the wing, allowing seating for an extra 10 passengers (in a two class arrangement). The stretch is forward of the wing to compensate for the extra weight of the engines. The MD-90 also features an EFIS glass flightdeck based on that in the MD88, and other detail improvements such as a revised passenger interior.

The basic MD-90 model is the MD-90-30 (Chinese built Trunkliners are designated the MD-90-30T and feature double bogey main landing gear). It is also offered in MD-90-30ER extended range form with extra fuel. The MD-90 has also been offered as the 50, a further extended range version with a higher maximum takeoff weight and extra fuel and the MD-90-55 high capacity variant capable of seating 187 in a single class with two extra doors in the forward fuselage to meet emergency evacuation requirements.

Following the 1997 merger of Boeing and McDonnell Douglas, Boeing decided to cancel MD-90 production once outstanding orders were fulfilled.  The last of 114 US-built Md-90s was completed in 2000.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('McDonnell Douglas DC-9-10/20/30 ',18614547.0,'img/0433329-v40-6.jpg',' No other airliner in history has undergone more development than the prolific DC-9/MD-80/MD-90/717 series, which started life with the 70 seat DC-9-10 of the early sixties.

Douglas developed the DC-9 as a short range airliner complementing the much larger DC-8. Development was launched on April 8 1963, with a launch order from Delta following soon after. The DC-9 was an all new design, featuring rear fuselage mounted engines, a T-tail, moderately swept wings and seats for up to 90 passengers in a five abreast fuselage.

Construction of the prototype began in July 1963 and the first flight occurred on February 25 1965. Certification and service entry was on November 23 and December 8 1965, respectively.

From the outset the DC-9 had been designed with stretched larger capacity developments in mind. The first stretch resulted in the biggest selling DC-9, the 4.54m (14ft 11in) longer, 105 seat DC-9-30, which entered service with Eastern on February 1 1967. Subsequent stretched versions are described separately.

Small numbers of developed versions of the DC-9-10 were also built. The DC-9-20 featured the DC-9-10''s fuselage with the 30''s more powerful engines and longer span wings, giving better hot and high performance. The DC-9-15 was basically a -10 but with more fuel and higher weights. Factory built convertibles and pure freighters were also offered, while a number of DC-9-30s have been converted to freighters, and/or are having Stage 3 hushkits fitted, further extending their useful service lives.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('McDonnell Douglas MD-11 ',53577330.0,' The MD-11 is a modernised, slightly stretched and re-engined development of the DC-10 trijet.

Launched on December 30 1986 (following a launch order from British Caledonian for three placed earlier that month), the MD-11 was the result of a two year study to find a replacement for the DC-10. First flight occurred on January 10 1990, certification was granted in November that year, and the first one was delivered on December 7 1990 to Finnair.

Compared to the DC-10, the MD-11 features a 5.71m (18ft 9in) fuselage stretch, winglets, modified tail with less sweepback, an advanced two crew six screen EFIS flightdeck, restyled main cabin interior and new engine options. Variants offered were the longer range MD-11ER available from early 1996, MD-11F freighter, MD-11C Combi and MD-11CF convertible passenger/freighter models.

McDonnell Douglas at various times proposed MD-11 developments aimed at increasing seating through stretches and underfloor panorama deck seating. In 1996 MDC looked closely at the MD-XX, MD-11 variants with a new wing. Two versions were proposed, one with the standard MD-11 fuselage and a 15,565km (8400nm) range, the other a stretched 375 seater. These were not launched.

In November 1997 following the Boeing/McDonnell Douglas merger Boeing announced that the MD-11 would be retained in production, primarily as a freighter. However in June 1998 Boeing reversed that decision, saying that due to a lack of market demand production would be wound up. The last MD-11 built, a MD-11F for Lufthansa cargo, was delivered February 22 2001.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('McDonnell Douglas DC-10 & Boeing MD-10 ',77132811.0,'img/0316180-v40-6.jpg',' Designed in response to the same American Airlines requirement as the Lockheed TriStar, the DC-10, despite a sometimes troubled past, was the more successful of the two widebody trijets.

Although originally conceived as a twinjet, the DC-10 gained a third engine at the base of its vertical tail to meet an American Airlines requirement that the aircraft be capable of operating from existing runways. The DC-10 subsequently was launched in February 1968 with orders from American and United. First flight took place on August 29 1970.

The first transcontinental range DC-10-10s entered service with American in August 1971. By then work was already underway on the intercontinental range DC-10-30 which introduced more powerful engines, additional fuel tanks and a third main undercarriage unit.

Most DC-10s built were 30s (including convertible 30CFs and pure freight 30Fs), while the 40 is a Pratt & Whitney JT9D powered variant ordered by Northwest and JAL. The United States Air Force ordered 60 CF6 powered DC-10s as KC-10A Extender tanker transports.

A number of major and catastrophic accidents marred the DC-10''s service record in the mid to late 1970s, but the various causes of these accidents were overcome and the DC-10 continues to operate reliably. Production ceased in 1989.

The Boeing MD-10 conversion for Federal Express involves fitting DC-10s (both current freighters and "new" ex airliner freighter conversions) with a two crew Honeywell VIA 2000 EFIS flightdeck with six LCD screens. The instrument panel layout is identical to that in the MD-11, and pilots can be qualified to fly the two interchangeably. First flight was on April 4 1999, while the first of 89 MD-10 conversions for FedEx was delivered on May 9 2000 (the same day the conversion was certificated). Boeing is offering the MD-10 conversion to other DC-10 operators.







 ',' United States of America ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Luscombe Model 8 Silvaire ',90213600.0,' The Luscombe 8 Silvaire was a highly successful two seat high wing light aircraft built in the years surrounding World War 2. Today it remains popular as a classic aircraft.

Prior to introducing the Silvaire into production in 1937 Luscombe had built a small number of two seat high wing light aircraft, the most popular of which was the Phantom, which was powered by a 108kW (145hp) Warner Super Scarab radial engine. The initial Model 8 Silvaire was similar to the Phantom in configuration but differed in that it was powered by a 37kW (50hp) Continental A-50 engine. A more up market model, the 8A was also built from 1939, featuring a higher level of standard equipment, 50kW (65hp) Continental A-65 engine, and improved cabin trim. The 8B was similar to the 8A other than it was powered by a 48kW (65hp) Lycoming O-145 engine.

In 1941 Luscombe released the 8C which featured a 55kW (75hp) Continental engine, and the 8D, which differed in having wingtip fuel tanks. Over 1200 Model 8s were built through to early 1942 when production ceased due to the United States'' entry into WW2.

Shortly after the end of the war in late 1945 Luscombe resumed Silvaire production to meet the booming demand experienced by all US light aircraft manufacturers as returned military pilots wanted to continue flying in civilian life. From 1946 all Luscombes featured a new metal wing with a single strut. The first Silvaire to feature the new wing was the 8E, which was powered by a 65kW (85hp) Continental C85-12 engine.

The final Silvaire production model was the 8F, which featured a 65kW (90hp) Continental C90. The 8A SkyPal meanwhile was a lower powered variant of the 8F with a Continental A-65.

Financial difficulties forced Luscombe to cease trading in 1949. US company Temco took over production and built a small number before it too ceased production in 1950. Finally, some Silvaires were built by Silvaire Aircraft Company in Colorado between 1956 and 1960.

In 1998 a new plan emerged to re-introduce the 8F to production. Maryland based Renaissance Aircraft plans to re-certificate an improved 8F with modern instrumentation and avionics and powered by either a Lycoming O-320 or 110kW/145hp Walter Lom M-32, while production aircraft would be built by the Czech Aircraft Works. In 1999 a prototype was made from a refurbished original 8F. Renaissance quotes a unit price of $US71,200 (VFR) to 90,200 (IFR).

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Lockheed L-100 Hercules ',1414550.0,'img/0317174-v40-6.jpg',' Lockheed''s L-100 freighters are the civil equivalents of the venerable military C-130 Hercules, and have proven to be of great utility, particularly in undeveloped countries.

Lockheed initiated design of the Hercules in response to a 1951 US Air Force requirement for a turboprop powered freighter. This resulted in the C-130 Hercules, which first flew in prototype form on August 23 1954. Design features included the high mounted wing, four Allison 501/T56 turboprops and the rear loading freight ramp. The USAF ordered the C-130 into series production in September 1952, and since that time more than 2500 have been built.

The C-130''s appeal to freight operators led Lockheed to develop a civil version. The first commercial versions were based on the C-130E model, and a demilitarised demonstrator first flew in April 1964. This initial civil development, the L-100 (L-382), was awarded civil certification in February 1965. This model was soon followed up by the series L-100 (L-382B), which introduced an improved freight handling system.

Sales of these initial versions were slow, leading Lockheed to develop the 2.54m (8ft 4in) stretched L-100-20 (L-382E), which offered better freight capacity and operating economics. The L-100-20 was certificated in October 1968, but was soon followed by the even longer L-100-30 (L-382G). The -30 was .03m (6ft 8in) longer than the -20, first flew in August 1970, and was delivered from December that year. Most civil Hercules sales have been of the L-100-30 variant. Although basically a civil aircraft, several L-100s are in service with military operators, e.g. in Algeria, Gabon and Kuwait. The last L-100 was built in 1992, while the last military Allison 501/T56 powered C-130 was delivered in 1996.

The L-100J would be a commercial derivative of the new generation C-130J Hercules II. Improvements would include new 3425kW (4591shp) Rolls-Royce (Allison) AE-2100D3 advanced turboprop engines driving six blade props, two crew EFIS flightdeck and significantly lower maintenance and operating costs. The C-130J first flew on April 5 1996, while US FAA civil certification was awarded in September 1998. The L-100J would be based on the stretched fuselage C-130J-30, but in 2000 the program was frozen as Lockheed martin focussed on the military variants.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Lockheed L-188 Electra ',54531461.0,'img/0306963-v40-6.jpg',' Lockheed''s Electra provided a number of airlines with their introduction to turbine powered aircraft. Today it remains popular with freight operators.

The Lockheed L-188 Electra was developed to meet a 1954 American Airlines requirement for a domestic short to medium range 75 to 100 seat airliner. In June 1955 American awarded Lockheed an order for 35 such aircraft. Lockheed''s design, the L-188, was a low wing, four turboprop powered aircraft. Many other airlines shared American''s interest in the L-188, and by the time the first prototype flew on December 6 1957, the order book stood at 144. Service entry was with Eastern Airlines (due to a pilot''s strike at American) on January 12 1959.

However, any optimism Lockheed felt about a strong sales future would have been short lived, as a number of crashes in 1959 and 1960 (two of which where the aircraft broke up in flight) contributed to a number of order cancellations.

As an interim measure following the crashes, speed restrictions were imposed on Electras. Investigations uncovered a design defect with the engine mountings where the wing would shake and eventually break up. Lockheed undertook a significant modification program where the nacelles, nacelle mountings and wing structure were strengthened, and the speed restrictions were eventually lifted in 1961. After that the Electra proved reliable and popular in service, but the damage had been done and production wound up in 1961 after 170 had been built.

Lockheed built two basic versions of the Electra. The L-188A was the basic production aircraft, and accounted for most Electra sales. The L-188C entered service with KLM in 1959 and had greater fuel capacity and higher weights, and thus improved payload range performance.

The Electra also forms the basis for the hugely successful P-3 Orion long range maritime surveillance aircraft of which more than 600 have been built.

Most Electras currently in service are configured as freighters. From 1967 Lockheed converted 41 Electras to freighters or convertible freighter/passenger aircraft, fitting a strengthened floor and a large cargo door forward of the wing on the left side. Other companies have also converted Electras to freighters. However, a small number remain in passenger service.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Luscombe Spartan ',70594086.0,' The Spartan is a modern tricycle reincarnation of the late 1940s Luscombe 11A Sedan.

The four seat taildragger Sedan was based on the popular Silvaire (over 6000 built) and first flew on September 11 1946. Production ceased in 1949 by when 198 had been built. In the mid 1950s aeronautical engineer Alfred Ney purchased a damaged 11A and through until 1988 developed a number of changes for the aircraft which aided eventual development of the 11E. Ney''s improvements included tricycle undercarriage, improvements to the handling characteristics and a more spacious cabin.

In 1992 Land Air Sales and Leasing Corporation purchased the 11''s type certificate and then transferred it to the newly established Luscombe Aircraft Corporation which has set about re-engineering the 11 for its return to production as the 185-11E Spartan.

Las Vegas based Luscombe Aircraft Corporation converted a Sedan (N1674B) to act as a proof of concept aircraft while the first new build 185-11E prototype first flew on June 19 1998. Certification for the basic aircraft could be awarded as early as April 1999 with first deliveries (from the new factory at Altus, Oklahoma) following soon after.

The Spartan''s most important changes compared with the Sedan are tricycle undercarriage and a six cylinder Teledyne Continental IO360 (derated from 157kW/210hp to 138kW/185hp). Other changes include a revised cowl shape for the new engine, a reprofiled windscreen, two overhead windows, modern avionics, soundproofing, inertia reel shoulder harnesses and dual vacuum pumps. Two optional avionics packages are offered.

A family of Spartan models is envisaged, including a 185 with a constant speed prop, the higher performance 157kW (210hp) IO-360 powered Spartan 210 and a turbocharged variant.

            The Luscombe 8 Silvaire was a highly successful two seat high wing light aircraft built in the years surrounding World War 2. Today it remains popular as a classic aircraft.

Prior to introducing the Silvaire into production in 1937 Luscombe had built a small number of two seat high wing light aircraft, the most popular of which was the Phantom, which was powered by a 108kW (145hp) Warner Super Scarab radial engine. The initial Model 8A Silvaire was similar to the Phantom in configuration but differed in that it was powered by a 50kW (65hp) Continental A-65 engine. A more up market model was also built from 1939, featuring a higher level of standard equipment and improved cabin trim. The 8B was similar to the 8A other than it was powered by a 50kW (60hp) Lycoming.

In 1941 Luscombe released the 8C which featured a 55kW (75hp) Continental engine, and the 8D, which differed in having wingtip fuel tanks. Over 1200 Model 8s were built through to early 1942 when production ceased due to the United States'' entry into WW2.

Shortly after the end of the war in late 1945 Luscombe resumed Silvaire production to meet the booming demand experienced by all US light aircraft manufacturers as returned military pilots wanted to continue flying in civilian life. From 1946 all Luscombes featured a new metal wing with a single strut. The first Silvaire to feature the new wing was the 8E, which was powered by a 65kW (85hp) Continental C8512 engine.

The final Silvaire production model was the 8F, which featured a 65kW (90hp) Continental C90. The 8A Sky Pal meanwhile was a lower powered variant of the 8F with a Continental C65.

Financial difficulties forced Luscombe to cease trading in 1949. US company Temco took over production and built a small number before it too ceased production in 1950. Finally, some Silvaires were built in Colorado between 1955 and 1960.

In 1998 a new plan emerged to re-introduce the 8F to production. Maryland based Renaissance Aircraft plans to re-certificate an improved 8F (powered by either a Lycoming O-320 or 110kW/145hp Walter HP) while production aircraft would be built by the Czech Aircraft Works. Renaissance estimates a unit price of $US50-70,000.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Lockheed L-1011 TriStar 1/50/100/150/200/250 ',41615206.0,'img/0304846-v40-6.jpg',' The Lockheed TriStar was the second widebody airliner to be launched, and although it was dogged with early financial and development problems, particularly with the engine, it went on to gain an excellent reputation in service for its reliability, economy of operation and low noise emissions.

The L-1011 TriStar was the last Lockheed airliner to be developed and was launched in March 1968 in response to an American Airlines requirement (that also resulted in the DC-10) for a large capacity medium range airliner. Lockheed initially studied a twin engined layout, but it was decided that three engines would be necessary to ensure it could takeoff at max weights from existing runways.

Work on the L-1011 prototype began early in 1969, resulting in a November 16 1970 first flight. The engine choice of Rolls-Royce''s advanced three shaft design RB211 however dogged the TriStar''s early career. Rolls-Royce went bankrupt in February 1970 largely due to higher than estimated RB211 development costs, severely harming both Lockheed and the TriStar sales program. The problems were able to be resolved after the British government nationalised Rolls-Royce, guaranteeing the supply of production engines. Despite the initial problems the RB211 proved to be extremely reliable and efficient in service and grew into a family of variants.

The first L-1011 model that entered service with Eastern and TWA in April 1972 was the initial domestic L-1011-1 (which was built in greater numbers than any other TriStar variant). Subsequent models to be developed were the -100 with more fuel and higher weights, the -200 with higher thrust engines, and the long range shorter fuselage -500, described separately.

Production ceased in 1983, when 250 had been built. The prototype was sold to be broken up for spares in 1986.

Many aircraft were converted to improved models: the -50 with a higher MTOW and strengthened fuselage, wings, and undercarriage, the -150 with a higher MTOW, the -250 with RB211-524B4 engines (as on the 500) for US carrier Delta, a small number to freighters with a large cargo door as -1(F) and -200(F), and quite a few to -100 and -200.

An ex Air Canada TriStar 100 was converted in 1992 by Marshall of Cambridge (Engineering) Ltd for Orbital Sciences Corporation as the "Stargazer" flying satellite launcher. After launching the Pegasus Air-Launched Space Booster from the TriStar, the Pegasus itself launched a satellite into low Earth orbit.

Another TriStar 100, ex Worldways Canada, was converted in 1995/1996 by Lockheed Aeromod Center to a flying hospital for Operation Blessing International Relief & Development Corporation, a non-profit humanitarian organisation. Apart from the hospital equipment, the aircraft is fitted with systems to be independent from local ground-based equipment.

Approximately 156 TriStars remained in service in 1998, of which 122 were standard fuselage models. In 2000 this number had gone down to about 137, of which 109 standard fuselage models, and at the end of 2002 this had further dropped to 51 active TriStars, of which 23 standard fuselage ones.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Lockheed L-1011 TriStar 500 ',57158077.0,'img/1673163-v40-6.jpg',' Lockheed developed the shortened fuselage L-1011 TriStar 500 as a long range, smaller capacity derivative of the TriStar 200.

Launched in August 1976, the key changes incorporated in the 500 over the standard L-1011s are the 4.11m (13ft 6in) shorter fuselage, greater takeoff weights, increased fuel capacity and more powerful RB211-524 engines. The shortened fuselage reduces seating capacity to a maximum of 330, 70 less than the standard length TriStars, while the below deck galleys that had been a feature of the L-1011 family were replaced with conventional main deck units.

Other improvements include enhanced wing-to-fuselage and fuselage-to-rear engine intake fairings, automatic braking and automatic thrust control. Most have three, rather than four, doors/emergency exits on each side of the fuselage. The design changes combine to give the 500 a maximum range of 11,260km (6100nm), approximately 2000km (1300nm) further than the long range 200.

The TriStar 500 first flew on October 16 1978 and entered service with British Airways in May 1979.

Soon after, the 500 also introduced the active aileron improvements first pioneered on the Advanced TriStar, which was the original prototype TriStar fitted with a number of advanced features intended for introduction to the TriStar production line. The Advanced TriStar incorporated increased span wings to reduce drag, with active, automatic operation of the ailerons used to cope with the increased weight and aerodynamic loads instead of strengthening the wing structure.

The first 500 with active ailerons and extended wingtips flew in November 1979 and deliveries of 500s with the new wing tip extension began the following year, while in 1981 it became a standard feature. Lockheed began retrofitting the active aileron wingtip extension to all previously built TriStar 500s from 1981. Production ceased in 1983 after 50 had been built, although the last 500 was not delivered until 1985.

In December 1982 Britain''s Royal Air Force bought 6 TriStar 500s from British Airways and contracted Marshall of Cambridge (Engineering) Ltd for the conversions. Four of them were converted to tanker-transports as TriStar K1. The conversion involves the installation of paired HDUs (Hose Drum Units) in the lower rear fuselage, underfloor fuel tanks in the fore and aft baggage compartments, adding an additional 100,060lbs (45,385kg) of fuel, a closed circuit TV camera to monitor refuelling, and military communications and navigation equipment. The aircraft are also equipped with a refuelling probe above the forward fuselage.

The first flight was made on July 9, 1985. As full passenger seating is available in the cabin, the K1 is an excellent aircraft for squadron deployments, able to refuel their aircraft in the air and at the same time carrying squadron personnel and supplies.

The other two aircraft, and two of the K1s, were converted to TriStar KC1 with the same modifications as the K1 but with an additional large cargo door in the port side front fuselage, a freight handling system, and a strengthened floor. They can carry cargo on pallets and 35 passengers. The first KC1 was flown in 1988.

Three more, ex Pan Am, TriStar 500s were bought in 1984, two of them serving as troop transport TriStar C2s. They retain the normal passenger seating and are not equipped with a flight refuelling probe. It was planned to convert the third one to a tanker K2, but these plans were abandoned and it was delivered instead as a TriStar C2A, with a new interior, military avionics, and the digital autopilot replaced by the same analog autopilot as fitted to the K1 and KC1. The MTOW for all RAF TriStars was increased to 540,000lbs (244,945kg). They serve with 216 Squadron.

In late 2002 28 of the 50 TriStar 500s built were in active service, 16 in airline service, 3 as corporate transport, and 9 in RAF military service.



 ',' United States of America ');

INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Lockheed JetStar ',64891648.0,' The four engined JetStar was initially designed as a private venture but was also selected to fulfil a US Air Force requirement for a multi engined light transport and crew trainer.

The first JetStar prototype first flew on September 4 1957. Two prototypes were built powered by two Bristol Siddeley Orpheus turbojets, one of these was reengined with four Pratt & Whitney JT12s in 1959 when an agreement to licence assemble the Orpheus in the United States could not be negotiated. The JT12 was selected for production aircraft, and the first of these flew in mid 1960.

The first civil configured JetStar was delivered in early 1961 and so the JetStar was the first business jet to enter service. Meanwhile the JetStar entered service with the USAF in 1962 as the C140 navaid calibration aircraft and the VC140 VIP transport in late 1961.

The turbojet powered JetStar remained in production until mid 1973, by which time development of the turbofan powered JetStar II had been announced. The JetStar II differs from the earlier aircraft primarily in its four Garrett (previously AiResearch and now AlliedSignal) TFE731 turbofans with their significantly improved fuel consumption, resulting in substantial improvements in operating costs, range and lower noise levels, while more power allows a higher maximum takeoff weight.

The first JetStar II flew on August 18 1976, with certification following in December that year. The II remained in production until 1979.

AiResearch meanwhile had already flown its own TFE731 powered conversion of the JetStar in July 1974. The first production AiResearch 731 JetStar conversion flew in March 1976.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Let L-610 ',87039771.0,'img/0323361-v40-6.jpg',' The Let L 610 is a stretched development of the earlier L 410, and although originally designed for a Soviet requirement, in its westernised form is now marketed worldwide.

The L 610 was conceived in the mid 1980s to meet a Soviet Union requirement for a new 40 seat turboprop airliner. A production run of 500 was envisaged for primary customer Aeroflot, and the L 610''s design was optimised to suit that carrier''s requirements (including operations from austere airfields). The basic L 610M for Aeroflot is a stretched 40 seat development of the L 410 powered by two 1358kW (1822shp) Motorlet M 602 turboprops. It first flew on December 28 1988, and a small number were delivered to Aeroflot during 1991 before Let suspended deliveries, stating that they would not resume unless western currency was used for payment.

As a result of the dissolution of the Soviet Union and the collapse of communism throughout eastern Europe, Let began development of a westernised version intended to significantly widen the type''s sales appeal. Known as the L 610G, it is optimised for world markets and features General Electric CT7 turboprops, Collins Pro Line II digital EFIS avionics, Collins weather radar and autopilot.

First flight of the L 610G prototype occurred on December 18 1992 (four years after the L 610M), and, after some delays, US FAA certification is planned for 1999.

Let has high hopes that the L 610 will penetrate the very crowded, international market for 40 seat airliners and the Czech Republic''s lower labour costs should see the aircraft priced competitively compared to its western competitors. No doubt, sales interest will increase once western certification is awarded, while new Let owner Ayres is keen to develop the L610 further and exploit its potential.

 ',' Czech Republic ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Let L-410 & L-420 ',68475638.0,'img/0106478-v40-6.jpg',' The L410 is very successful Czech commuter which was first built in response to Soviet requirements, but has sold widely around the globe.

First design studies of the original 15 seat L 410 began in 1966. The resulting conventional design was named the Turbolet, and was developed to be capable of operations from unprepared strips. The powerplant chosen was the all new Walter or Motorlet M 601, but this engine was not sufficiently developed enough to power the prototypes, and Pratt & Whitney Canada PT6A27s were fitted in their place. First flight occurred on April 16 1969, and series production began in 1970. Initial production L 410s were also powered by the PT6A, and it was not until 1973 that production aircraft L 410Ms featured the M 601.

The basic L 410 was superseded from 1979 by the L 410 UVP with a 47cm (1ft 7in) fuselage stretch, M 601B engines and detail refinements. The UVP was in turn replaced by the M 601E powered UVPE in which the toilet and baggage compartments were repositioned allowing more efficient seating arrangements for up to 19 passengers. The UVPE is the current production version.

The L 420 is an improved variant with more powerful M 601F engines, higher weights and improved performance designed to meet western certification requirements. It first flew on November 10 1993 and was awarded US FAA certification in May 1998.

Ayres took control of Let in September 1998 and plans to further develop the 410/420 line.

 ',' Czech Republic ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Let L-40 MetaSokol ',80088410.0,'img/0173916-v40-6.jpg',' One of the more lesser known light aircraft to emerge from behind the Iron Curtain, the unusually configured MetaSokol three/four seat light aircraft was a development of the Let Mraz M.1 Sokol.

The M.1 Sokol was a three seat light aircraft developed in the late 1940s. It was used in a variety of roles, mainly for training and a number were built for Czechoslovak flying schools. The wooden construction M.1 Sokol featured tail dragger undercarriage and a 80kW (105hp) Walter Minor 4III inline inverted four cylinder engine.

Like the M.1 Sokol, early production MetaSokols seated three and were powered by the same 80kW (105hp) Walter Minor engine. However the MetaSokol introduced a number of new features and design changes including metal construction, a rearwards sliding cockpit canopy, a very tall vertical tail that extends from the fuselage at almost a right angle, and a unique undercarriage system.

The MetaSokol''s undercarriage features a reverse tricycle arrangement, with the main undercarriage legs extending from the front of the wing, with the third leg mounted from under the fuselage. Unlike the original fixed undercarriage M.1 Sokol, the MetaSokol''s undercarriage retracts, although the rearward retracting main landing gear remains exposed in flight.

The prototype L20 MetaSokol flew for the first time during 1954. This original three seat model was built in only small numbers before it was superseded by the definitive four seater, which also introduced a more powerful M332 engine. The M332 was notable in that its normal maximum power output could be boosted for up to five minutes with supercharging.

Like the majority of Eastern European aircraft of its time, most MetaSokols were exported to countries within the Soviet sphere of influence, although a number were sold in western Europe, North America and Australia.

 ',' Czech Republic ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Lear Jet 23/24/25/28/29 ',32484980.0,'img/1246604-v40-6.jpg',' One of the world''s largest, fastest, best selling and well known series of business jets, the Learjet family began with the original six to eight seat Lear Jet 23 which first flew on October 7 1963.

The 23 originated in Switzerland, where William P. Lear had formed the Swiss-American Aviation Corporation (SAAC) in 1960 to manufacture a twin-jet high-speed executive aircraft, the SAAC-23. This aircraft was designed and conceived by Dr.eng. Hans-Luzius Studer, who previously had developed the FFA P-16 fighter. The aerodynamics and many other characteristics of the 23 were taken over from the P-16. Although it was originally planned to manufacture at least the first 25 Lear Jets in Switzerland, production was transferred to the United States, where Lear had founded Lear Jet Corporation.

The diminutive Model 23 pioneered an entirely new market segment for the light business jets, and proved very successful. The first production 23 was delivered in October 1964, but was replaced by the improved Model 24 in 1966 after 105 had been built. The 24, which introduced uprated engines and a number of detail changes, first flew in February 1966 and was delivered from the middle of that year. Developments of the 24 included the 24D, E and F, introducing improvements such as increased weights, thrusts, and range.

The Learjet 25 introduced a 1.27m (4ft 2in) fuselage stretch allowing seating for up to eight passengers and was first flown on August 12 1966, and, like the 24, a number of subsequent developments were built, including the B, C, and D.

In 1966 the name of the manufacturer changed to Lear Jet Industries, and in January 1970 Gates Rubber Company, who had bought a controlling interest, changed the name again, to Gates Learjet Corporation.

The unsuccessful Gates Learjet 28 and 29 Longhorns are based on the 25 but introduced a new increased span wing fitted with winglets, which improved fuel efficiency and overall performance, particularly payload range and fuel economy. The Longhorn 28 seats up to eight passengers, the similar dimensions Longhorn 29 sacrifices two seats for extra range. Production of the family ceased in 1982.

Learjets are known for their tight accomodation. Max internal cabin width is just 1.50m (4ft 11in), max height 1.32m (4ft 4in).

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Learjet 31/35/36 ',73277701.0,'img/1282050-v40-6.jpg',' The Learjet 35 and 36 are stretched, turbofan powered developments of the initial Learjet models, the 23, 24 and 25.

The availability of the Garrett AiResearch TFE731 turbofan in the late 1960s led to a development of the Learjet 25 that was initially known as the 25B-GF (Garrett Fan). A testbed Learjet 25 with a TFE731 on its left side flew in May 1971, while the definitive Learjet 35 prototype first flew on August 22 1973.

Aside from turbofans, the 35 and longer range 36 differ from the earlier Learjet 25 in having a 0.33m (1ft 1in) fuselage stretch and five windows (instead of four) on the right side of the fuselage. The Learjet 35 has seating for up to eight, but has less fuel than the longer range 36, which can only seat up to six, as both types share the same maximum takeoff weight. The 35 and 36 were certificated in July 1974.

Improvements to the two models led to the 35A and 36A from 1976, with higher standard max takeoff weights. Both models remained in production until 1994.

Development of the 35 and 36 range was taken one step further with the Learjet 31, which combines the 35/36''s fuselage and powerplants with the more modern wing of the 55 (now also on the 60) and delta fins under the tail. A 31 development aircraft first flew in May 1987 and certification was awarded in August 1988.

The improved 31A and 31A/ER are later production models, the 31A/ER being an extended range variant with a higher maximum takeoff weight and more fuel. A new interior with increased headroom was introduced in 1995. The 200th 31A was delivered in October 2000.

Learjet became a Bombardier subsidiary in 1990.



 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Lancair LC-40 Columbia 300/350/400 ',77084907.0,'img/0237444-v40-6.jpg',' Lancair''s LC-40-550FG Columbia 300, 350, and 400 are high performance, composite construction factory built aircraft from a company famous for its high performance kit aircraft.

While the Columbia 300 is Lancair''s first production aircraft, the Redmond, Oregon based Lancair was established in 1984 by Lance Neibauer, and since that time has built more than 1500 high performance two and four seat aircraft kits, including the Lancair 235, Lancair 320 and Lancair 360 two seaters and the Lancair IV, Lancair ES and Super ES and Tigress four seaters.

Lancair announced it was developing a high performance four seater intended for production, designated the LC-40, in 1996. An aerodynamic prototype of the design began test flying in July 1996 while the first certification prototype first flew in early 1997. The type''s first public appearance was at the 1997 Oshkosh Airshow as the LC-40 Columbia 300. Certification was awarded on October 1 1998. Deliveries of production aircraft (built at a new factory at Redmond''s Bend Municipal Airport) began in February 2000.

In common with Lancair''s kitplanes, the Columbia 300 features composite construction allowing a smooth, low drag external finish. Power is from a six cylinder 225kW (300hp) Continental IO-550. The 300 features a 402 litre (106US gal/82Imp gal) fuel capacity in two tanks, advanced IFR avionics and fixed undercarriage.

Lancair announced the even quicker turbocharged Columbia 400 in early 2000. The 400 is based on the 300 but features a twin turbocharged, twin intercooled 231kW (310hp) Teledyne Continental TSIO-550-G, giving a cruising speed of 426km/h (230kt) at 18,000ft. First flight was in June 2000. The Columbia 400 will take the mantle of the world''s fastest production fixed undercarriage light aircraft from the Columbia 300.

The 400 will also introduce Lancair''s HITS (Highway in the Sky) advanced IFR avionics platform, designed with AvroTec (displays), Avidyne (software) and Seagull, under sponsorship of NASA''s AGATE program, for improved IFR situational awareness. HITS features a primary flight display that presents flight data in an integrated format, and a multifunction display for moving map displays, StormScope, radar, up-linked weather and traffic avoidance programs. Another advanced feature to be introduced with the 400 will be a FADEC (Full Authority Digital Engine Controls) engine management system, allowing single lever control for power, mixture and the propeller. FADEC uses sophisticated microcomputers to monitor and adjust the operation of each engine cylinder several times each second, which has many benefits in economy, pilot comfort, and performance. HITS and FADEC will be offered as options on the 300 in 2001.

On April 5, 2002 Lancair announced a new model, the Columbia 350. This is an all-electric version of the normally aspirated Columbia 300. The 350 features a dual bus, dual battery electrical system that eliminates the dual vacuum pumps found in the Columbia 300. FADEC is available as an option. The first public appearance was made at Lakeland''s Sun ''n Fun display in April 2002. After certification, first deliveries are planned for late 2002.

NASA is using a Columbia 300, designated Columbia 300X, as a test aircraft at Langley for in-cockpit displays like 4D "pathway guidance" and real-time traffic and weather displays to develop technologies for separation of aircraft without Air Traffic Control.


 ',' United States of America ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Lake LA4, Buccaneer & Renegade ',55102108.0,' This successful family of light amphibians has been by far the largest selling series of its type since Republic''s Seabee, and one of a very small number of such aircraft to enter production. <p>The LA4 series dates back to the Colonial C1 Skimmer, a three place light amphibian which first flew in July 1948. The C1 eventually entered production powered by a 110kW (150hp) Lycoming O320 in 1955, and small numbers of it and the four seat 135kW (180hp) O360 powered C2 Skimmer IV were built before Lake Aircraft purchased the manufacturing and design rights in October 1959. <p>Lake''s prototype LA4P was a development of the Skimmer IV, and first flew in November 1959. Put into production in August 1960, the production LA4 differed from the Skimmer IV in having greater wing span, strengthened structure and higher weights. The LA4 remained in production until 1972 (small numbers of seaplane only LA4Ts were built), by which stage the improved LA4200 Buccaneer had been in production for two years. The main difference in the two models was the LA4200''s more powerful engine, extra fuel and higher weights. <p>Further development led to the LA250 Renegade being certificated in 1983. It introduced a number of changes over the Buccaneer including the more powerful six cylinder IO540 engine and a stretched fuselage with seating for six. It and the turbocharged (TIO540AA1AD powered) Turbo 270 Renegade remain available. The Special Edition Seafury and Special Edition Turbo Seafury are based on the Renegade and Turbo Renegade respectively, and feature enhancements for salt water operations. <p> <p> <p> International Directory of Civil Aircraft <p> <p> ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Let L-200 Morava ',62582900.0,'img/1227669-v40-6.jpg',' The Let L-200 Morava retractable four seat light twin was one of the few light aircraft to be exported from behind the Iron Curtain during the Cold War era, albeit in small numbers.

Ladislav Smrek of the Czechoslovakian State Aircraft Factory designed the L-200 in the mid 1950s to develop a replacement for the early postwar vintage Aero 45 and 145 light twins. His resulting design is similar in many ways to its contemporary western twins, with a four or five place cabin, a low wing, wingtip tanks, metal construction and retractable undercarriage. However the Morava is distinguishable by its twin tails, standard thermal wing deicing equipment and inverted inline engines.

The prototype XL-200 Morava flew for the first time on April 8 1957. The XL-200 prototype and a series of preproduction L-200s were powered by 120kW (160hp) Walter Minor 6-III inline sixes. Initial production was of the L-200A, which differed from the L-200 in being powered by two 155kW (210hp) fuel injected M-337s, and had greater weights, a reprofiled cabin and hydraulically (rather than electrically) operated undercarriage and flaps.

Let built 160 L-200As before production switched to the improved L-200D. Features include a strengthened undercarriage, improved hydraulic and electrical systems and constant speed three blade propellers. The L-200D remained in production until 1969, and 5 aircraft were licence built in Slovenia (then part of Yugoslavia) by Libis. A turboprop powered development was studied but not built.

Most L-200 production was for customers within the Soviet Bloc - Aeroflot for example operated a large number in a range of roles including air taxi, air ambulance and communications duties. However small numbers were exported to western Europe, the USA and other Western countries.

 ',' Czech Republic ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Kestrel K250 ',13726740.0,' Kestrel''s K250 (previously KL-1A) is an all new, composite construction entry into the four place light aircraft market, and in its base K250A form will be an almost direct competitor to Cessna''s new 172R. <p>Oklahoma based Kestrel was founded by a former Cessna sales manager Donald L Stroud in 1991. The K250A is its first aircraft, with a family of developments of the basic aircraft to follow. The K-250A''s basic price was expected to be around $US90,000, considerably cheaper than other new build four seaters. <p>The prototype KL1A/K-250A was rolled out on April 21 1995, with first flight occurring later that same year, on November 19. Certification to FAR Part 23 in utility and normal categories is planned. <p>A key design feature of the basic K-250A is its graphite composite construction fuselage, while power is from a 120kW (160hp) Textron Lycoming O320 flat four driving a two blade prop. <p>The K250A is due to be followed by a family of developments, offering greater performance and/or capacity. The K250B will be powered by a 140kW (190hp) fuel injected Textron Lycoming IO360ES driving a three blade constant speed propeller. The K250R will be similarly powered but compared with the K250B will have retractable undercarriage. The high performance K-250C will also feature a three blade prop, but power will be from a 170kW (230hp) Textron Lycoming IO540. <p>At the top of the planned family tree will be the six seat utility K250D, which will feature a Textron Lycoming TSIO550B derated to 240kW (325hp) driving a three blade constant speed propeller. <p>Kestrel has also proposed a military observation/forward air control variant of the K250A, which would feature a pylon under each wing for light weapons and additional observation windows. <p> ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Kamov Ka32 ',43991144.0,'img/0056899-v40-6.jpg',' A not uncommon sight outside of the former Eastern Bloc, the Kamov Ka32 (NATO reporting name `HelixC'') is a multi purpose utility helicopter based upon the military Ka27. <p>Kamov began design work on the Ka27 in 1969, its principle design objective being to provide a shipborne anti submarine warfare helicopter to replace the Ka25 (`Hormone''). The Ka27 prototype first flew in December 1974 and served as a prototype for the planned military and civil (Ka32) variants. The Ka27 was first noted in Soviet navy service in 1981, the same year that the first civil Ka32 was publicly exhibited at Minsk. The Ka27 and -32 both feature the pod powerplant/gearbox and twin tails fuselage configuration of the Ka25, and the Kamov trademark counter rotating main propellers (negating the need for a tail rotor). <p>A number of versions of the basic Ka32 have appeared thus far. The Ka32T is the standard utility version, and is in use for a range of missions including passenger transport, air ambulance or flying crane. Although it features only basic avionics, it has been produced in greater numbers than the other Ka32 derivatives. The Ka32S meanwhile is fitted with a comprehensive IFR avionics suite for operations in poor weather conditions. Equipped for maritime operations, it is used from icebreakers, for maritime search and rescue, and offshore oil rig support, among other tasks. <p>The Ka32K is optimised for use as a flying crane and features a retractable gondola underneath the fuselage for a second pilot who can manoeuvre the aircraft when positioning it. The Ka32A is similar to the Ka32T but is certificated (awarded in June 1993) to the Russian equivalent of US Far Pt 29/Pt 33 airworthiness standards, and is offered with advanced avionics. <p> ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Kamov Ka26 & Ka-226 ',31152603.0,'img/0123084-v40-6.jpg',' The unusually configured but useful Kamov Ka26 remains in widespread civil service in many former Soviet states.

The Ka26 (which has the NATO code name `Hoodlum'') first flew in prototype form in 1965, but it did not enter service until 1970. However since then approximately 850 have been built for mainly civil service.

The uniquely configured Ka26 features two counter rotating main propellers, a Kamov characteristic that negates the need for an anti torque tail rotor. Other features include the two podded radial piston engines mounted either side of the fuselage, and the removable and exchangeable rear fuselage.

The interchangeable cabin means that the Ka26 can perform a wide variety of missions, including passenger and freight transport, air ambulance, aerial survey, and search and rescue among others with a special mission specific rear fuselage pod fitted as needed. The fuselage pod can also be removed and the aircraft instead equipped with a chemical hopper and booms for crop spraying, or it can work as an aerial crane and can also carry sling loads of freight.

The Ka26 is no longer in production, although it has been developed into the turbine powered and modernised Ka126 which first flew in 1986. Development of the Ka-126 continued into the mid 1990s but production was never undertaken.

Kamov is currently working on the improved Ka-226A. Enhancements include a new rotor system with hingless hubs and glass fibre blades, changes to the airframe including a reprofiled nose. Power is from two 335kW (450shp) Allison 250-C20R/2 turboshafts. First flight was on September 4 1997.

 ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Kaman K-1200 K-Max ',33624462.0,'img/0261570-v40-6.jpg',' Kaman''s first civil helicopter since the Ka-225 was certificated in 1949, the K-Max is a specialised helicopter designed specifically for aerial crane work.

The unusual looking K-1200 K-Max is easily identified by its characteristic intermeshing main rotors. The two main rotors have the dual advantages of allowing a low rotor disc area loading and that all the engine''s power produces lift, and none is "wasted" driving an anti torque tail rotor. The two main rotors are also fitted with trailing edge servo flaps that control the blades'' angle of attack, negating the need for hydraulic power.

Power is supplied by a Honeywell (formerly AlliedSignal and Lycoming) T53-17A-1 turboshaft (equivalent to the military T53-L-703), the T53 also powers the Bell UH-1 Iroquois series (and the equivalent commercial Bell 204 and 205, described separately). The extremely high power to weight ratio of the K-Max means it can lift loads of up to 2720kg (6000lb).

The prototype K-Max first flew on December 23 1991, piloted by company test pilot Al Ashley. Certification was delayed somewhat by an early decision to improve the rotor system to increase performance margins, changes including lengthening the main rotors'' diameters and increasing the rating of the transmission. US FAA certification was awarded in September 1994.

Recognising that the K-Max''s high power to weight ratio may place inexperienced operators in difficult situations, Kaman took a very cautious approach to marketing the aircraft and leased out the first six production aircraft while flight experience was gained.

As an aerial crane the K-Max is suited to firefighting operations carrying various size Bambi buckets, logging, construction, surveying and aerial spraying. It has also been demonstrated to the US Navy in the vertrep (vertical replenishment) role (due to USN requirements Kaman certificated the K-Max for IFR operations, awarded in 1999).

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Israel IAI-1125 Astra/Gulfstream G100 ',89023220.0,'img/0253061-v40-6.jpg',' The IAI-1125 Astra is a comprehensively upgraded development of the successful IAI-1124 Westwind, with a number of key changes to improve performance and increase cabin volume. It is now part of the expanded Gulfstream stable, designated G100.

Israel Aircraft Industries began work on an improved development of its model 1124, initially known as the 1125 Westwind, in the early 1980s, with the first flight of the new type occurring on March 19 1984. A second prototype flew in October 1984, and a third was used for ground based static and fatigue testing. The first production Astra flew in March 1985, and the first customer delivery took place in mid 1986 after certification had been granted in August the previous year.

The Astra is based on the basic Westwind II fuselage and tail, mated with an all new high speed swept wing (initially lacking winglets). Aside from the aerodynamic and hence performance benefits of the new wing, it was also repositioned low on the fuselage (as opposed to mid mounted on the Westwind), where it does not intrude on internal cabin space. The repositioned wing plus reshaped fuselage frames means that headroom is increased by 20cm (8in). Other changes include a lengthened nose for greater avionics space and more extensive use of composites (mainly for control surfaces).

The original 1125 Astra was replaced in production by the Astra SP. The SP was first announced in 1989 and features a revised cabin interior, upgraded avionics, EFIS cockpit and some minor aerodynamic refinements. Thirty seven were built before it was replaced by the SPX.

The SPX, renamed G100 from September 2002, first flew in August 1994. It features more powerful FADEC equipped 18.9kN (4250lb) Honeywell TFE731-40R-200Gs, winglets and Collins Pro Line 4 avionics.

IAI builds the G100 in Israel and the "green" airframes are flown to Lincoln, Nebraska in the US for interior outfitting. Gulfstream acquired Galaxy Aerospace, which held the Astra type certificates and was responsible for marketing, in May 2001.

In September 2002 Gulfstream announced the improved G150, based on the G100 but with an enlarged fuselage and seating for six to eight. It will be powered by TFE731s, cruise at Mach 0.75 and have a range of 5000km (2700nm). Deliveries are due in 2005.

Two Astra SPXs have been delivered to the US Air Force (Air National Guard) as C-38As for transport and medevac tasks.
 ',' Israel ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('IPTN N-250 ',37854337.0,'img/0067230-v40-6.jpg',' The advanced N250 is the Indonesian aerospace industry''s most ambitious project yet but in late 1998 looked in danger of stalling due to the Asian financial crisis.

IPTN announced development of the N250 at the 1989 Paris Airshow. Prototype construction began in 1992 but by this stage calculations showed that the 50 seater would be overweight, and so IPTN decided to stretch the basic aircraft to seat 64 to 68 passengers. At the time only the first prototype was to be built to the 50 seat N250 standard, subsequent aircraft would have been to the larger N250100 specification. However in late 1995 this plan was amended and the 50 seat N25050 was again added to the model line-up alongside the larger N250100.

Features of the N250 include flybywire, a glass EFIS Rockwell Collins Pro Line 4 avionics system and Allison AE 2100 turboprops.

The N-270 is a planned 70 seat, 3m (10ft) stretched development which would be built in the USA by AMRAI (American Regional Aircraft Aircraft Industries). IPTN, General Electric and US investors established AMRAI to build the N270 at Mobile, Alabama but delays in the program have stalled this project. In 1997 IPTN also negotiated with Euro Regional Aircraft Industry (ERAI) to build the N-250-100 in Germany.

PA1, the 50 seat first prototype, first flew on August 10 1995, while PA2, the first N-250-100 development aircraft, began test flying in 1997. Work on a third prototype had virtually come to a complete stop by late 1998 and plans to build a fourth have been scrapped.

Indonesian certification was originally scheduled for mid 1997 and US certification for late 1997, but certification compliance issues and the Asian financial crisis conspired to delay the program and possibly stall it all together.

 ',' Indonesia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Ilyushin Il-96-300 ',13528670.0,'img/0190894-v40-6.jpg',' Despite resembling the larger Il-86, the Il-96-300 is essentially a new design, incorporating a number of advanced technologies and new engines aimed at improving on the uncompetitive Il-86.

Development of Russia''s second widebody airliner began in the mid 1980s, resulting in the Il-96''s first flight on September 28 1988. Two other flying prototypes were built, as were two airframes to be used for static and ground testing. Commonality in some areas with the Il-86 allowed a 1200 flight hour certification program, resulting in Russian certification being awarded on December 29 1992. The Il-96-300 entered service with Aeroflot Russian International Airlines the following year.

The Il-96-300 is based on the older and larger Il-86, but it features a number of new technologies previously the exclusive domain of modern western built airliners. These include a triplex flybywire flight control system, a six screen EFIS flightdeck (however three flightcrew are retained, and not two as on most modern western designs), some composite construction (including the flaps and main deck floors), and winglets. The modern PS-90 turbofans are designed to comply with ICAO Stage 3 noise limits (something the Il-86 cannot conform to) and the Il-86''s unique lower deck airstair design was deleted.

Perhaps the Il-96-300''s greatest claim to fame though is that it forms the basis for the stretched and westernised (with Pratt & Whitney PW-2337s and Collins digital avionics) Il-96M and Il-96T, described separately.

 ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Ilyushin Il-96M & Il-96T ',25020358.0,'img/0061103-v40-6.jpg',' The Ilyushin Il-96M long range airliner and Il-96T freighter are modernised and stretched developments of the Il-96-300 equipped with western engines and avionics.

Compared with the Il-96-300 the Il-96M and -96T feature a host of improvements and incorporate much western technology. The most obvious change is the fuselage stretch taking max single class passenger accommodation back to over 350 (as on the Il-86). The longer fuselage also means that the Il-96M''s vertical tail can be smaller. However perhaps most important of the changes are the Pratt & Whitney PW2337 turbofans giving greater fuel economy and reliability. The Il-96M also features Rockwell Collins avionics including a modern two crew six screen EFIS flightdeck.

The first Il-96M to fly was the Il-96MO prototype, a conversion of an Il-96-300, its first flight occurring on April 6 1993. The first new build production Il-96M was a Il-96T freighter which was rolled out on April 26 1997, while the first new build Il-96M was due to fly during 1998.

Production Il-96Ms/-96Ts will be built at the Ilyushin Aircraft Production Association plant in Voronezh and certification, both western and Russian, is planned, but had not been achieved by late 1998.

Possible developments of the Il-96M under study include the Il-96MK, which would be powered with ducted engines in the 175 to 195kN (38,000 to 43,000lb) thrust class, and the twin engine Il-98, which would be powered by western turbofans such as the GE90, Trent 800 or P&W PW4000 series.

 ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Ilyushin Il-86 ',3174670.0,'img/0111108-v40-6.jpg',' Russia''s first widebody airliner, the Il-86 has endured a very chequered career. It has suffered from poor fuel economy, reports of failing to meet its design range, and has been produced in only relatively modest numbers.

Il-86 development was announced at the 1971 Paris Airshow. But a protracted development program followed and the first examples did not enter service until almost a decade later in late 1980. Antonov, Tupolev and Ilyushin were all asked to respond to Aeroflot''s requirement for a widebody airliner, with Ilyushin''s design proving successful.

The Il-86 initially was similar in configuration to the narrowbody Il-62, with four rear mounted turbofans and a Ttail. However the same problems that affects most Ttail designs such as poor low speed handling, plus the heavy structural weight needed to support the four engines caused a rethink, resulting in the adoption of a conventional tail and under wing mounted engine configuration.

Although a conventional design, one unusual feature of the Il-86 is that - where airport aerobridges are not provided - passengers can board the aircraft via airstairs leading to a lower deck baggage stowage area, before climbing a fixed internal staircase to the main passenger cabin.

The Il-86 was first unveiled in prototype form in 1976. The first of two prototypes flew for the first time on December 22 1976, while the first production aircraft flew on October 24 1977. Airline service began in December 1980 (Aeroflot had previously hoped to have it in service in time for the 1980 Moscow Olympic Games). About 100 had been built when production ended in 1994.

Plans to equip the Il-86 with CFM International CFM56 turbofans to dramatically improve fuel economy, range and reducing noise levels to within ICAO Stage 3 limits have been discussed at various times, but the cost of such an upgrade has so far has proved prohibitive.

 ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Ilyushin Il-18 ',3174663.0,'img/0074160-v40-6.jpg',' The Ilyushin Il-18 enjoyed one of the longest production runs of any turboprop airliner in the world and played a significant role in developing air services in Russia''s remote regions in the 1960s and 1970s.

The Il-18 was developed in response to a mid 1950s Aeroflot requirement for an economical 75 to 100 seat medium range airliner. The prototype Il-18 (named Moskva) was powered by four 2985kW (4000shp) Kuznetsov SN4 turboprops and flew for the first time on July 4 1957. The first Il-18 entered Aeroflot service on April 20 1959.

Initial production Il-18s could seat 75 passengers and were powered by the Kuznetsov engines, but only the first 20 aircraft built were so powered before the 2985kW (4000shp) Ivchenko AI20 became the standard powerplant. From there on only minor changes characterised the Il-18''s development life.

The first new production model was the Il-18B which had a reconfigured interior to seat 84 passengers. The Il-18V entered service in 1961. It became the standard Aeroflot version and could seat 90 to 100 passengers, depending on configuration. The Il-18I introduced more powerful 3170kW (4250ehp) AI20Ms, while seating could be increased to 122 in summer with the deletion of the rear coat closet (essential in Russian winters) and fitting extra seats. The Il-18D is similar to the I but has extra fuel capacity with an additional centre section tank. On the Il-18D and Il-18I the APU is in the belly of the fuselage, rather than in the tail.

The Il-18 has the NATO reporting name of `Coot''. Like the Lockheed Electra, the Il-18 also formed the basis of a maritime patrol and anti submarine warfare aircraft, the Il38 `May''.

Most Il-18s are now flown by secondary operators on regional routes and on charters as they have been replaced by more modern and efficient jet equipment on primary routes.

 ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Ilyushin Il-14 ',3174663.0,'img/0223021-v40-6.jpg',' Like many western aircraft of loosely similar size and configuration, the Il-14 was developed as a replacement for the then irreplaceable Douglas DC-3 and Russian Li-2.

As with so many other countries around the world the Soviet Union''s immediate postwar airline system was heavily dependant on war surplus DC-3/C-47s as well as the Lisunov Li-2 (Soviet licence built development of the DC-3). In the late 1940s/early 1950s Aeroflot developed a requirement for a modern replacement of the Li-2 and the DC-3. Ilyushin responded with a low wing tricycle undercarriage design powered by two Shvetsov radials with maximum seating for 27. This aircraft was designated the Il-12.

The Il-14 is an improved development of the basic Il-12 design. The major improvement Ilyushin introduced was a new wing design featuring a more efficient aerofoil section, plus more powerful Shvetsov engines and a general clean up of the airframe.

Given the NATO reporting name "Crate", the Il-14 is believed to have entered service in 1954 or 1955. Initial service models were designated Il-14P (Passazhirskii or passenger) and they were reconfigured to seat 18. Approximately two years after entry into service most Il-14Ps were configured to seat 24 passengers in a higher density configuration. By 1956 a slightly stretched development, the Il-14M (Modifitsirovanny/modified), had appeared. Initially the Il-14M was configured to seat 24, but this was later changed to 36. Very few modifications were made to the Il-14 during its production run, although many freighter Il-14Ts (Transportny/transport) were built, while many airliner Il-14s were later converted to freighters.

While most Il-14s were built in Russia, at Khodinka and Tashkent, Il-14s were also built under licence in the former Eastern Germany by VEB Flugzeugwerke and the former Czechoslovakia by Avia, 80 VEB Il-14Ps and 203 Avia 14s were built.

Today few Il-14s remain in service, most are used for general freight and charter work.

 ',' Russia ');

INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Ilyushin Il-62 ',3174667.0,'img/0096213-v40-6.jpg',' The four engined Il-62 was the Soviet Union''s first long range jetliner designed for intercontinental flights such as Moscow to New York nonstop.

The prototype Il-62 was first unveiled in September 1962. Due to the unavailability of the chosen Kuznetsov turbofans this aircraft made the type''s first flight powered by four 7.0kN (16,750lb) Lyulka AL7 turbojets. Other design features of this new jet included a wing sweep of 35°, three section ailerons, double slotted trailing edge flaps, two upper surface spoilers and fixed drooping leading edge extension on the outer two thirds of the wings to combat limited control at low speed, a characteristic of Ttail aircraft. The four engines are rear mounted either side of the fuselage in pairs. Only the outer two engines are fitted with thrust reversers.

The Il-62 did not enter passenger revenue service until March 1967, with its first long range intercontinental service taking place in September 1967 when an example flew from Moscow to Montreal.

The improved Il-62M appeared at the 1971 Paris Airshow and introduced more economical Soloviev D30KU turbofans, increased fuel capacity and modified mechanised cargo holds capable of housing containers. The Il-62M entered service in 1974.

The Il-62MK was announced in 1978. It features an increased max takeoff weight of 167,000kg (368,170lb) which allows a maximum of 195 passengers to be carried.

Low rate production of the Il-62 ceased in 1994, although the type remains an important part of many former Soviet airlines'' fleets, including Aeroflot Russian International Airlines.

 ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Ilyushin Il-114 ',31746632.0,'img/1226687-v40-6.jpg',' The Ilyushin Il-114 has been designed to fill what could ultimately be a very large requirement to replace ageing fleets of turboprop airliners, including the Antonov An-24, in service on regional routes within Russia and other CIS states.

While only just entering service now in the late 1990s, Ilyushin finalised the Il-114''s basic design and configuration in 1986. However the first prototype did not fly until March 29 1990. In total, three prototypes were built plus two static test airframes, with the original intention being to achieve certification and service entry in 1993. However the test program was delayed, caused at least in part by the crash of one of the prototypes on takeoff during a test flight in mid 1993. Russian certification was finally awarded on April 26 1997.

The Il-114 is of conventional configuration, but 10% of its structure by weight is of composites and advanced metal alloys, including titanium. It features low noise six blade composite construction propellers, and it can operate from unpaved airfields.

The Il-114 is the basic airliner and forms the basis for a number of developments. The Il-114T is a freighter developed for Uzbekistan Airlines. It is fitted with a 3.31 x 1.78m (10ft 10in x 5ft 10in) freight door in the rear port fuselage and a removable roller floor.

The Il-114M will feature more powerful TV7M117 engines and increased max takeoff weight allowing a payload of 7000kg (15,430lb) to be carried.

Like many current Russian airliner programs, a westernised version of the Il-114 is under consideration. This is the Pratt & Whitney Canada PW127 powered Il-114-100 (formerly Il-114PC), which would feature improved fuel economy and range performance

The Il-114P is a military maritime patrol variant while the Il-114FK is designed for elint, reconnaissance and cartographic work and would feature a glazed nose and raised flightdeck.

 ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('IAI Westwind ',55378569.0,'img/0140060-v40-6.jpg',' The IAI Westwind has become one of the success stories of the small but effective Israeli aviation industry.

The Westwind started life as the Aero Commander 1121 Jet Commander or Commodore Jet, a General Electric CJ610 turbojet powered small executive jet based on Aero Commander''s successful piston and turboprop twin line. The first 1121 flew on January 2 1963, with deliveries of production aircraft from early 1965. However North American Rockwell shortly afterwards acquired Aero Commander, and as it was already building the Sabreliner (described under Rockwell), the Jet Commander line had to be sold off because of antitrust laws. Thus the design and production rights for the Jet Commander were sold to Israel Aircraft Industries (IAI) in 1968.

IAI completed production of the 1121 Commodore Jets (total US/Israeli production was 150) before developing the 1123 Westwind with a stretched fuselage allowing seating for 10 passengers. The Westwind first flew in September 1970. Thirty-six turbojet powered 1123s were built before production transferred to the Garrett TFE731 turbofan powered 1124 (known as the Westwind I from 1981), the first of which were delivered in mid 1976. The 1124N Sea Scan was announced in 1976 and is a radar equipped maritime patrol and surveillance derivative.

Development of the basic 1124 led to the 1124A Westwind 2 with improved hot and high performance, better fuel economy and longer range. Delivered from May 1980, changes over the 1124 included a modified wing section, winglets, flat cabin floor and other interior improvements. Production ceased in 1987 in favour of the 1125 Astra (described separately under Galaxy Aerospace).

 ',' Israel ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Ilyushin Il-103 ',31746631.0,'img/0089391-v40-6.jpg',' The Il-103 is one of the Russian aerospace industry''s first attempts at designing and building a light aircraft for both eastern and western certification.

The Il-103 was originally conceived in response to a Russian requirement for 500 military and civil basic trainers. Program go-ahead for this new tourer and trainer was given in 1990. First flight was originally planned for the second half of 1993, although this was delayed until May 17 1994.

The Il-103 is one of the first all new four seat piston engine light aircraft to be developed in the 1990s. Optimised for western markets, it is powered by a six cylinder Teledyne Continental IO360, while western avionics equipment is available optionally. Ilyushin is marketing tourer and trainer versions which differ only in seating capacity, the trainer seats two, the tourer four or five.

Ilyushin has now received both Russian and US FAA FAR Part 23 certification. Russian AP23 certification was awarded in February 1996, with first deliveries to local customers taking place later that year, while US certification was awarded in December 1998.

The Il-103 is being developed in three basic models. The basic Il-103 is intended for the Russian market. The Il-103-10 is the export version with upgraded avionics, while the Il-103-11 is for export but with partially upgraded avionics compared to the Russian baseline fit.

Ilyushin is looking at certificating the Il-103 with a 1460kg (3218lb) max takeoff weight and a development with a 194kW (260hp) class Teledyne Continental or Textron Lycoming.

The Il-103 is one of a small number of promising Russian designs that looks capable of realistically achieving sales success in western markets and thus earning much needed foreign currency.

 ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Israel IAI-1126 Galaxy/Gulfstream G200 ',6246442.0,' img/0232798-v40-6.jpg',' The Gulfstream G200 mid size corporate jet is built by Israel Aircraft Industries and was originally marketed and supported by subsidiary Galaxy Aerospace Inc, which was acquired by Gulfstream in May 2001.

Design work on the IAI-1126 Galaxy (initially called the Astra Galaxy and later renamed G200 on Gulfstream''s take-over) began in the early 1990s and formal program launch was announced in September 1993. In 1995 a co-production arrangement was terminated that would have seen Yakovlev in Russia responsible for the design and manufacture of the Galaxy''s fuselage, while IAI would be the main contractor responsible for final assembly, integration and marketing. Subsequently SOGERMA of France was selected to manufacture production Galaxy fuselages and tails.

The Galaxy was first expected to fly in 1996 but this was delayed until December 25 1997. A second prototype flew in May 1998 while the first production aircraft first flew in October that year. US FAA and Israeli certification was issued in December 1998. The first customer aircraft was delivered to TTI Industries in January 2000 (a Galaxy delivered to Lion Industries in Zurich in July 1999 was leased back by Galaxy Aerospace for use as a demonstrator).

IAI assembles and test flies Galaxies in Israel while interior completion takes place at Galaxy Aerospace''s new facilities in Fort Worth, Texas.

The Galaxy features a wing design based on the swept high speed unit of the Astra, but otherwise is a completely new design. It features a new "widebody" fuselage, significantly wider and longer than the Astra''s, with standup room. The rear fuselage is area ruled to reduce drag, while the wing features winglets. The Galaxy also features an EFIS Collins Pro Line 4 cockpit and nonstop trans Atlantic and one stop trans Pacific range.

IAI selected the Pratt & Whitney Canada PW-306A turbofans for the Galaxy in January 1993 after studying competing designs from Allison (the AE-3007) and AlliedSignal/General Electric (the CFE-738). The PW-306A is a growth development (with increased fan diameter, improved hot end material and a forced mixer in the exhaust) of the PW-305 series that powers the Hawker 1000 and Learjet 60.

In June 2001, Galaxy Aerospace was acquired by Gulfstream Aerospace, who now owns the type certificate and is responsible for further development and engineering support. The Galaxy was renamed Gulfstream G200 at the same time. Israel Aircraft Industries continues to build and test fly the aircraft in Israel at its Tel Aviv facilities, which are then flown "green" to Gulfstream''s completion center at Dallas Love Field airport in Texas, where interiors and optional equipment are installed (before Gulfstream''s acquisition of the project, Galaxy Aerospace undertook completions and deliveries from a new facility at Alliance Airport, Fort Worth, Texas).

Some orders announced by Gulfstream: 50 plus an option on another 50 for Executive Jets, 24 plus an option on 43 for Avolar, and 3 for Hainan Airlines.

 ',' Israel ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('IAI Arava ',16736175.0,'img/0009492-v40-6.jpg',' The Arava STOL utility transport was IAI''s first design to enter production that was intended for both military and civil customers, but was built in only small numbers.

IAI began design work on the Arava in 1966. Design objectives included STOL performance, the ability to operate from rough strips and carry 25 troops or bulky payloads. To achieve this the Arava design was of a fairly unusual configuration, featuring a barrel-like short but wide fuselage, the rear of which is hinged and swings open for easy loading and unloading, plus long span wings, twin tails mounted on booms that run from the engine nacelles and two Pratt & Whitney Canada PT6A turboprops.

The Arava first flew on November 27 1969, while a second prototype flew for the first time on May 8 1971. US FAA certification for the initial Arava 101 was granted in April 1972.

The Arava 101 was not put into production, but formed the basis for the 101B, 102 and 201 production models. The 101B was marketed in the USA as the Cargo Commuterliner and differed from the 101 in having an improved 19 seat interior in passenger configuration and more powerful PT6A36s. The 102 had a 20 seat passenger interior, or alternatively a 12 passenger executive interior or all freight configuration.

The 201 is primarily a military version, and has sold in the most numbers, with more than 70 built, mainly for air arms of developing nations. The final Arava development is the 202, which is easily recognised by its large Whitcomb winglets, boundary layer fences inboard of each wingtip and slightly stretched fuselage. The winglets and boundary layer fences were offered as a kit for retrofitting to existing Aravas.

Arava production ceased in the late 1980s.

 ',' Israel ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Hiller UH12 ',92645603.0,'img/1021199-v40-6.jpg',' The UH12 series of light helicopters has one of the longest and most sporadic production runs in history.

The UH12 first flew in 1948. The initial variant was the Model 12 which was powered by a 133kW (178hp) Franklin 6V4178B33 engine. The Model 12A followed from 1952, it introduced a semi enclosed cockpit, while the distinctive goldfish bowl cockpit first appeared on the 12C, which also introduced all metal rotor blades (the 12C, plus the 12A and 12B were powered by a 150kW/200hp or 155kW/210hp engines). The definitive UH12E was first delivered from May 1959 and differs little from the UH12E3 currently in production.

Developments on the UH12E theme though include the four seat UH12E4 with a stretched fuselage and the Allison 250 turboshaft powered UH12ET and UH12E4T. Kits were offered allowing the conversion of 12Es into 12E4s, while piston powered aircraft could be retrofitted with the Allison turboshaft. Large numbers of military Hillers were also built for the US military as H23 Ravens.

The production history of the UH12 is chequered, with design and initial production undertaken by the original Hiller company. Hiller, and then Fairchild Hiller, built over 2000 up until the late 1960s. The newly formed Hiller Aviation acquired design and production rights in 1973 and restarted UH12E production. Hiller Aviation was then acquired by Rogerson Aircraft in 1984, the first UH12Es manufactured under the new company banner coming off the line in mid 1984. Rogerson subsequently changed its name to Rogerson Hiller, and relaunched UH12E production in 1991.

The final chapter of the UH12 story thus far opened in mid 1994 when the original designer and owner Stanley Hiller, in conjunction with Thai investors, acquired the program from Rogerson. The new Hiller Aircraft Corporation is building small numbers of UH12E3s (the first flew on June 2 1995) for its Thai partners, and has also flown the Allison 250 turboprop powered UH-12E3T.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Honda HA-420 HondaJet ',843111.0,'img/0925641-v40-6.jpg',' The Honda Motor Company Ltd quietly developed a light corporate jet, the HA-420 HondaJet, at its aerospace research facility at Greensboro-Piedmont Triad airport, North Carolina, US. In 1986 Honda began research into compact business jets, using engines from other manufacturers. However, details of this research have never been revealed. From 1999 Honda developed its own turbofan jet engine, the HF-118, which was testflown on a Cessna Citation. This engine features a single fan, a two-stage compressor and a two-stage turbine. The wing shape of the future HondaJet was tested on a Lockheed T-33.

The HA-420 HondaJet made its first flight on December 3 2003. The aircraft will undergo about 200 hours of flight testing to verify its flying characteristics and performance.

A prominent feature of the HondaJet is the over-the-wing engine configuration. Because no carry-through structure is needed in the aft fuselage for the engine mounts, this allows for a full-width cabin farther aft gaining 30% extra space within the same dimensions. Honda also claims that this configuration reduces drag at higher speeds.

The fuselage is made of composite material, a lightweight co-cured carbon composite/honeycomb sandwich, while the wings are made of integrally stiffened skin panels formed from single sheets of aluminum, offering a smoother surface than conventional configurations. The wing uses Honda''s proprietary turbulence reducing laminar SMH-1 airfoil, which is rather thick but offers low drag at high speed. Also the nose is designed to generate laminar flow to reduce drag. Honda claims that these features, together with the fuel-efficient HF-118 engines, achieve a 40% higher fuel efficiency. The aircraft is equipped with a Garmin G-1000 glass cockpit with three displays and an integrated avionics system. Four passengers can be accomodated with two crew, or five passengers with a single pilot.

Honda has not yet revealed if and when the HondaJet will be taken into production, but late 2003 there were rumours that Honda is investigating the possibilities to take over an existing US company to facilitate the production of the aircraft.







   ',' Japan and United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Hawker Siddeley HS-748 ',42152520.0,'img/0716897-v40-6.jpg',' Avro designed the 748 in a bid to re-enter the civil market in the 1950s in anticipation of a decline in its military aircraft business (following Britain''s famous 1957 Defence White paper).

Surfacing as the Avro 748 in 1958, the project became part of the Hawker Siddeley group when it formed in 1959 with the merger of several British aviation companies, including Armstrong Whitworth, Avro, Blackburn, De Havilland, Folland, Gloster, and Hawker. From July 1 1963 the separate identities disappeared.

The new aircraft made a successful maiden flight on June 24 1960, and four prototype aircraft (two for static testing) were built. The first production Series 1 flew on August 30 1961.

Series 1 production aircraft were powered by two 1400kW (1880ehp) Dart RDa.6 Mk 514 turboprops, and the first entered service in December 1961 with Skyways Airways. Only 20 (+4 in India) Series 1 were built however, as by that time the improved Series 2 was already flying.

The Series 2, in its 2, 2A and 2B variants, was the most successful of the line, the first flying on November 6 1961. The Series 2 differed from the 1 in having higher weights and more powerful engines. The Series 2B appeared in 1977, offering a range of aerodynamic and other improvements, including an increased wing span. Many Series 2A and 2B were equipped with a large forward fuselage freight door.

The most advanced 748 variant, the Super 748, was an improved version of the 2B and made its first flight in July 1984. Incorporating the improvements of the 2B, it also featured a modernised flightdeck, improved efficiency and hushkitted Dart engines, and new galley and internal fittings.

Hawker Siddeley, where the 748 was known as the HS-748, was merged into British Aerospace and from January 1 1978 the Hawker Siddeley name disappeared. Production of the aircraft type, now the BAe-748, ended in 1988 with the last flying that December (with delivery the following month).

The Indian Ministry of Defence had expressed an early interest in the 748 which resulted in an agreemnet to assemble and build the aircraft under licence. The first four aircraft, Series 1, were built by Kanpur (Indian Air Force Manufacturing Depot), with the first flight made on November 1 1961. Due to a poor production rate, the production was taken over from the fifth aircraft by Hindustan as the HAL-748, who first produced the Series 2 and later the Series 2M with the front fuselage freight door. The last one was delivered in September 1984, to the Indian Air Force.

A special military variant with a rear loading ramp and a "kneeling" undercarriage was the HS-780 (HS-748MF) which was known in British military service as the Andover C1. The standard HS-748 was named the Andover CC2. Later some C1s were converted for photo duties as the C1(PR) and radar calibration duties as the E3 and E3A. A few ex British and New Zealand military C1s entered commercial service.

The HS-748 proved to be a quite successful turboprop airliner and remains popular both as an airliner and freighter in civil and military use.




 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Harbin Y-11/12 ',69399650.0,'img/0157414-v40-6.jpg',' The piston powered Y-11 and turboprop Y-12 are Chinese developed regional airliners and utility transports.

Design of the Type 11 Transport Aircraft, or Yunshuji 11 (Y-11) began during the mid 1970s as a replacement for the Antonov An-2 utility biplane in Chinese service (licence built in China as the Y-5). A prototype was built and flown at Shenyang in 1975, while pre series and production aircraft are built at what is now the Harbin Aircraft Manufacturing Company. Production Y-11s were built from 1980. Features include two radial engines, capability for rough field operations and STOL performance. Y-11s have seen service as commuter airliners and have also been configured and used for ag spraying.

The Y-11B is an improved development powered by Teledyne Continental engines to overcome single engine altitude performance shortfalls. The first Y-11B''s maiden flight was on December 25 1990.

The Y-12 is a turboprop powered development and has been built in greater numbers than the Y-11. Work on a turboprop powered Y-11 began in the early 1980s, and a Pratt & Whitney Canada PT6A powered and enlarged cabin Y-12 prototype (previously the Y-11T) flew for the first time on August 16 1984. Current production is of the Y-12-II, while the further improved Y-12-IV was granted US certification in March 1995.

Canadian Aerospace Group (CAG) and its Panda Aircraft Company subsidiary offers a developed Y-12 as the Twin Panda, which it aims at the twin Otter replacement market. The Twin Panda is based on the Y-12-IV but features more powerful PT6A-34 engines, strengthened landing gear, and upgraded avionics and interior. Production Twin Pandas will be built in China and outfitted in Canada prior to delivery. In 2000 Canadian Aerospace group said it had orders for 35 Twin Pandas.

 ',' China ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Helio Courier ',31844767.0,' The Helio Courier has proven to be a highly versatile utility aircraft, renowned for its superb STOL abilities. <p>The Courier lineage traces back to a much modified experimental development of the two seat Piper Vagabond known as the KoppenBolinger Helioplane. This Helioplane featured numerous aerodynamic modifications to enhance low speed handling capabilities and STOL performance, and many of its features were subsequently incorporated into the all new and much larger Courier. <p>The Courier was initially known as the Helioplane Four and first appeared in 1952. In its first form it was powered by a 197kW (264hp) Lycoming GO435 and seated four. First flight occurred during 1953 and deliveries of the initial production model, the H391B, got underway in 1954. Subsequent development led to a number of derivatives, beginning with the H392 Strato Courier of 1957. Intended for high altitude photographic work, the H-392 was powered by a 255kW (340hp) supercharged GSO435. <p>The H395, featuring a 220kW (295hp) GO485 and seating for five or six, was the first major production version and it appeared in 1957. The H395A was similar but its engine could operate on 80 octane fuel, making it suitable for operations in remote areas. Next came the H250 (with a 185kW/250hp O540) and H295 Super Courier (220kW/295hp GO480) from 1965, and the tricycle undercarriage HT295 from 1974. The H250 remained in production until 1972, the H295 until 1976. <p>A development of the H295 with an eight cylinder 300kW (400hp) Lycoming IO720, the Courier 800, and the 260kW (350hp) TIO540 powered Courier 700 were put into production by the newly established Helio Aircraft Company from 1983, but production was limited and ceased in the late 1980s. <p> ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Handley Page Herald ',13980477.0,'img/0058165-v40-6.jpg',' A contemporary of the BAe 748 and Fokker F-27 Friendship, the Handley Page Herald was an unsuccessful attempt at providing a replacement for the ubiquitous Douglas DC-3.

The Herald was designed by Handley Page''s Reading facility, which was formerly the Miles Aircraft Company. Bearing a superficial resemblance to the smaller and older Miles Marathon, the Herald originally was powered by four 650kW (870hp) Alvis Leonides Major radial piston engines.

Handley Page optimised the Herald design for operations from underdeveloped airfields with operators which it thought would prefer piston rather than turbine power. The first Herald prototype flew on August 25 1955, a second flew on August 3 1956.

However, by this time the Vickers Viscount had proven the reliability and economical operation of turboprops and consequently Handley Page made the decision to switch to turboprops in May 1957. Both of the original piston powered prototypes were converted with two RollsRoyce Darts in place of the four Alvis Leonides Majors. The first flight of a Herald in the new configuration occurred on March 11 1958. The first Series 100 production Herald flew for the first time on October 30 1959.

Only four Series 100s were built before production switched to the larger capacity and stretched (by .09m/3ft 7in) Series 200 in late 1961. The prototype 200 flew for the first time on April 8 1961 and it became the major production model. The only other Herald derivative built was the Series 400, a military version of the 200 for Malaysia, which took delivery of eight.

The Herald failed to attract any significant sales success, its poor sales further contributing to the decline of Handley Page. Herald production ceased in August 1968, while Handley Page collapsed in late 1969.

In 1998 Channel Express in the UK operated the last Herald in service. Registered G-BEYF, it was retired in March 1999.

 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Hawker Siddeley HS-125-1/2/3/400/600 ',4282226.0,'img/0235757-v40-6.jpg',' One of the British aviation industry''s most successful postwar designs, the Hawker Siddeley HS-125 was one of the most successful first generation business jets and in developed form remains in production with Raytheon (refer separate entry).

The HS-125 started life as a De Havilland project before that company became part of the Hawker Siddeley group. As the DH-125 this mid size corporate jet flew for the first time on August 13 1962. For a time the DH-125 was named the Jet Dragon, while just eight initial Series 1 production aircraft were built before deliveries switched to the more powerful Series 1A (the A suffix denoting North America) and Series 1B (the B denoting sales for world markets). A total of 77 was built. The Series 2 meanwhile was a military derivative built for Britain''s RAF as the Dominie T1 navigation trainer.

The improved Series 3A and 3B (29 built) had a higher gross weight, while the 3A/RA and 3B/RA (36 built) were heavier still with extra fuel for greater range.

When De Havilland merged into Hawker Siddeley the Series 4, which featured numerous minor refinements, was marketed as the Series 400A and 400B and 116 were built.

The final Viper turbojet powered 125 built was the Series 600A and 600B. The Series 600 features a stretched fuselage taking standard main cabin seating from six to eight, or up to 14 in a high density configuration. Other changes included more powerful RollsRoyce Viper 601-22 turbojets, lengthened vertical tail and ventral fin and a fuel tank in the extended dorsal fin.

The 600 first flew on January 21 1971 and it became the standard production model until the Garrett TFE-731 turbofan powered 700 series was introduced (described separately under Raytheon) in 1976. Some Series 600s were re-engined with TFE-731s as HS-125-F600s.

 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Gulfstream Aerospace Jetprop & Turbo Commander ',85525234.0,'img/0167788-v40-6.jpg',' The turboprop powered developments of the Aero Commander family of light twins enjoyed a two decade long production run, and were built by three companies before production ceased.

The original Turboprop Commander was based on the 680FLP, and first flew on December 31 1964, but instead of piston engines power was supplied by 450kW (605shp) Garrett AiResearch TPE331 turboprops. This initial Turbo Commander model was designated the 680T and entered production in 1965.

Progressively improved developments of the basic Turbo Commander appeared, including the 680V, which introduced an increased maximum takeoff weight, and the 680W with improved engines. Following North American Rockwell''s takeover of Aero Commander and the introduction of the further improved Model 681, the name Hawk Commander was adopted for a time, but it was dropped from 1971 with the release of the 681B.

By the time of the introduction of the 681B, Rockwell was already flight testing the upgraded Turbo Commander 690, which first flew on March 3 1968 and was certificated in July 1971. Rockwell introduced the improved 690A soon after.

In 1979 Rockwell flew the Jetprop Commander 840 and 980, developments of the 690 powered by 625kW (840shp) Garrett TPE3315 and 730kW (980shp) TPE33110 turboprops respectively. These went into production with Gulfstream, who had purchased Rockwell''s GA lines in 1979. The Jetprop 1000 was similar in overall dimensions but introduced a revised interior that made better use of the available space and the 980''s engines. The Jetprop 900 meanwhile combined the revised interior with the 840''s engines.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Gulfstream Aerospace G-V Gulfstream V ',80025284.0,'img/0182681-v40-6.jpg',' The Gulfstream V is the largest and latest development of the Gulfstream line of corporate transports, designed to fly intercontinental distances. It competes with Bombardier''s Global Express, the Boeing Business Jet and Airbus A319CJ.

Gulfstream Aerospace first announced it was studying a stretched ultra long range corporate transport based on the Gulfstream IV at the annual NBAA convention in October 1989, while the program was officially launched at the 1992 Farnborough Airshow. First flight was on November 28 1995, with certification and first deliveries planned for late 1996. Provisional FAA certification was awarded in December 1996, full certification was granted in April 1997. The first customer delivery was on July 1 1997.

Underscoring its high speed, long range abilities, by September 1997 the G-V had set no less than 36 world city pair, class time to climb and altitude records.

The Gulfstream V is based on the Gulfstream IV, but features a number of substantial changes to suit its different design objectives. The most obvious change is the stretched fuselage, the G-V is 2.49m (8ft 2in) longer overall than the G-IV.

Perhaps the most important changes though are the advanced new wing design and new BMW Rolls-Royce BR-710 turbofans (the G-V is the first application for the new BR-710 engine). The all new wing is being built by Northrop Grumman, and is optimised for high speed flight. It was developed using Computer Aided Design and NASA developed computational fluid dynamics. The flightdeck is built around a six screen Honeywell EFIS avionics suite

Wing manufacturer Vought Aircraft Industries and Japan''s ShinMaywa are also risk sharing partners in the GV program.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Grumman G-73 Mallard ',43791473.0,'img/2007268-v40-6.jpg',' Following in the footsteps of the smaller Goose and Widgeon before it, Grumman developed the G-73 Mallard amphibian for commercial use.

Developed in the immediate postwar years, the Mallard is of similar overall configuration to Grumman''s earlier amphibious designs in that it features twin radial engines on a high mounted wing with under wing floats, retractable undercarriage and an unswept tail unit. Unlike the earlier aircraft the Mallard features tricycle undercarriage, a stressed skin two step hull and fuel can be carried in the wingtip tanks.

The Mallard prototype first flew on April 30 1946, and the type entered service shortly afterwards in September that year with a Canadian operator. The Mallard was designed for regional airline operations with two pilots and 10 passengers, but most of the 59 delivered were for corporate use. Today only a small number remain in use, but their unique amphibious capability means they remain popular, particularly with tourist operators.

Like the earlier and smaller Goose, the Mallard has been fitted with Pratt & Whitney Canada PT6A turboprops. Frakes Aviation in the USA reengined a small number of Mallards as G-73Ts in the early 1970s, the PT6s substantially boosting performance and operating economy. The first Frakes conversion first flew in 1969 and an FAA supplemental type certificate was awarded in October 1970.

In early 1994 a plan emerged which would see the Mallard reenter production in the Czech Republic. Aero and Levov of the Czech Republic, and Duncan Aviation of the USA hoped to raise the necessary capital to restart the line in the late 1990s. These plans later lapsed.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Grumman G-64/111 Albatross ',71923332.0,'img/2216915-v40-6.jpg',' The Albatross is easily the largest of Grumman''s series of utility amphibians, and was the only one originally developed specifically for military service.

The Albatross resulted from a late 1940s US Navy requirement for a general purpose amphibious transport. The first Albatross prototype flew for the first time on October 24 1947, with more than 400 production HU-16s subsequently delivered to the US Navy, US Coast Guard and 12 other nations. Military Albatross missions included general reconnaissance, maritime patrol, anti submarine warfare (in which role it could be armed with torpedoes and depth charges) and search and rescue.

In the late 1970s, Grumman and major US flying boat operator Resorts International began work on a program to convert the Albatross for civil airline service. The conversion incorporated numerous changes to the basic Albatross, including a 28 seat passenger interior, a galley and provision for a flight attendant, upgraded avionics and other improved systems. The airframes were also stripped down, inspected, components were replaced or repaired, and the whole airframe was zero timed. Military equipment was removed and the engines were stripped down and rebuilt. The first such G-111 Albatross conversion flew for the first time on February 13 1979 and US FAA certification was awarded in April 1980.

Grumman purchased 57 Albatrosses for conversion and foresaw a potential market for up to 200 modified amphibians, however this prediction proved somewhat optimistic. In all only 13 aircraft were converted, 12 for Resorts International, and 1 for Conoco Oil/Pelita which operated from Singapore. Several of these are still active, together with ex military examples.

A more developed version powered by Garrett TPE-331 turboprops and a firebomber were also studied but not developed. Later in 1986 Frakes International proposed reengining Albatrosses with Pratt & Whitney Canada PT6A or PW-120 turboprops, but this plan also was not pursued. However, some Albatrosses have been converted to turbine power.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Gulfstream Aerospace G-IV Gulfstream IV ',16366335.0,'img/0253049-v40-6.jpg',' The Gulfstream IV is a significantly improved, larger, longer ranging and advanced development of the earlier II and III.

The most significant improvement with the G-IV over the earlier Gulfstream models are the Rolls-Royce Tay turbofans, which bring significant fuel burn and noise emission improvements despite their higher thrust output than the II and III''s Speys (the IV continues a Gulfstream and Rolls-Royce association that dates back to the original Dart powered Gulfstream I). Other changes include a stretched fuselage and aerodynamically and structurally improved wing with 30% fewer parts, greater fuel capacity and range, increased span tailplane and an advanced EFIS avionics suite with six colour CRT displays.

Design work on the IV began in early 1983, with the first of four production prototypes making the type''s first flight on September 19 1985. FAA certification was awarded on April 22 1987. The improved Gulfstream IV-SP (SP = Special Performance), with higher payload and landing weights and improved payload range performance, replaced the IV from September 1992.

A third development is the special mission SRA-4. Designed primarily for military roles (such as maritime patrol and electronic surveillance, depending on equipment fit) it is also offered as a freighter for priority cargo transport (the US Navy has ordered four and the Marines one as C-20G operations support aircraft capable of accommodating 26 passengers or three freight pallets).

Both the Gulfstream IV and IV-SP have set a number of records. A Gulfstream IV flew west around the world over 36,800km (19,890nm) in June 1987 in a time of 45hr 25min, setting 22 class world records, another flew east around the world in February 1988, setting 11 class world records. More recently a IV-SP set new world speed and distance records on a routine business flight from Tokyo to Alberquerque in the USA in March 1993.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Grumman G-44 Widgeon ',49598507.0,'img/0049651-v40-6.jpg',' The smallest of Grumman''s amphibians developed for civil use, the Widgeon was conceived as a light personal and executive transport, following the success of the larger Goose.

The prototype Widgeon flew for the first time in July 1940, but America''s impending entry into WW2 stalled plans for civilian production. The first production Widgeon was the military J4F1, a three seat anti submarine patrol and utility version for the US Navy. The US Navy and US Army Air Force ordered large numbers of Widgeons throughout the war years, others saw service with the US Coast Guard and 15 were supplied to Britain''s Royal Navy, that service originally calling the aircraft Gosling. In all, 176 Widgeons were built for military service during the conflict.

After the war, Grumman refined the Widgeon for commercial use by altering the hull profile for improved handling on water and increasing seating capacity for up to six. Grumman built 50 of these as the G-44A, while a further 40 were built in France as the SCAN-30. Most SCAN-30s were delivered to customers in the USA.

US firm McKinnon Enterprises offered conversions during the 1960s to both the Grumman Goose and Widgeon. McKinnon''s Super Widgeon conversion involved fitting G-44As with Lycoming GO-480 flat six cylinder engines driving three blade propellers, which significantly boosted top speed, climb performance and range through improved fuel economy and extra fuel tankage. Other changes incorporated on the Super Widgeon were then modern IFR avionics, new wider cabin windows, more soundproofing, an emergency escape hatch, and as an option retractable wingtip floats. Modifications to the hull and structure meanwhile allowed an increase in the Super Widgeon''s maximum takeoff weight.

Small numbers of Widgeons and Super Widgeons still fly, mostly in private hands, with a few in commercial service.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Grumman G-21 Goose ',18071838.0,'img/0605305-v40-6.jpg',' The Goose began life in the pre WW2 days as Grumman''s first design intended for civilian use, but most of the type''s production ultimately was against military orders placed during WW2.

The Goose''s first flight occurred in June 1937. Grumman''s already extensive experience in building fighters for the US Navy was reflected in the Goose''s rugged construction, features of which included a braced tailplane and deep two step hull. A retractable undercarriage was another feature. Initial civil production machines were designated the G-21A.

The arrival of WW2 saw the Goose (a name originally bestowed on the aircraft by Britain''s Royal Air Force) enter military service with a number of allied air arms, the largest operator being the US Navy. Military orders from the US, Britain and Canada accounted for much of the Goose''s 300 unit production run.

Postwar, surplus Gooses found their way into service with commercial operators worldwide, their unique amphibious capability and rugged construction ensuring their popularity in the coming decades.

A number of Gooses have been converted to turboprop power, McKinnon Enterprises (initially based in the US, and then Canada) first fitting Gooses with four 255kW (340hp) Lycoming GSO480 piston engines, and then with two Pratt & Whitney Canada PT6s. Two versions of the latter were developed, the Turboprop Goose and the G-21G TurboGoose which introduced enlarged cabin windows and retractable wingtip floats.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Grumman G-164 Ag-Cat ',78430849.0,'img/0112274-v40-6.jpg',' The Ag-Cat is one of the most successful purpose designed agricultural aircraft yet built and has been in almost continuous production since 1959.

Grumman developed the G-164 Ag-Cat biplane in the mid 1950s, with the prototype making its maiden flight on May 27 1957. Some 400 initial G-164 Ag-Cats were delivered from 1959, with an open cockpit, and fitted with a variety of 165-335kW (220-450hp) radial engines including the 165kW (220hp) Continental W-670-6N, the 180kW (240hp) Gulf Coast W-670-240, the 185kW (245hp) Jacobs L4, or 205 or 225kW (275 or 300hp) Jacobs engines.

The G-164A followed. In its basic A/450 form it was powered by a 335kW (450hp) Pratt & Whitney R-985, and featured a greater maximum takeoff weight and additional fuel. The A/600 is similar other than its 450kW (600hp) R-1340 engine. The G-164B/450 is based on the A/450 but with increased span wings, while the B/525 is powered by a 390kW (525hp) Continental/Page R-975.

The longer fuselage 450kW (600hp) R-1340 powered G-164C/600 meanwhile forms the basis for the Pratt & Whitney Canada PT6A powered Turbo Ag-Cat D.

Recent models include the 450kW (600hp) R-1340 powered Ag-Cat Super B/600 and the PT6A powered Ag-Cat Super B Turbine (various PT6A models are offered ranging from 375 to 560kW  (680 to 750shp).

After the two prototypes, Grumman subcontracted Schweizer to build all the Ag-Cats for them. After Grumman American was formed in 1973, responsibility for the Ag-Cat was transferred to the new company. In 1978 the company was renamed Gulfstream American. In January 1981 Schweizer bought the design and marketing rights, and was now solely responsible for the Ag-Cat program. In 1995 Schweizer sold the Ag-Cat''s manufacturing rights to the Ag-Cat Corp of Malden, Missouri who have built a small number of aircraft. Ethiopian Airlines has built 11 G-164B Ag-Cat Super B Turbines under licence as the Eshet, powered by Pratt & Whitney PT6A-34AG turbines.

Many conversions are or were available for the Ag-Cat:
Agri-Jet Power Turbo-Cat with a 430kW (575shp) Garrett TPE-331 turbine.
Clark Lycoming-Cat with a 300kW (400hp) horizontally opposed Lycoming piston engine.
Frakes Turbo-Cat with a 560kW (750shp) P&W PT6A-34 or 403kW (540shp) PT6A-34AG turbine.
Harker Leo-Cat with a 418kW (560hp) British Alvis Leonides radial engine.
Marsh Turbo-Cat with a 450kW (600shp) Garrett TPE-331-1-101 turbine.
Malden Ag-Craft with two seats for training.
Mid-Continent King-Cat with a 895kW (1200hp) Wright R-1820 Cyclone radial.
Page Ag-Cat with a 450kW (600shp) Lycoming LTP-101 turbine.
Serv-Aero Leo-Cat  with a 418kW (560hp) British Alvis Leonides radial engine.
Stage II Ag-Cat with a 485kW (650hp) Stage II Chrysler V-8 piston engine.
Turbines Turbo-Cat with a PT6 turbine.
Twin-Cat Corp Twin-Cat with two 230kW (310hp) horizontally opposed Lycoming TIO-540-J engines.

Others were converted for airshow flying, like Gene Soucy''s Show Cat, and Joe Kittinger''s Rosie O''Grady''s Flying Circus display team, or are used for banner towing, firefighting, or pleasure flying.

 ',' United States of America ');

INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Grob GF 200 ',5348082.0,' Germany''s Grob launched the GF 200 four/five seater to offer a modern, high performance alternative to the thousands of four/six seater business aircraft in use worldwide. <p>Grob''s initial design aims with the GF 200 were to create a comfortable and roomy pressurised four seater capable of cruising at 420km/h (225kt) at 26,000ft. Power was to be supplied by a Porsche piston engine, but Grob later switched to the turbocharged Textron Lycoming TIO540 flat six. Another powerplant selection switch will see production aircraft powered by a Teledyne Continental TSIOL550, also a turbocharged flat six. <p>A key feature of the GF 200 is its pusher engine installation. The engine, which is buried in the airframe and mounted on the aircraft''s centre of gravity, drives a three blade constant speed propeller via a carbonfibre reinforced plastic shaft. Grob says the major advantage of the pusher configuration is that, unlike tractor aircraft, the airflow over the airframe is laminar. <p>Grob also claims the GF 200''s composite airframe brings significant benefits in drag reduction compared with conventional construction. Other features of the aircraft include its advanced profile wing with winglets and retractable undercarriage. <p>The GF 200 was first conceived in 1983 by Grob''s head of design K H Fischer, whose concept was to apply the company''s extensive knowledge of composite construction to a new four place high performance four seater. The project was postponed until 1989 because of potential difficulties with certificating a composite aircraft. Serious design effort resumed with the assistance of the German Ministry for Research and Technology, resulting in the unpressurised prototype''s first flight on November 26 1991. <p>Planned GF 200 developments include the GF 250 pressurised model, the stretched six seat GF 250/6, six seat turboprop powered GF 300 and the six to eight seat twin turboprop powered (supplying power through a single driveshaft) GF 350. <p>Grob is searching for a partner to help it fund production. <p> ',' Germany ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Grumman G-159 Gulfstream I ',13465988.0,'img/0236021-v40-6.jpg',' Grumman developed the Gulfstream I turbine powered executive transport to replace the many hundred war surplus piston twins performing such missions in the mid 1950s.

Design work began in 1956, with first flight of the Gulfstream I prototype occurring on August 14 1958. FAA Type certification was awarded on May 21 1959 and deliveries of production aircraft followed from that June. Notably, the Gulfstream I was the first US twin engined corporate transport to be certificated to cruise at 30,000ft.

As the first in the Gulfstream line, the GI established the basic fuselage cross section that carries through today to the Gulfstream IV and V. Other features were the RollsRoyce Dart turboprops which gave the I good high speed cruise performance and an auxiliary power unit allowing independent operations from remote strips, providing power for the air conditioning and electrical systems prior to engine start.

While primarily designed as a corporate transport, a large number of the standard fuselage Gulfstream Is were also used as commuter airliners, seating up to 24 passengers. Military Gulfstream Is were built for the US Navy (navigator training TC-4s) and US Coast Guard (VIP VC-4s). Production of the standard fuselage I ceased in 1969.

In 1979, by which time Grumman''s design rights were purchased by the newly established Gulfstream American Corporation, Gulfstream began offering stretched airliner conversions of the base GI. These aircraft were stretched by 3.25m (10ft 8in), allowing seating for up to 38 passengers at three abreast. Known as the G-159C Gulfstream IC the first conversion flew on October 25 1979, and production conversions were delivered from November 1980. However, only five were converted.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Grumman American AA-1 ',56550797.0,'img/0172170-v40-6.jpg',' What became Grumman''s first light aircraft came from the drawing board of noted kit aircraft designer Jim Bede.

The AA-1 began life as the Bede BD-1, a small and compact design using just 385 parts and bonded honeycomb construction. The original BD-1 was powered by a 65kW (90hp) Continental C90-14, and first flew on July 11 1963. Unlike other Bede designs however the BD-1 was not intended for kit building, instead Bede renamed his company the American Aviation Corporation, and placed the BD-1 in series production at the company''s Cleveland plant.

Production aircraft differed from the prototype in having a revised wing layout and vertical tail, a wider track undercarriage and a more powerful Lycoming O-235. First production aircraft were designated the AA-1 Yankee and the first were delivered in 1968, the last in 1971.

The Yankee was replaced in production by the AA-1A Trainer, with a modified wing and equipped for pilot training. It flew for the first time on March 25 1970 and was certificated in January 1971.

In 1972 the AA-1A was replaced by the AA-1B, a revised version with greater takeoff weights. The AA-1B was available as the Trainer, or as the Tr2, a superior spec deluxe version with upmarket interior trim, wheel fairings and more comprehensive standard avionics fit.

Following Grumman Corporation''s acquisition of American Aviation, the AA-1 was produced under the Grumman American Aviation Corporation banner. In 1978 Grumman American introduced the further improved AA-1C with greater takeoff weights, a more powerful O-235 engine and revised tail surfaces. The AA-1C was available as the T-Cat trainer model and as the Lynx more luxurious touring model.

AA-1 production was discontinued mid 1978, just before Gulfstream acquired Grumman American.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Gippsland GA-200 Fatman ',13225923.0,'img/0194943-v40-6.jpg',' The Gippsland GA-200 Fatman is an all new ag aircraft certificated to US FAR Part 23 standards.

The GA-200 is Gippsland Aeronautics'' first indigenous design, and results from more than two decades of experience in modifying other aircraft. In particular Gippsland Aeronautics has extensive experience in modifying the Piper Pawnee, but despite the visual similarity the GA-200 is an all new design.

Features of the GA-200 include a braced low mounted wing, a Textron Lycoming O-540 flat six engine and 800 litre (211US gal/176Imp gal) integral chemical hopper forward of the cockpit. It is of conventional construction with a low mounted braced wing. The single slotted flaps can be extended for tighter turns during spraying operations.

Australian CAA certification in normal and agricultural categories to US airworthiness standards was awarded on March 1 1991. US FAA certification to FAR Pt 23 was awarded in October 1997.

The GA-200 is offered in standard agricultural aircraft and Agtrainer form. The Agtrainer is an ag pilot trainer fitted with a smaller chemical hopper and dual controls.

The GA-200 has won a number of export orders, including several to China. Other aircraft have been built for customers in New Zealand and the USA. Aircraft sold in the US have their airframe sections shipped from Australia with components such as the engine and avionics fitted locally.

Gippsland Aeronautics studied a development of the GA-200 powered by an Australian developed magnesium block V8 engine that would have run on unleaded mogas (the GA-200 already has Australian approval to operate using premium grade unleaded mogas for its O-540). However the company instead focussed its efforts on a more powerful GA-200 powered by an uprated O-540 and an increased max takeoff weight.



 ',' Australia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('GAF N22 & N24 Nomad ',64799903.0,'img/0138046-v40-6.jpg',' The Nomad was developed by Australia''s Government Aircraft Factory from the late 1960s to help provide the facility with work after construction of licence built Mirage jet fighters was completed, and to offer a new rugged STOL utility transport suited to both military and civil operators.

First flight of the prototype Nomad N2 occurred on July 23 1971. A second prototype first flew on December 5 that year. First deliveries of the production N22 (to the Philippines military) began in 1975.

Features of the new utility included retractable undercarriage, two Allison 250 turboprops, a braced high mounted wing with full span double slotted flaps and a squared sided fuselage.

The initial N22 was followed by the N22B with an increased maximum takeoff weight, which was certificated in 1975. The N22 also formed the basis for the Searchmaster coastal patrol aircraft which apart from military users also saw service with Australian and US customs services. The Floatmaster was a N22B fitted with Wipaire floats with retractable undercarriage.

The N22 was stretched by 1.14m (3ft 9in) resulting in the N24. Aimed more at regional airlines (and marketed as the Commuterliner) than utility operators, the main cabin could seat 16. Versions of the N24 offered included the Cargomaster freighter and the Medicmaster aerial ambulance.

Nomad production ceased in 1984, as much due to mismanagement by the Australian government departments entrusted with its development as any faults with the aircraft.

It is interesting to note that GAF was renamed ASTA (Aerospace Technologies of Australia), which was acquired by Rockwell in 1996 and hence was subsequently inherited by Boeing late that year.

 ',' Australia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Fuji FA200 Aero Subaru ',35042067.0,'img/0215625-v40-6.jpg',' The Fuji FA200 Aero Subaru was the first wholly Japanese designed light aircraft to enter series production, with the majority built for export orders.

A product of the Fuji Heavy Industries industrial conglomerate (which was formed through the merger of six different concerns, including WW2 fighter manufacturer Nakajima, and builds Subaru cars), design work on the FA200 began in 1964. A prototype, the FA200II, first flew on August 12 1965.

The basic FA200 design was expected to form the basis of a family of light aircraft including the two seat side-by-side trainer FA200I powered by a 85kW (115hp) Lycoming O235 and the single seat F204 agricultural version. However only the four seat tourer, as represented by the prototype, entered production. This aircraft was of conventional low wing and fixed undercarriage design, and was aerobatic at reduced weights.

Three versions of the FA200 entered production, the first being the 120kW (160hp) powered FA200160, which was also certificated with reduced weights in the Utility category with three seats, and the Aerobatic with two seats. The FA200180 was essentially similar but powered by a 135kW (180hp) fuel injected IO360. Deliveries of both versions began in March 1968.

A third model joined the lineup from mid 1973, the FA200180AO. This was a reduced specification version of the FA200180 with a fixed pitch propeller and caburetted Lycoming O360 engine.

The Aero Subaru remained in production until 1977 when 274 had been built. The type remained available to special order through to 1986, by which time a further 25 had been built.

 ',' Japan ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Fokker 50 ',36921455.0,'img/0116875-v40-6.jpg',' The Fokker 50 was the successor to Fokker''s highly successful and long running F-27 Friendship.

Fokker announced it was developing the 50 seat Fokker 50, together with the 100 seat jet powered Fokker 100, in November 1983. The Fokker 50 is based on the fuselage of the F-27-500 Friendship, but incorporates a number of key design changes. Foremost of the improvements was the new generation Pratt & Whitney Canada PW125 turboprops driving advanced six blade props, giving a 12% higher cruising speed and greater fuel economy, and thus range. Other improvements include new avionics and an EFIS glass cockpit, limited use of composites, small `Foklet'' winglets, and more, squared, main cabin windows.

Two prototypes were built based on F-27 airframes (despite the fact that over 80% of Fokker 50 parts are new or modified), the first flying on December 28 1985. The first production aircraft flew on February 13 1987, certification was granted in May 1987, and first customer delivery, to Lufthansa Cityline, was during August that year.

The basic Fokker 50 production model is the Series 100. With three, instead of four doors, the Series 100 is designated the Series 120. The hot and high optimised Series 300 has more powerful PW127B turboprops, and was announced in 1990. It has higher cruising speeds and better field performance, particularly at altitude.

The only significant development of the Fokker 50 to see the light of day was the Fokker 60 Utility, a stretched utility transport version ordered by the Royal Netherlands Air Force. Fokker built four for the Netherlands air force and looked at offering a passenger variant. The Fokker 60 was stretched by 1.62m (5ft 4in).

Fokker collapsed due to financial problems on March 15 1996 and the last Fokker 50 was delivered to Ethiopian Airlines in May 1997.

 ',' Netherlands ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Fokker F-28 Fellowship ',15480679.0,'img/0116525-v40-6.jpg',' The F28 Fellowship jet was developed to complement Fokker''s highly successful F-27 Friendship turboprop.

Fokker began development of the F28 in 1960 after perceiving a market for a higher performance (ie jet engined) and greater capacity airliner in comparison with the F-27. First details of the F28 were made public in April 1962, and production of the first development aircraft began in 1964. The first of three prototypes flew for the first time on May 9 1967, with certification and first customer delivery both occurring on February 24 1969.

The F28 was developed into a range of models. Initial production was of the Mk 1000, which could typically seat between 55 and 65, and was powered by 43.8kN (9850lb) Spey Mk 55515 turbofans. The Mk 2000 was essentially similar but featured a 2.21m (7ft 3in) fuselage stretch, increasing maximum seating to 79.

The Mks 5000 and 6000 were based on the 1000 and 2000 respectively, but introduced a longer span wing (by 1.49m/4ft 11in) and wing leading edge slats. Neither version attracted serious sales interest, and no 5000s and just two 6000s were built. Another version that did not come to fruition was the Mk 6600, which would have been stretched by a further 2.21m (7ft 3in), allowing for seating for 100 in a high density layout. It was aimed at Japanese airlines.

The final production models were the 3000 and 4000, again based on the 1000 and 2000 respectively. Both introduced a number of improvements, while the addition of two extra above wing emergency exits on the 4000 increased maximum seating to 85. Freight door equipped convertible versions of each model were offered, and are identified by a C suffix.

 ',' Netherlands ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Fokker F-27 & Fairchild F-27 & FH-227 ',39164172.0,'img/0120653-v40-6.jpg',' Probably the closest to being the fabled DC-3 replacement, the Fokker F-27 Friendship, including the Fairchild built F-27 and FH-227, was built in greater numbers than any other western turboprop airliner.

The Fokker F-27 began life as a 1950 design study known as the P275, a 32 seater powered by two RollsRoyce Dart turboprops. With the aid of Dutch government funding the P275 evolved into the F-27, which first flew on November 24 1955. This original prototype was powered by Dart 507s and would have seated 28, by the time the second prototype had flown (in January 1957) the fuselage length grew to allow seating for 32.

By this stage Fokker had signed an agreement that would see Fairchild build Friendships in the USA. The first aircraft to enter service was in fact a Fairchild built F-27, in September 1958.

Fairchild F-27s differed from the initial Fokker F-27 Mk 100s in having basic seating for 40, a lengthened nose capable of housing a weather radar, and additional fuel capacity.

Developments included the Mk 200/F-27A with more powerful engines, Mk 300/F-27B and primarily military Mk 400 Combi versions, the Mk 500 with a 1.50m (4ft 11in) fuselage stretch taking seating to 52, and Mk 600 quick change freight/pax aircraft.

Fairchild independently developed the stretched FH-227, which appeared almost two years earlier than the Mk 500. The FH-227 featured a 1.83m (6ft 0in) stretch over standard length F-27/F-27s, taking standard seating to 52.

 ',' Netherlands ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Fokker 70 ',36921457.0,'img/0269850-v40-6.jpg',' The Fokker 70 is a shortened development of the popular 100 seat class Fokker 100.

Fokker began development of the new derivative airliner in November 1992 despite the absence of firm orders, hopeful of snaring a large share of the forecast 2000 plus aircraft in the 70 to 125 seat class required through to 2010, and the replacement F-28 market. The Fokker 70''s 30.91m (101ft 4in) length is close to that of the F-28-4000''s 29.61m (97ft 2in), on which the Fokker 100 was originally based.

The first Fokker 70 was in fact the second Fokker 100 prototype which was modified by removing two fuselage plugs - one forward and one rear of the wing. Construction on this aircraft began in October 1992 (before the November 1992 program goahead), resulting in the type''s first flight on April 4 1993. The first production Fokker 70 flew for the first time in July 1994 and certification was awarded on October 14 1994. The first Fokker 70 (an Executive Jet 70) was delivered to Ford in the USA later that month.

A design aim of the Fokker 70 was to retain as much commonality with the larger Fokker 100 as possible. As a result they share essentially identical wings, airframes (except for length, and the removal of two emergency overwing exits on the Fokker 70) and systems, plus similar EFIS flightdecks. The Fokker 70 was offered with two flightdecks, one optimised for the 70''s regional airline operations, the other essentially identical to the Fokker 100''s to give operators of both types commonality. The Fokker 70 and 100 also share identical Tay Mk.620 powerplants, although the Tay Mk.650 that was offered for the 100 was not available on the 70. The 70 and 100 were built on a common production line.

As with the Fokker 100, a corporate shuttle, the Fokker Executive Jet 70, was offered (and attracted a small number of orders). The Fokker 70A was optimised for US carriers, while the Fokker 70ER (announced in late 1994) had extra fuel tankage and extended range.

With Fokker''s collapse in 1996, the Fokker 70/100 production line closed in early 1997. Despite Fokker''s financial failure the 70 remains popular with its operators and second hand sales are almost unheard of.

 ',' Netherlands ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Fairchild Dornier 328JET ',55433736.0,'img/1238407-v40-6.jpg',' The Dornier, later Fairchild Dornier 328JET has given a new lease of life to the basic 328 design and was a pioneer of a new class of airliner, that of the 30 seat regional jet.

Fairchild Aerospace took over DASA''s 80% stake in Dornier in early June 1996, which made Dornier a subsidiary of Fairchild. On August 8, 2000, Dornier Luftfahrt GmbH changed name to Fairchild Dornier GmbH.

Development of the 328JET was launched soon after Fairchild Aerospace took over Dasa''s stake in Dornier. A market survey of 50 regional airlines worldwide was launched which confirmed their customer driven preference for jet equipment, as long as the operating economics of a regional jet were competitive. Armed with this information, Fairchild launched the 328JET, a jet engined development of the 328 turboprop, in February 1997.

The most obvious change to the 328 for the 328JET is the addition of FADEC equipped Pratt & Whitney Canada PW306 turbofans mounted in underwing pods. Otherwise the 328JET was designed to be a minimum change development of the 328 turboprop to allow Fairchild to bring the aircraft to market as quickly as possible. Fairchild was able to achieve this because of the turboprop 328''s conservative engineering and clean aerodynamic design. Just two fuselage frames (which the wing and landing gear attach to) required strengthening. A 10cm (4in) extension to the trailing edge flaps cuts aerodynamic drag. Other changes include strengthened landing gear and brakes, slight changes to the software of the Honeywell Primus 2000 EFIS avionics suite, and an APU is standard.

The first 328JET prototype was converted from the second 328 turboprop, and was rolled out on December 6 1997. It first flew from Munich in Germany on January 20 1998. Certification and first deliveries were in July 1999.

Fairchild Dornier considered two stretched developments of the 328JET, the 50 seat 528JET and the 42 to 44 seat PW306B powered 428JET. The 428JET was formally launched in May 1998 and would have been assembled in Israel by IAI, but Fairchild Dornier suspended the program in August 2000 due to not being able to make a viable business case.

The Envoy 3 is a corporate jet/corporate shuttle development of the 328JET with longer range.

On July 1 2002 Fairchild Dornier was declared insolvent and entered administration. In mid-2003 AvCraft Aerospace GmbH acquired the rights to the 328JET together with 18 completed aircraft. However, after a number of aircraft were delivered, they were forced into administration too in March 2005.




 ',' Germany ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Fairchild Dornier 728 ',54515453.0,'img/1521961-v40-6.jpg',' The 728 family was Fairchild Dornier''s ambitious bid to develop a range of regional jet airliners to supplement the smaller 328JET series, and attracted strong airline interest when launched.

Fairchild Dornier launched this new family of regional jets seating from 55 to 100 passengers on May 19 1998, with provisional launch orders from Crossair and Lufthansa for 120 new aircraft.

The lead aircraft in the program was the 70 to 85 seat 728 (previously named 728JET), which made its official roll-out on March 21, 2002, and it was scheduled to make the first flight in the summer of 2002.  Deliveries should have started in mid 2003 to Lufthansa Cityline.

In August 1998 Fairchild announced it had selected General Electric''s FADEC equipped CF34-8D (which has 87% parts commonality with the CF34-8C1 selected to power the competing CRJ-700) ahead of the SNECMA/Pratt & Whitney Canada SPW-14 to power the 728. In September ''98 further 728 suppliers were announced, including Honeywell for its Primus Epic integrated EFIS avionics suite with flat panel LCDs, AlliedSignal (APU and environmental control system), Lucas Aerospace (for a fly-by-wire flight control system), BFGoodrich (landing gear, wheels, tyres, brakes and fuel system), Hamilton Sundstrand (integrated electric system), and Parker Aerospace (hydraulics). CASA would build the wings and empennage.

The base version of the 728 was the 728-100, which would have been followed end 2003 by the extended range and higher payload 728-200. The 200 would have had a 3000kg (6615lb) higher MTOW and a 750km (400nm) increase in range.

In its class, the 728 had the largest cabin (0.51cm wider than the Embraer 170/190, and 0.70cm wider than the CRJ-700) with five-abreast seating.

Following the 728 into service would have been the stretched 95 to 110 seat 928, with first flight scheduled in late 2003, and entry into service in 2005. Apart from the stretched fuselage - cabin length from behind the flightdeck would have been 2.05m (75ft 7in) allowing seating for 95 to 110 passengers - it would also have featured an increased span wing. The shortened 55 to 65 seat 528 (23.38m (76ft 9in) fuselage length and 15.84m (52ft 0in) cabin length) would have followed the 928. The three types would have featured a high degree of commonality, including engine type, and the same flightdeck, allowing a common pilot type rating.

Fairchild Dornier also launched a corporate jet version of the 728, the Envoy 7, which was foreseen to enter service in 2004. The Envoy 7 had intercontinental range and would be equipped with Fairchild Dornier''s "Super Shark" winglets. Corporate versions of the 528 and 928, the Envoy 5 and Envoy 9 respectively, were also planned.

Eight customers, among them Lufthansa Cityline, GECAS, Bavaria Leasing, CSA-Czech Airlines, and SolAir, had (by March 2002) placed firm orders for 125 aircraft and signed options for an additional 164.

However, before the first flight of the 728 had been made, Fairchild Dornier filed for insolvency on April 2 2002, and the whole ambitious program came to an end.



 ',' Germany ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Fokker 100 ',74479022.0,'img/0220410-v40-6.jpg',' Fokker''s largest aircraft, the Fokker 100 is a 100 seat jet airliner based on the F-28 Fellowship, but stretched and thoroughly modernised.

Fokker announced it was developing the Fokker 100 simultaneously with the Fokker 50 turboprop in November 1983. The Fokker 100 is based on the basic F-28 airframe, with the most important and obvious change being the stretched fuselage, increasing maximum seating to 122, compared with 85 in the F-28-4000 (on which the 100 is based). Other changes include more economical RollsRoyce Tay turbofans (which, unlike the F-28''s Speys, conform to Stage 3 noise limits), revised wing design with greater span and aerodynamic efficiency (Fokker claimed it to be 30% more efficient than the F-28''s), a modern EFIS glass flightdeck, redesigned cabin interior plus other systems and numerous equipment changes.

The Fokker 100''s first flight occurred on November 30 1986, certification was awarded in November 1987 and the first customer delivery, to Swissair, occurred in February 1988.

The Fokker 100 was offered in a number of versions including higher gross weight options of the standard airliner, the Fokker 100QC Quick change airliner or freighter with a large forward freight door and the Fokker Executive Jet 100 corporate shuttle or VIP transport, fitted with luxury interiors to customer requirements. It also forms the basis for the shorter Fokker 70, while the 130 seat class Fokker 130 had also been studied.

Fokker collapsed in 1996 and wound up production early the following year. Rekkof (Fokker backwards) Restart has been negotiating to re-open the Fokker 70 and 100 lines.

 ',' Netherlands ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Grumman American AA-5 ',56550798.0,' The four seat AA-5 series is the bigger brother to the two seat AA-1, sharing 60% structural commonality.

The first AA-5 prototype (built by American Aviation) flew on August 21 1970. Primary differences from the AA-1 included the stretched fuselage allowing seating for four, greater span wing, higher max takeoff weight and more powerful 110kW (150hp) Lycoming O-320 engine. Production deliveries of the AA-5 Traveler began in December 1971. The Traveler was instantly popular, especially with its higher cruising speeds than those for other 110kW (150hp) powered light singles including the Cessna 172.

Significant improvements were introduced when Grumman American (following Grumman''s 1972 acquisition of American Aviation) released the AA-5B Tiger. Performance was boosted considerably with a more powerful 135kW (180hp) Lycoming O-360 (giving performance more like that of 150kW (200hp) powered retractable gear singles), while the maximum takeoff weight was increased. Other revisions included increased span horizontal tail surfaces, larger rear cabin windows, greater fuel capacity, revised wheel fairings and deletion of the ventral fin fitted to the earlier Traveler model. The AA-5B was offered alongside the AA-5.

The basic AA-5 was modernised in 1976 as the AA-5A Cheetah with the aerodynamic improvements introduced on the AA-5B, optional extra fuel and other improvements to boost speed slightly.

On September 1, 1978, the Grumman interest in Grumman American was bought by American Jet Industries, and the company was renamed Gulfstream American. Production of the AA-5A and AA-5B continued through the late 1970s until production was suspended late 1979. The production rights to the series were then put up for sale. Over a decade later the American General Aircraft Corporation restarted production of a revised AA-5B in 1990 as the AG-5B. However American General ceased trading in mid 1994 due to poor sales and financial problems.

In 2002 production of an improved AG-5B Tiger was resumed by Tiger Aircraft.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Fairchild Aerospace Metro II, III & 23 ',9234231.0,'img/0156372-v40-6.jpg',' Despite a slow start to sales in the early 1970s, the Metro series has become one of the most popular 19 seat commuters.

The Metro can trace its lineage back to the original Swearingen Merlin I executive transport. From the Merlin I Swearingen developed the turboprop powered II and III which were to form the basis of the new Metro commuter airliner. The Metro was Swearingen''s first complete inhouse design and development work began in the late 1960s, resulting in the SA226TC Metro''s first flight on August 26 1969. The design was similar in appearance and layout to the earlier Merlins, and featured a pressurised fuselage, TPE331 turboprop engines and double slotted trailing edge flaps. Certification was awarded in June 1970 and the first example entered commercial service in 1973.

The Metro II superseded the I from 1975, with improvements to reduce cabin noise levels. The equivalent executive aircraft is the Merlin IV. Following the Metro II from 1981 was the III (by which time Fairchild had taken over Swearingen), which was certificated to SFAR41B allowing greater takeoff weights, while more efficient engines (including the option of Pratt & Whitney Canada PT6As on the IIIA) and greater wing span made the III more economical to operate. The Expediter freighter is based on the III.

The current Metro model is the 23. Certificated to FAR Part 23 (Amendment 34) standards (hence the Metro 23 designation) it features a higher takeoff weight, more powerful engines and systems improvements first introduced on the military C26. The Metro 23 EF has a bulged lower fuselage for greater baggage capacity, while the Merlin 23 and Expediter 23 models are also offered. In 1996 Fairchild studied (but did not proceed with) a Metro with a significantly higher fuselage allowing stand-up headroom (in the style of the Raytheon Beech 1900D).

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('FFA AS-202 Bravo ',8221803.0,'img/0249809-v40-6.jpg',' Although largely in operation with military air arms as a basic trainer, small numbers of the FFA Bravo are also in civilian hands, used primarily as aerobatic and basic pilot trainers.

Design of the Bravo dates back to the late 1960s, with original design work undertaken by SIAI-Marchetti of Italy, but with production and subsequent development work the responsibility of FFA (a company originally established by Dornier as its Swiss subsidiary).

The first prototype to fly was Swiss built, it took to the air for the first time on March 7 1969. An Italian built prototype followed soon after on May 7, while the first production standard aircraft flew on December 22 1971.

Initial production concentrated on the AS-202/15 and 34 were built through to the early 1980s. The definitive production model was the AS-202/18A-4, which first flew in August 1974 and received its certification in late 1975. This version differs from the original 15 in having a more powerful 135kW (180hp) engine. The principle civil Bravo operator was British Aerospace Flight Training (Prestwick) in Scotland which operated 11 (named Wrens). One crashed, but the remaining 10 were sold to Finland where they now fly with Pilot Factory Flight Training (Helsinki).

Two other models have been developed, although single aircraft of each have flown only. The first was the 195kW (260hp) Textron Lycoming AEIO-540 powered Bravo AS-202/26A, which first flew in 1979, the second was the 240kW (320shp) Allison 250-B17C turbine powered Bravo AS-202/32TP which flew in 1991. Swiss certification was awarded in 1995.

The Bravo is still offered for sale although none have been delivered since 1989. In the absence of Bravo production FFA builds components for other manufacturers under subcontract.

 ',' Switzerland ');

INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Extra 230, 300 & 200 ',52509423.0,'img/0220028-v40-6.jpg',' Extra''s aerobatic light aircraft were designed from the outset for unlimited aerobatic competition flying.

The original wooden wing Extra 230 was designed by company founder Walter Extra to meet the requirements of competition pilots with the Swiss Aero Club. First flight occurred during 1983. Unusually for an aircraft of its type the Extra 230 features a wooden wing with dacron covering, while as on other aerobatic competition aircraft the 230''s wing has 0° incidence for sustained inverted flight. Production ceased in 1990 when Extra was experiencing difficulties in sourcing the correct type of wood.

Design work on the larger, two seat Extra 300 began in early 1987, culminating in the first flight of a prototype on May 6 1988 and certification in May 1990. Production began in October 1988.

Small numbers of Extra 260s were also built in the early 1990s. These aircraft were essentially downsized Extra 300s with seating for a pilot only and powered by a 195kW (260hp) IO540 flat six. The Extra 260 was not certificated, the six that were built were able to fly under special permits.

The single seat Extra 300S first flew on March 4 1992 and was certificated that same month. The 300S differs from the 300 in having a single seat, shorter span wings and more powerful ailerons, while retaining the same powerplant and basic fuselage. The 300L has a low mounted wing. The strengthened 330 has a 245kW (330hp) AEIO-580 and larger control surfaces, and first flew in January 1998.

Both the 300 and 300S are stressed for +10/10g flight with a single pilot, have additional transparencies in the lower sides of the fuselage below the wings for pilot visibility, and a single piece canopy.

Extra''s latest product is the 150kW (200hp) AEIO360 powered Extra 200 two seater. It first flew in April 1996. Of similar construction to the 300, it replaces the earlier 230.

 ',' Germany ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Eurocopter/Kawasaki BK 117 ',4326310.0,' The BK 117 was developed under a joint collaborative effort between MBB of Germany (now part of Eurocopter) and Kawasaki of Japan, resulting in production lines in both countries.

The BK 117 program replaced the independently developed BO 107 and Kawasaki KH7 design studies. The BK 117 retains the former''s overall configuration, with Eurocopter responsible for the helicopter''s rotor system (which uses a scaled up version of the BO 105''s four blade rigid main rotor), tail unit, hydraulic system and power controls, while Kawasaki has responsibility for the fuselage, transmission and undercarriage.

Development led to the BK 117''s first flight on June 13 1979, the first production aircraft (built in Japan) flew December 1981, certification was awarded in December 1982, and first deliveries took place early in 1983. Initial production was of the BK 117 A1, while the BK 117 A3 with higher max takeoff weight and enlarged tail rotor with twisted blades was certificated in March 1985. The BK 117 A4 introduced from 1987 features increased performance through an increased transmission limit at takeoff power, improved tail rotor head and, on German built aircraft, increased fuel.

The BK 117 B1 (certificated in 1987) has more powerful engines and better performance, the BK 117 B2 is currently in production and has an increased max takeoff weight. The BK 117 C1 is a German development with Turboméca Arriel engines, while the BK 117 C-2 now underdevelopment features improvements from the EC 135 including new avionics.

 ',' Germany and Japan ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Eurocopter EC-135/635 ',88481706.0,'img/0106296-v40-6.jpg',' The EC-135 is intended as a replacement for Eurocopter''s successful BO-105 light twin, and is developed from the BO-108 technology demonstrator.

The original MBB BO-108 was intended as a high technology helicopter demonstrator, and as such incorporated a range of high technology features including a hingeless main rotor (Sikorsky and Boeing adopted this design for their military RAH-66 Comanche), all composite bearingless tail rotor, shallow transmission (allowing greater cabin height) with special vibration absorbers, composite structures, improved aerodynamics, modern avionics and EFIS instrumentation. The first BO-108 was powered by Allison 250-C20R3 turboshafts and flew on October 15 1988.

The success of the BO-108 test program led to MBB''s announcement in January 1991 that it would develop a production 108 with Arrius or PW-206 engines as a replacement for the BO-105, with certification planned for 1994 and deliveries in 1995. However the formation of Eurocopter (in January 1992) gave the program access to Aerospatiale''s Fenestron shrouded tail rotor technology which was then incorporated into the design.

The combination of the BO-108 and the Fenestron led to the definitive EC-135 flying for the first time on February 15 1994. German certification was granted on June 14 1996, while US approval was given on July 31 that year, the same day as the first customer delivery.

The PW-206 powered model is designated EC-135P-1, the EC-135T-1 has the Arrius 2B1.

The designation for dedicated military versions is EC-635.




 ',' Germany and France ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Eurocopter BO 105 & EC Super Five ',24367253.0,'img/0039889-v40-6.jpg',' In widespread military and civilian service, the BO 105 is MBB''s (now part of Eurocopter) most successful helicopter design. <p>Construction of the first of three prototypes began in 1964, the first of which made the type''s first flight on February 16 1967. This aircraft was powered by 236kW (317shp) Allison 250C18 turboshafts and featured a conventional main rotor hub, but the subsequent prototypes incorporated a new rigid hub with feathering hinges, plus composite blades and MANTurbo 6022 engines. The BO 105 reverted back to Allison 250 power with the second of two preproduction aircraft, flying in this form in January 1971. <p>Initial production was of the BO 105C which was available from 1970. The Allison 250C20 powerplant became standard from 1973. The BO 105 CB was introduced in 1975, and became the standard production model. It introduced uprated engines and a strengthened transmission. The BO 105 is now built in BO 105 CBS form with a slight 25cm (10in) fuselage stretch and extra window, allowing an extra passenger to be carried. <p>The BO 105 D has IFR instrumentation and was developed for the British offshore oil rig support market. The BO 105 L has more powerful engines and higher takeoff weight. The BO 105 LSA-3 is a hot and high version with Allison 250C28C engines and built exclusively in Canada by Eurocopter Canada. The BO 105 LSA-3 Super Lifter has been developed for aerial crane work and has a 2850kg (6283lb) max takeoff weight. <p>The EC Super Five is a high performance development of the BO 105 CBS with new main rotor blades. It was certificated in late 1993. <p> ',' Germany ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Eurocopter EC-120 Colibri ',16044770.0,'img/0266831-v40-6.jpg',' Eurocopter''s solution to develop a new light helicopter lay in forming a partnership with CATIC (Harbin) of China and Singapore Technologies Aerospace of Singapore.

Eurocopter (then Aerospatiale), CATIC and STA launched definition development of a new light helicopter, then designated P-120L, in February 1990. The teaming arrangements for the helicopter saw Aerospatiale/Eurocopter take a 61% program share and leadership, CATIC with 24% and STAe with 15%. A development goahead contract for the new aircraft was signed in October 1992 (by which time Aerospatiale''s helicopter activities had been merged into Eurocopter) and the EC-120 designation was announced in January 1993 (the Colibri [Hummingbird in English] name came later). Design definition was completed in mid 1993.

Within the Eurocopter/CATIC/STAe partnership, Eurocopter is responsible for the design and manufacture of the rotor system and transmission, final assembly (at Marignane in France), flight testing and certification. CATIC builds the EC-120''s fuselage, landing gear and fuel system, while STAe''s areas of responsibility covers the tailboom, fin and doors.

Notable Colibri design features include a three blade main rotor with a Spheriflex hub integrated with the driveshaft and transmission, composite main and tail rotor blades and skid landing gear, a metal construction fuselage and a new eight blade Fenestron shrouded tail rotor. The Turboméca TM-319 Arrius 1F turboshaft was selected to power at least the first 300 Colibris. The Colibri''s cabin features standard seating for five including the pilot.

The first of two EC-120 prototypes first flew on June 9 1995 from Eurocopter France''s Marignane facility. French DGAC certification was awarded in June 1997, while the first production Colibri first flew in December that year.

 ',' France, Germany, China and Singapore ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Eurocopter AS-365N Dauphin 2 & EC-155 ',87073242.0,'img/0570356-v40-6.jpg',' The (originally Aerospatiale) AS-365N Dauphin 2 is one of Eurocopter''s most successful designs and has found widespread use in corporate, police, media, EMS and search and rescue roles worldwide.

The AS-365N is a much improved development of the original SA-365C Dauphin 2 (described under Aerospatiale). Until January 1990 the AS-365 models were designated SA-365, and in 1992 Aerospatiale''s helicopter division was incorporated into Eurocopter. The AS-356N introduced more powerful Arriel 1C turboshafts, enlarged tail surfaces, revised transmission, main rotor, rotor mast fairing and engine cowling, and retractable tricycle undercarriage. The AS-365N first flew on March 31 1979. Deliveries began in early 1982.

The US Coast Guard took delivery of 99 HH-65A Dolphins (SA-366G-1). These aircraft are powered by Textron (Avco) Lycoming LTS-101s and are optimised for the USCG''s search and rescue role.

Deliveries of the improved AS-365N-2 commenced in 1990. It features upgraded Arriel 1C2 engines, improved gearbox, increased max takeoff weight, redesigned cabin doors, revised interior and optional EFIS instrumentation.

The AS-365N-3 is a hot and high development with FADEC equipped Arriel 2Cs. Deliveries began in December 1998.

The improved EC-155 (initially AS-365N-4) development was announced at the 1997 Paris Airshow. It features twin Arriel 2Cs equipped with FADEC, a five blade Spheriflex main rotor and a 40% larger main cabin, achieved with bulged doors. First flight was on June 17 1997, with French and German certification awarded in December 1998.

Military AS-365Ns have been offered as AS-565 Panthers. Utility versions are the AS-565UA/UB, attack versions are the AS-565AA/AB, while the AS-565MA/MB are equipped for naval search and rescue, and the AS-565SA/SB for ASW (Anti Submarine Warfare) duties.

 ',' France ');

INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Eurocopter AS 332 Super Puma ',33284531.0,'img/0131230-v40-6.jpg',' A larger development of the Puma (described under Aerospatiale), the Super Puma is a practical and proven medium lift twin helicopter, particularly popular for offshore oil rig support work.

The original SA 330 Puma, on which the Super Puma is based, flew for the first time in April 1965. The first Super Puma first flew in September 1978 and was essentially a more powerful version of the Puma, featuring 1270kW (1700shp) Turboméca Makila turboshafts, new avionics, composite rotor blades and an enlarged fuselage. For a time Aerospatiale planned to fit the Super Puma with a Fenestron shrouded tail rotor, but testing revealed no significant performance benefits. Commercial versions were designated AS 332Cs.

The AS 332L (or SA 332L before 1980) Super Puma introduced a stretched fuselage (by 76.5cm/2.5ft), first flew on October 10 1980 and was certificated in 1983. The updated AS 332L1 with Makila 1A1 engines appeared in 1986. Bristow Helicopters ordered 31 specially customised AS 332Ls for its North Sea offshore oil rig work, and these are named Tiger.

The AS 332L remains in production but is progressively being replaced by the AS 332L2. The L2 Super Puma Mk II (known as the Cougar in military guise) features a further fuselage stretch permitting a further row of seats, EFIS flight instrumentation, spheriflex rotor heads and longer main rotor blades with parabolic tips. It was certificated in 1992.

 ',' France ');

INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Erco Ercoupe and derivatives ',54024178.0,'img/0143948-v40-6.jpg',' In 1937, Fred Weick of Erco (The Engineering and Research Corp) developed the model 310, which was the basis for the distinctive Ercoupe.

The first flight was made on October 1, 1937 with a 37hp Continental A-40 engine, which was later replaced by a 55hp Erco IL-116. Fred Weick''s research into safe airplanes was employed in the design. The rudder controls were eliminated and the aircraft was handled by the control wheel only, making it easy to fly and making stalls and spins almost impossible. Later models reverted to conventional rudder bars, as existing pilots tended to be confused by the system. A novel fixed tricycle landing gear for better ground handling was installed, and the cockpit was designed to have allround visibility.

The aircraft was a low-wing cabin monoplane with side-by-side seating for two, and had an all-metal fuselage with fabric-covered wings, but later production had all-metal wings. The 310 was originally flown with a single fin, but during development this was replaced by twin tailfins. After three years of exhaustive testing, on March 25, 1940, the type certificate was issued to the production model, the 415C, which was powered by a 65hp Continental A-65-8 engine. Production was halted in 1941 after 112 aircraft had been built, as all aluminum was needed for the war effort. One 415C was evaluated by the Air Force as an observation aircraft, designated YO-55, and two more were tested as target drones, designated XPQ-13, but the aircraft was not found suitable for military service.

In August 1945 production of the 415C was resumed, with some improvements and a 75hp Continental C-75-12 engine. In February 1946, Fred Weick received the Fawcett Aviation Award for the greatest contribution to the scientific advancement of private flying. Post-war, Erco built 4,408 model 415C, 77 model 415D, and 275 model 415CD. In 1950, they ceased production of the Ercoupe because light aircraft production became uneconomic for them.

Production of the Ercoupe was handed over to Sanders, who completed 209 aircraft from Erco parts as the 415E (85hp Continental C-85-12 engine), 415F (90hp C-90), 415G ClubAir (85hp C-85-12 with an additional rear kid''s seat), and 415H (75hp C-75). In 1954 the type certificate was sold to Vest aircraft, who did not built any aircraft, but sold it on to Forney in April 1955.

Forney produced 139 aircraft as the F-1 and F-1A Aircoupe with many details improved, and powered by a 90hp Continental C-90-12F engine. Forney changed name to Fornaire in 1959, and the F-1 was now available with differing standards of equipment as the Execta, Expediter, and Explorer.

Air Products took over production in 1960 and built another 26 as the F-1A Aircoupe until 1962. In 1964 Alon started to build the design as the A-2 and A-2A Aircoupe with a 90hp Continental C-90-16F engine, a sliding bubble canopy, and other changes. Alon merged with Mooney in 1967, who continued to build the A-2A, but in 1969 they redesigned the aircraft with a single fin as the M-10 Cadet. In 1970 the last ones were produced.
 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Eurocopter AS-355 Ecureuil 2 ',71904270.0,'img/0269017-v40-6.jpg',' The twin engined member of the Ecureuil (= Squirrel) family, the AS-355 Ecureuil 2 offers greater performance, carrying capability and the increased safety benefits of twin engines compared to the single engined AS-350.

Development of the first twin engine Ecureuil began early in the model''s development life, with the first flying on September 28 1979. This prototype was powered by two Allison 250-C20F turboshafts, supplying power to the main and tail rotors through a combining gearbox. Put into production as the AS-355E, it was essentially a twin engined version of the AS-350 with detail changes made to the fuselage structure, fuel system, transmission and main rotor blades to support the twin engine configuration. In common with the AS-350, the AS-355 features the maintenance free Starflex main rotor hub, while the main rotor blades are of composite construction.

The AS-355F replaced the AS-355E from early 1982, and introduced new wider chord main rotor blades and a higher max takeoff weight. The AS-355F was followed by the AS-355F-1 in January 1984 and AS-355F-2 in December 1985, which introduced progressively higher maximum takeoff weights.

The current production model is the AS-355N Ecureuil 2 which introduced twin Turbomeca TM-319 Arrius turboshafts. It was certificated in 1989 and first deliveries took place from early 1992. It is marketed in North America as the TwinStar. As with the single engined AS-550, the twin engine military AS-555 is marketed as the Fennec (the AS-555SN is fitted with a chin mounted search radar for ASW).

Aerospatiale''s helicopter division was integrated into Eurocopter in January 1992.

The AS-355 is built under licence in Brazil as the Helibras HB-355 Esquilo.

 ',' France ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Embraer ERJ-170/175/190/195 ',2014153.0,'img/0797766-v40-6.jpg',' The Embraer ERJ-170 and ERJ-190 series are all new entrants into the top end of the regional jet airliner market, with seating capacities spanning from 70 to 108.

Embraer announced the ERJ-170 and ERJ-190 in February 1999, and formally launched the program on June 14 that year at the Paris Airshow.

The first member of the family is the 70 seat Embraer 170, which rolled out on October 29 2001 (when the ERJ prefix was dropped for the marketing designation) and first flew on February 19 2002. Six aircraft were being used in the flight test program.

The public debut was at the Regional Airline Association convention at Nashville, Tennessee in May 2002, followed by its European debut at the Farnborough International Air Show in July the same year. The 170 was certificated in February 2004 and deliveries started in March 2004 to LOT Polish Airlines, US Airways and Alitalia Express.

Embraer is also building the Embraer 175, stretched by 1.77m (5ft 10in) over the Embraer 170. The first flight was made on June 14 2003.

The 6.25m (8ft 5in) stretched Embraer 190 seats 98 passengers, the further stretched Embraer 195, 2.41m (7ft 11in) longer than the 190, will seat 108. The Embraer 190 made the first flight in March 2004, followed by the 195 in December the same year.

All three variants are offered in standard and LR (long range) variants. A corporate jet version of the 170 is also proposed.

Features of the family include new FADEC equipped GE CF34 engines (the most powerful CF34 variants), a new four abreast "double bubble" fuselage cross section, a moderately swept wing with winglets (added to the design in mid 2000), fly-by-wire flight controls, and Honeywell Primus Epic EFIS avionics.

Although Embraer 170/175/190/195 are the marketing designations, the official type certificate designations remain ERJ prefixed as ERJ-170/175/190/195.


 ',' Brazil ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Embraer ERJ-145 ',91977281.0,'img/0472407-v40-6.jpg',' Despite a chequered early development history, the 50 seat ERJ-145 has become a runaway sales success.

Embraer began working on 50 seat regional jet concepts in the late 1980s. The original EMB-145 (the marketing designation later became ERJ-145) was launched in mid 1989 and would have been a stretched and jet engined EMB-120 Brasilia. Features of this design included a straight wing with winglets and the two turbofans mounted forward of the wing as on most low wing turboprops. This design would have seated 45 to 50 passengers and featured 75% commonality with the Brasilia. In that configuration cruising speed would have been 740km/h (400kt) and range with a 4500kg (9920lb) payload 2500km (1350nm).

But by 1990 Embraer was studying a modified design with less commonality to the Brasilia as wind tunnel testing revealed that the original configuration would not reach its design performance objectives. Changes to this interim design included a mildly swept wing with winglets (wing sweep of 22.3°) and conventional below wing mounted engines. Wind tunnel testing proved that this configuration met design objectives however it had a major drawback in that it would have needed an unusually high undercarriage.

Thus in late 1991 Embraer froze the ERJ-145 design with rear fuselage mounted engines and T-tail, and no winglets. Other features include Rolls-Royce (Allison) AE-3007A turbofans and a Honeywell Primus 1000 EFIS avionics suite with five colour CRT screens in the flightdeck. The Brasilia''s three abreast fuselage cross section was retained.

The ERJ-145''s first flight took place on August 11 1995 with first deliveries from December 1996 to Continental Express. Continental''s initial order for 25 was a major fillup for the program and opened the floodgates for a number of major sales.

Embraer has developed several versions of the ERJ-145, the initial ERJ-145ER, the higher max takeoff weight longer range ERJ-145LR introduced in 1998 and most recently the ERJ-145XR (Extra Long Range). The 145XR first flew on June 29 2001 and entered service in October 2002. It features uprated yet more fuel efficient 36kN (8110lb) engines, winglets, 24,100kg (53,131lb) max takeoff weight, a max cruising speed of Mach 0.8 (852km/h/460kt) and increased fuel capacity for a 3705km (2000nm) range. The ERJ-145EP and -EU are -ERs with different max takeoff weights, and the ERJ-145LU and -MP are -LRs with different max takeoff weights.

Other EMB-145 developments are the AEW&C (Airborne Early Warning and Control) EMB-145SA with an Erieye radar on top of the fuselage (serving with the Brazilian Air Force as R-99A), the EMB-145AEW which is the export variant of the EMB-145SA (for Greece and Mexico), the EMB-145RS, a remote sensing variant (serving with the Brazilian Air Force as the R-99B and with the Mexican Air Force) and the maritime patrol and ASW EMB-145MP/ASW which will serve with the Brazilian Air Force as P-99. The standard EMB-145ER serves as the C-99A in the Brazilian Air Force.

Since mid 2004, the ERJ-145 is also assembled in China by Harbin Embraer.

The shorter fuselage ERJ-135 and ERJ-140 and the corporate transport EMB-135BJ Legacy are described separately.



  ',' Brazil ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Gippsland GA-8 Airvan ',38928937.0,'img/0298553-v40-6.jpg',' The GA-8 Airvan is the second all new aircraft design from Australian manufacturer Gippsland Aeronautics, and has been designed as a utility transport to replace the popular Cessna 206/207 series and others such as the de Havilland Canada Beaver.

Design work on the Airvan began in early 1994 and prototype construction commenced soon after. This prototype flew for the first time on March 3 1995 and publicly appeared at the Australian International Airshow and Aerospace Expo at Avalon later that month after having completed just eight flying hours.

At that time Gippsland Aeronautics anticipated that the Airvan could be certificated within 12 months, all being well. Unfortunately the prototype subsequently crashed during spinning trials in February 1996, pushing back somewhat the planned certification and entry into service dates.

The prototype Airvan was powered by a 185kW (250hp) Textron Lycoming O-540 driving a two blade propeller. A second prototype flew in August 1996, powered by a 225kW (300hp) IO-540. This was to be replaced with a 225kW (300hp) IO-580 but production aircraft will have an IO-540-K as detailed above.

Other Airvan design feature include its high mounted two spar wing which is based on the unit on the GA-200 ag aircraft, the square sided large volume fuselage with a large sliding freight door on the port side, and fixed landing gear designed for rough field operations. Wiplane floats will be offered as options.

First customer deliveries are planned for 1999 following Australian and US FAA certification. The Airvan should prove to be a keenly priced competitor to Cessna''s new production 206H, which is expected to cost more and is slightly smaller (seating six rather than eight). Gippsland Aeronautics also sees the Airvan as a worthy replacement for ageing 206/207s and DHC Beavers which have had to soldier on in service due to the lack of a suitable, cost effective replacement type.

 ',' Australia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Embraer ERJ-135/140 & Legacy ',26528976.0,'img/1149566-v40-6.jpg',' The ERJ-135 and more recent ERJ-140 are shortened developments of the 50 seat ERJ-145, while the Legacy is a corporate development of the ERJ-135.

Embraer launched the ERJ-135 on September 16 1997. Just nine and a half months passed before first flight on July 4 1998 (following rollout on May 12 that year). A second prototype first flew in October 1998, US FAA certification was awarded on July 16 1999 and first delivery was to Continental Express on July 23 1999.

The speed of the development program illustrates that the ERJ-135 is a fairly straightfoward development of the 145. Both 135 prototypes were converted from ERJ-145 prototypes, requiring little modification other than the removal of two fuselage plugs totalling 3.50m (11ft 6in) in length.

Other changes compared with the -145 are minor. Both are powered by Rolls-Royce (Allison) AE-3007 turbofans but the ERJ-135''s are derated by around 5%, achieved by a slight software change to the engines'' FADEC system. The only other notable change is new valves in the air-conditioning system.

Like the ERJ-145 therefore, the 135 also features a Honeywell Primus 1000 avionics suite with five large multifunction displays in the cockpit, a Sundstrand APU and three abreast seating in the main cabin.

Also in common with the ERJ-145, the 135 is offered in standard ERJ-135ER and extended range ERJ-135LR forms. The LR features an additional fuel tank and slightly more powerful AE-3007A4 turbofans.

Few new airliners have sold as quickly from their launch as the ERJ-135. Building on the success of the 145, the 135''s order book stood at 145 at late 1998, barely a year after launch. The aircraft''s two biggest customers were American Eagle which ordered 75 and optioned 75 at the 1998 Farnborough Airshow to join 42 firm ordered ERJ-145s, and Continental Express with 25 firm and 50 optioned to complement 75 ERJ-145s it had on order.

In September 1999 Embraer launched the third member of its regional jet family, the 44 seat ERJ-140. The ERJ-140 is also a minimum change development, and differs from the 135 and 145 only in its fuselage length and seating capacity. First flight was on June 27 2000 and deliveries began in late July 2001.

The 140 is largely aimed at US airlines who have to contend with pilot labour agreement restrictions on the numbers of 50 seater jets they can operate. American Eagle was the launch customer.

Meanwhile at Farborough 2000 Embraer launched development of the ERJ-135 based Legacy corporate jet. First flight (of a converted ERJ-135) was on March 2001. The Legacy features additional fuel giving a range with 10 passengers of 5930km (3200nm).

Although the marketing designations are ERJ-135, ERJ-140 and Legacy, the certification designations remain as EMB-135ER/LR for the ERJ-135ER/LR, EMB-135KL for the ERJ-140LR and EMB-135BJ for the Legacy.



 ',' Brazil ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Embraer EMB121 Xingu ',29107160.0,'img/0077229-v40-6.jpg',' The sleek looking Xingu coupled the Bandeirante''s wing and engines with an all new fuselage, but was only produced in modest numbers.

The Xingu flew for the first time on October 10 1976, with a production aircraft following on May 20 1977. The first customer delivery occurred later that same year (to the CopersucarFittipaldi Formula One racing team).

The major customer for the Xingu I was the French military, with a total order for 41 (for aircrew training and liaison duties for the air force and navy), which accounted for almost half of all EMB121 production.

Several derivatives of the Xingu design were proposed, including the original EMB120, the Araguia, a commuter airliner which would have seated 25, and the EMB123 Tapajós. The Tapajós would have had more powerful 835kW (1120shp) PT6A45 engines (which also would have powered the Araguia), increased wing span and a lengthened fuselage.

A more modest development did enter production, the EMB121B Xingu II. This introduced more powerful engines, four blade props, increased fuel tankage and greater seating capacity courtesy of a slightly stretched fuselage. Similar in size, powerplant and performance to the Raytheon Beech King Air B200, the Xingu II made its first flight on September 4 1981.

Production ceased in August 1987 after 105 had been built.

 ',' Brazil ');

INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Douglas DC-8-60/70 ',22625801.0,'img/1363676-v40-6.jpg',' The successful DC-8 Super 60 airliners are stretched developments of the DC-8 Series 50. The Super 70s are Super 60s re-engined with CFM56 high bypass turbofans.

Douglas announced the DC-8 Super Sixty series in April 1965. The first, a DC-8-61, took to the skies for the first time on March 14 1966, followed by the first flights of the DC-8-62 on August 29 1966 and the DC-8-63 on April 10 1967. The DC-8-61 differed from the earlier DC-8-50 in having two fuselage plugs which increased length by 11.18m (36ft 8in), increasing max seating capacity to 259 (the largest of any single aisle airliner prior to the 757-300) and underfloor freight capacity by 80%. Intended for domestic operations, its max takeoff weight was identical to the DC-8-50.

The Super 62 was intended for long range operations and featured only a modest .04m (6ft 8in) stretch compared to the Series 50, greater wing span, revised engine nacelles and pylons and significantly increased fuel capacity. The Super 63 meanwhile combined the DC-8-61''s fuselage with the DC-8-62''s wings. It was the final DC-8 variant in production, and the last was delivered in May 1972.

McDonnell Douglas initiated a re-engining program of Super 60 series aircraft with CFM International CFM56 engines in the early 1980s, known as the Super 70 Series. The first converted airframe flew in August 1981. The Super 70 aircraft are considerably quieter than their predecessors, with better fuel economy and greater range.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('EH Industries EH 101 ',47553696.0,'img/0073623-v40-6.jpg',' EH Industries offers commercial developments of its EH 101 aimed at offshore oil rig support, airport/city centre shuttle and utility operations. <p>EH Industries is a collaborative venture between Westland of the UK and Agusta of Italy (in 1998 both companies agreed to merge) which was formed to develop an anti submarine warfare helicopter for the Royal Navy and Italian navy. The partnership was formed in 1980, and both companies have a 50% holding. From the outset both companies intended to develop civil and commercial models of the EH 101. Westland has design responsibility for the Heliliner, the anti submarine warfare variant is being developed jointly, while Agusta heads development of military and utility transport versions with a rear loading ramp. <p>EH 101 full scale development began in March 1984. The first flight of an EH 101 (the Westland built PP1) was on October 9 1987, while the first civil configured EH 101, PP3, first flew on September 30 1988. The first production EH 101 (a Merlin for the Royal Navy) first flew in December 1995. <p>While the Royal Navy''s EH 101 Merlin ASW helicopters and the Royal Air Force''s Merlin HC.3 tactical transports will have RollsRoyce Turboméca RTM322 engines, Italian and civil EH 101s will have General Electric CT7 engines. <p>The 30 seat Heliliner is optimised either for offshore oil rig or airport to city centre transfers, and the rear freight door is offered as an option, while the civil utility version has the rear ramp fitted as standard. Canada''s military has ordered 15 similar AW320 Cormorants for search and rescue work. <p>So far Tokyo''s police is the only civil EH 101 customer. In late 1998, two preproduction machines - PP3 and PP9 - began a program of simulated commercial and military operations in the North Sea based from Aberdeen in Scotland, part of efforts to validate reliability and maintainability. <p> ',' Italy and United Kingdom ');


INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Douglas DC-7 ',6947035.0,'img/0109783-v40-6.jpg',' Douglas'' largest and last piston engined airliner, the DC-7 was one of the first airliners capable of nonstop trans Atlantic crossings between New York and London.

Previously the DC-7 designation had applied to a commercial development of the C74 Globemaster I that PanAm had ordered. As it emerged though the DC-7 arose from an American Airlines requirement for a stretched longer range development of the DC-6. The resulting aircraft was based on the same wing of the DC-6 (also the same basic wing designed for the DC-4), with a stretched DC-6 fuselage, more powerful Wright Turbo Compound engines and extra fuel allowing Douglas to guarantee it could offer nonstop transcontinental US range in both directions.

The prototype DC-7 flew for the first time on May 18 1953, and the type entered service with American that November. Production of the initial DC-7 was solely for US domestic operators. The improved DC-7B had the same dimensions as the DC-7, but carried extra fuel, allowing PanAm to inaugurate nonstop New York/London services from June 1955.

While the DC-7B could fly New York/London nonstop, weather conditions often forced reverse services to make a refuelling stop at Gander. This operational hurdle gave Douglas the impetus to develop the ultimate DC-7 model, the DC-7C `Seven Seas''. The DC-7C featured extra fuel capacity, a .05m (10ft) fuselage stretch and more powerful engines, and could cross the North Atlantic nonstop in either direction. It entered service in April 1956, although sales were restricted by the coming availability of jets.

Today a small number DC-7s survive, mainly as freighters. Douglas offered DC-7F conversions from 1959 (the DC-7F described above is based on the DC-7B). Others are used for firebombing.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Douglas DC-6 ',6947035.0,'img/1351013-v40-6.jpg',' While the DC-3''s and DC-4''s civilian careers were interrupted by WW2, the opposite applies to the DC-6, which started off in response to a military airlift requirement, and went on to become Douglas'' most successful four engined piston airliner.

During the latter stages of WW2 Douglas began work on a developed DC-4 for postwar commercial use. However the improved DC-4 (which would feature a 2.11m/6ft 11in fuselage stretch and P&W R-2800 Double Wasp engines) soon attracted the attention of the US Army Air Force, which devised a requirement which the new transport was developed against. A prototype was built, designated XC-112, but it did not fly until February 15 1946, by which time the war was over and the military requirement no longer stood.

Instead Douglas continued development of the type as a long range airliner, resulting in the DC-6. The XC-112 served as the prototype for the DC-6 program. US airlines had already shown strong interest in the new transport, with launch orders for the DC-6 placed in September 1944. The first production DC-6 first flew in June 1946 and service entry, with United Air Lines, occurred on April 27 1947. However early service was not smooth with the fleet grounded for four months from November that year after two internal fuselage fires in flight, one being fatal, caused by fuel venting entering the cabin heater ram air intake.

The availability of the more powerful R-2800 engines with water/methanol injection prompted Douglas to develop the further stretched DC-6A Liftmaster freighter (first flight September 29 1949) and the equivalent passenger DC-6B (first flight February 2 1951). The DC-6C, the last DC-6 model to be developed, was a convertible passenger/freight version of the DC-6A.

Meanwhile renewed military interest in the DC-6 was sparked by the Korean War, with the result that large numbers of USAF C-118s and USN R6D-1s were built. Many of these were later sold to civilian operators. ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Dornier Do 28 & 128 ',53999671.0,'img/0094730-v40-6.jpg',' The Do 28 Skyservant was the second aircraft to bear the Do 28 designation, but is similar only in overall configuration to the first Do 28.

Dornier''s original Do 28 first flew in 1959 and was a twin engined development of the high wing single engine Do 27 utility. The Do 28 Skyservant first flew on February 23 1966, and while it retained the earlier Do 28''s high wing and unique side mounted engine configuration, was a completely new aircraft. Other design features of this unusual looking aircraft were the fixed tailwheel undercarriage, with the faired mainwheels mounted under the engines. FAA certification was granted on April 19 1968.

The Do 28 was developed into a number of progressively improved variants, from the original D, through the D1 and D2, to the 1282, introduced in 1980. Each variant introduced a number of detail changes. Most Do 28 production was for military customers, notably Germany, although a small number were delivered to commercial operators.

An initial turboprop version of the Do 28, designated the Do 28D5X, first flew in April 1978, fitted with two Avco Lycoming LTP 1016001As derated to 300kW (400shp).

However production turboprop Dornier 1286s feature Pratt & Whitney Canada PT6As, with the first such configured aircraft flying in March 1980. Only a small number were built between then and 1986, when production ceased, and again most aircraft were for military customers.

 ',' Germany ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Douglas DC-3 ',6947035.0,'img/0115727-v40-6.jpg',' No greater accolade for the DC-3 exists than the fact that over six decades after its first flight more than 400 remain in commercial service worldwide. Durability, longevity and profitability are but three of this outstanding aircraft''s virtues. <p>Development of the DC-3 traces back to the earlier oneoff Douglas Commercial 1 (DC1) and subsequent DC2 which made their first flights in 1933 and 1934 respectively. In 1934 American Airlines requested that Douglas develop a larger more capable version of the DC2 for transcontinental US sleeper flights. The resulting DC-3 (or DST - Douglas Sleeper Transport as it then was) flew for the first time on December 17 1935. <p>An almost instant sales success, the DC-3 became the mainstay of the US domestic airline network in the years prior to World War 2. Aside from passenger comfort and appeal, the DC-3 offered that most important of virtues, profitability, with the result that over 400 had been sold to airlines prior to late 1941. <p>The entry of the United States into WW2 in December 1941 had a profound effect on the fortunes of the already successful DC-3. The US Army Air Force''s requirements for transport aircraft were admirably met by the inproduction DC-3, with the result that as the C47 Skytrain it became the standard USAAF transport during the war. More than 10,000 were built for service with US and allied air arms. <p>After the war many of these aircraft became surplus to requirements and were sold off at bargain prices. The result was that demilitarised C47s became the standard postwar aircraft of almost all the world''s airlines and the backbone of the world airline industry well into the 1950s. Its availability and reliability meant it proved extremely popular. Even today hundreds remain in service. <p>A postwar update of the DC-3, the Super DC-3, involving a stretched airframe and more powerful engines, was commercially unsuccessful. This aircraft first flew in June 1949. A small number were built for the US Navy as the R4D8 and for a US domestic airline, and a few remain in service. <p> ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Douglas DC-4 ',6947035.0,'img/0113419-v40-6.jpg',' The history of the DC-4 dates back to when United Airlines devised a requirement for a four engine long range airliner. <p>United looked to Douglas to fulfil the requirement, who devised the highly ambitious DC-4E (where the E stood for experimental). This four engined behemoth was flight tested in 1939. It was roughly three times the size of the DC-3 (its wingspan was 42.17m/138ft 3in, and length 29.76m/97ft 7in), had triple tail surfaces, tricycle undercarriage, was pressurised and potentially could fly nonstop from Chicago to San Francisco. <p>However all the ground breaking new technology on the DC-4E meant that it was costly, complex and had higher than anticipated operating costs, so Douglas thoroughly revised the design, resulting in the smaller and simpler definitive DC-4. <p>The new DC-4 was developed under the darkening clouds of WW2, and upon the USA''s entry into war all DC-4s then on the production line were requisitioned for the US military. The result was that the first DC-4 flew for the first time on February 14 1942 in military markings (as the C-54 Skymaster). The DC-4 was found to admirably suit the USAAF''s requirement for a long range cargo transport, and 1162 were built through the war years. <p>As was the case with the DC-3, the end of war meant that much of that number were surplus and sold to the world''s airlines. Further to this Douglas built an additional 78 DC-4s to new orders. Over the years the survivors have been passed down to charter and freight airlines, and today small numbers survive in service as freighters. <p>Notable developments of the DC-4 include Aviation Trader''s much modified Carvair freighter (described separately) while Canadair built a number with RollsRoyce Merlin engines and pressurised fuselages. The DC-4 also formed the basis for the larger DC-6 and DC-7 which are described separately (the DC-4 was the first airliner to introduce a circular section, constant diameter fuselage which made stretching the basic aircraft relatively simple). <p> ',' United States of America ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Hindustan Advanced Light Helicopter ',51708362.0,'The Advanced Light Helicopter is the first indigenous helicopter of the growing Indian aircraft industry, and will be built in different versions for the Indian Army, Navy, Coast Guard and Air Force, as well as for civil customers. <p>In the early 1980s India approached Germany''s MBB (now Eurocopter Deutschland) to help it design and build a midsize multirole helicopter for both military and civil use. Subsequently a cooperation agreement was signed in July 1984, covering design support, development and production. Design work began in November that year, while the first flight of the first of four prototypes was on August 20 1992. <p>ALH design features include a hingeless four blade main rotor with swept back tips and composite construction main and tail rotor blades. The first three prototypes are powered by TM 333s but a final engine choice for production aircraft has yet to be made. Civil aircraft will feature LHTEC CTS 800s <p>The Advanced Light Helicopter will be built in two distinct military versions, one for the Indian air force and army, and one for the navy. Army and air force versions will feature skids, and will be used for a number of missions including ground attack, troop transport and SAR. Naval versions will be fitted with retractable tricycle undercarriage and a folding tail boom. The civil version will feature tricycle landing gear and will be certificated to western standards. The first civil ALH was due to fly in 1998. Series production was launched in 1997. <p>The Indian Government plans to buy around 300 ALHs for its military, to replace a variety of helicopters including Chetaks and Cheetahs. The first firm order, for 100, was placed in late 1996. <p> ',' India ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Dornier 328 ',95327715.0,'img/1066451-v40-6.jpg',' The 30 seat Dornier 328 is a modern regional turboprop airliner that offers high cruising speeds and advanced systems.

Development of the 328 traces back to Dornier''s mid 1980s market research that indicated there existed a substantial market for regional airliners in the 30 seat class through to 2005. Firm 328 development work began in December 1988, culminating in the first development aircraft''s first flight on December 6 1991.

The 328 was awarded certification in October 1993. First customer deliveries also occurred in October 1993.

The 328 design incorporates an all new fuselage section for three abreast seating (offering more width per passenger than the 727/737) combined with the same basic supercritical wing of the earlier Dornier 228. Clean aerodynamics give the 328 excellent high speed cruise and climb performance. Composite materials are used in a number of areas (particularly the tail) to reduce weight and the blades on the Hartzell props are composite. The flightdeck features a five screen Honeywell Primus 2000 EFIS avionics system, while with heads-up displays the 328 can be qualified for Cat IIIa landings.

Industrial partners on the 328 include Daewoo Heavy Industries (fuselage), Aermacchi (nose), Westland (nacelles) and Israel Aircraft Industries (wing), accounting for 40% of the aircraft''s construction.

Variants of the 328 are the initial production standard 328-100, the standard 328-110 with a larger dorsal fin, heavier weights and greater range, the 328-120 with PW119C engines and improved short field performance and the 328-130 with progressive rudder authority reduction with increasing airspeed.

At various times Dornier studied 50 seat stretches of the 328, but all were abandoned. Dornier also studied building a 328 demonstrator powered by hydrogen. The liquid hydrogen fuel would have been stored in two external tanks under the wings and outboard of the engines.

The last 328 was delivered to Air Alps Aviation in Austria in October 1999. The 328JET regional jet development is described separately.

Fairchild Aerospace acquired 80% of Dornier in early June 1996 to form Fairchild Dornier GmbH, but production of the 328 had stopped already before the Fairchild Dornier name became effective August 8, 2000.


 ',' Germany ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('De Havilland DH.82 Tiger Moth ',28349563.0,'img/0067689-v40-6.jpg',' One of the most famous biplanes in the world, the much loved Tiger Moth was produced in large numbers for WW2 service as a basic pilot trainer, and today is a highly sought after private aircraft. <p>The DH.82 Tiger Moth is a development of de Havilland''s successful and famous Moth line of biplanes. Based on the DH.60T Moth Trainer, the Tiger Moth first flew on October 26 1931. Like the earlier Moth and Gipsy Moth the new aircraft was a two place biplane and featured a Gipsy Major engine and wooden and metal construction. Difficulty bailing out in an emergency was a problem with the earlier aircraft, and this was addressed through repositioning the struts forward of the front cockpit. To counter centre of gravity problems that would have resulted, the wings were given a modest sweepback angle. <p>The DH.82 attracted the interest of Britain''s Royal Air Force, and the first of what would ultimately be several thousand Tiger Moths entered service with the RAF in 1932. Initial production DH.82s were powered by 80kW (120hp) engines, while the DH.82A introduced in 1937 featured a 97kW (130hp) engine, and was the most produced version. Most prewar production was against military orders, although some civil machines were built. <p>As Britain''s standard basic pilot training aircraft, production of the Tiger Moth increased greatly during WW2, and some 4000 were built in the UK. During the war large numbers were also built in Canada (as the DH.82C with a Gipsy Major IC or 120kW/160hp Pirate D.4 engine), Australia and New Zealand. <p>Postwar, surplus military Tiger Moths proved extremely popular with private owners. Many examples were converted for agricultural work, particularly in Australia and New Zealand, while small numbers of the four seat Jackaroo conversion were built from 1957. <p>Today the Tiger Moth remains very popular, and in some countries the Tiger Moth populations are in fact growing as retired machines are restored and returned to the air. <p> ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('De Havilland DH.114 Heron ',38752064.0,'img/2224786-v40-6.jpg',' The DH.114 Heron is a stretched, four engined development of de Havilland''s successful DH.104 Dove.

Only a few years later in development than the Dove on which it was based, design work on the Heron began in the late 1940s, resulting in the prototype''s first flight on May 10 1950 (the Dove first flew in 1945). In designing the Heron, de Havilland made as much use of Dove componentry as possible, and so both types feature the distinctive slightly raised cockpit and separate main cabin and metal construction. Initial Heron production aircraft also featured fixed undercarriage (unlike the retractable gear Dove). Major differences include the four 185kW (250hp) Gipsy Queen engines (as opposed to two 255 to 300kW/340 to 400hp Gipsy Queen 70s), greater span wings, a longer and taller fuselage and greater seating capacity. The first Series 1 production Herons were delivered to New Zealand National Airways in 1952.

Also in 1952 the first Series 2 Heron first flew on December 14. The 2''s main improvement over the 1 was retractable undercarriage, which for a weight penalty of 75kg (165lb) increased cruising speed by 32km/h (17kt), while other standard and optional improvements were minor in nature. The Heron 2A was certificated for use in the USA, and an equivalent 2B executive version was also offered. The 2C and equivalent executive 2D have greater weights.

The Heron has been the subject of numerous conversion programs. In the USA Riley converted 20 to be powered by Lycoming IO540s (eight more were converted in Australia), while Prinair converted a further 29 to Lycoming power.

The most ambitious Heron conversions were performed by Saunders, whose ST27 conversions feature two Pratt & Whitney Canada PT6 turboprops and a stretched fuselage. In addition, Tawron converted six Series 1 Herons with Continental engines.

 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('De Havilland Canada DHC2 Beaver ',38422263.0,'img/0124423-v40-6.jpg',' De Havilland Canada''s first purpose designed bush aircraft, the Beaver was that company''s most successful program sales wise (both military or civil), with almost 1700 built in a production run lasting two decades. <p>Beaver development work began in 1946 and the Ontario Department of Lands and Forests had considerable input into the final design and configuration of this rugged and versatile utility. A prototype flew on August 16 1947, with seating for five or six, although the production Beaver grew slightly to seat an extra two passengers by the time civil certification was awarded in March 1948. <p>The only major development of the Beaver (aside from a one off powered by a 410kW/550hp Alvis Leonides 502/4 radial engine) was the Turbo Beaver. First flown in December 1963 it featured a Pratt & Whitney PT6A6 turboprop, which offered lower empty and higher takeoff weights, and even better STOL performance. The Turbo Beaver''s cabin was also longer, allowing maximum accommodation for 11, including the pilot. Externally, the Turbo Beaver had a much longer and reprofiled nose, and squared off vertical tail. DHC also offered conversion kits enabling piston powered Beavers to be upgraded to Turbo standard. Other conversions have been performed. <p> ',' Canada ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('De Havilland DH.104 Dove ',33033258.0,'img/0009494-v40-6.jpg',' The Dove was Britain''s first successful postwar civil aircraft, and one of the few successful Brabazon Committee projects.

The Brabazon Committee was established during WW2 to define requirements for British postwar civil aircraft. While the government established committee was responsible for a number of failures such as the Bristol Brabazon, its studies also resulted in the highly successful Vickers Viscount (described elsewhere) and the de Havilland Dove.

The Dove was developed in response to a requirement for a small feederliner for UK and Commonwealth domestic services. The resulting aircraft featured new versions of the Gipsy Queen engine, a raised flightdeck and separate passenger cabin and all metal construction. The first DH.104 Dove flew for the first time on September 25 1945.

Steady sales success as a regional airliner and corporate transport (particularly in the US) was boosted by significant military orders (RAF versions were known as the Devon, Royal Navy aircraft the Sea Devon).

The Dove remained in production until the mid 1960s (by which time it was a Hawker Siddeley product), and a number of variants were built. These were the initial Series 1, the executive interior Series 2, the military Series 4, the Series 5 with greater range and more powerful engines, the Series 6 (and 6A for the US) executive version of the Series 5, Series 6BA with more powerful engines, Series 7 (Series 7A for the US) with more powerful engines and raised Heron style flightdeck, and Series 8 (8A or Custom 800 in the US) with five seat interior.

In the USA Riley Aeronautics offered conversions of the Dove with two 300kW (400hp) Lycoming IO720 flat eight piston engines. The conversion is known as the Riley 400, and aside from the engines, customers could fit a swept back tail, a new instrument panel and a steel spar crapped wing. The first Riley 400 flew in 1963.

 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Dornier 228 ',95327705.0,'img/0151142-v40-6.jpg',' In terms of civil sales the 228 series was Dornier''s most successful postwar design.

The Dornier 228 incorporates the fuselage cross section of the earlier Do 28 and 128 combined with an all new high technology supercritical wing and TPE331 turboprops. Two fuselage length versions, the 100 and 200, were developed concurrently, the 100 offering better range, the 200 more payload. The 100 was the first to fly taking to the skies for the first time on March 28 1981, the first 200 followed on May 9 that year. The first 228 entered service in August 1982.

Composites were used in a number of secondary structure areas on the 228 including upper wing skins, nose and tail. At one stage Dornier also planned to offer the Pratt & Whitney Canada PT6A as an optional powerplant, but this never eventuated.

228 developments include the 228-101 with reinforced structure and landing gear for higher weights, the corresponding 228-201 version of the 200, the 228-202 version built under licence production in India with HAL to meet that country''s Light Transport Aircraft requirement, and the 228-212.

The 212 is the last Dornier (now Fairchild Aerospace) production aircraft, its improvements include higher operating weights, structural strengthening and a lower empty weight, improvements to enhance STOL performance and modern avionics. The last of 238 Dornier built 228s was completed in 1999.  HAL licence production continues.

 ',' Germany ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Diamond DA-40 Diamond Star ',11771115.0,'img/0559066-v40-6.jpg',' The DA-40 Diamond Star is a composite construction four place light single now offered in avgas and jet fuel burning forms.

Diamond Aircraft was formed in 1981 as Hoffmann Flugzeugbau, and following bankruptcy reformed as Hoffmann Aircraft in 1984. The company was renamed HOAC Austria Flugzeugwerk in 1990 and Diamond Aircraft in 1996. The DA-40 is its first FAR/JAR Pt23 certificated aircraft, its earlier products include the H-36 Dimona, HK-36 Super Dimona (Katana Xtreme) and the Rotax 912 and Continental IO-240 powered DV-20/DA-20 Katana two seater. The DA-20 is built in Canada.

Diamond formally launched the DA-40 on April 23 1997 at the Aero 97 airshow in Friedrichshafen, Germany. The Rotax 914 powered proof of concept DA-40V-1 first flew on November 5 1997, the second prototype DA-40V-2 with a IO-240 followed shortly after. The third prototype, with a Textron Lycoming IO-360, the production powerplant, flew in 1998. Four further prototypes followed, with JAA JAR 23 certification awarded on October 25 2000. FAA and JAR certification was awarded in April 2001.

The DA-40-180 is based loosely on the DA-20 but features a larger fuselage with seating for four and a slightly longer span wing. The airframe is made from glassfibre reinforced plastics with carbonfibre reinforcement in some areas. Power is from a Lycoming IO-360 with Lasar electronic fuel injection. Standard fuel capacity is 155 litres, optional fuel capacity is 200 litres.

The turbo diesel Thielert Centurion 1.7 powered DA-40D TDI flew on November 28 2001. Despite "only" producing 100kW (135hp) the Centurion 1.7 gives the DA-40D TDI cruise performance comparable to the DA-40-180 and even better range, while burning just 17 litres of fuel (either jet fuel or diesel) an hour. Deliveries of this version started in early 2003.



     ',' Austria ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('De Havilland Canada DHC-8-400 Dash 8 ',93947466.0,'img/0080941-v40-6.jpg',' Bombardier''s 70 seat de Havilland Dash 8 Series Q400 (or Q400 for short) is the latest and longest member of the successful Dash 8 family, but with new engines, avionics and systems, a modified wing and stretched fuselage is essentially an all new aeroplane.

De Havilland was already working on a further stretch of the Dash 8 when Bombardier acquired the company from Boeing in 1992, although the program was not formally launched until June 1995. Rolled out on November 21 1997, the Q400 made its first flight on January 31 1998. Five Q400s were used in the 1900 flying hour flight test program, culminating in Canadian certification being awarded on June 14, 1999, and US certification on February 8, 2000.  The first delivery, to launch customer SAS Commuter, was on January 20, 2000, about 10 months later than originally planned.

The Q400 is pitched at the short haul regional airliner market for stage lengths of 550km (300nm) or less. Despite the recent proliferation of regional jets, Bombardier notes that regional jets have created their own market niche and are not replacing turboprops, which remain more economical over shorter stage lengths. Bombardier says the Q400''s breakeven load factor for a 360km (195nm) stage length will be just 29 passengers.

The Q400 features a new fuselage stretched 6.83m (22ft 5in) compared with the Q300 mated with the familiar Dash 8 nose section and vertical tail, while the horizontal tail is new. The fuselage''s cross section and structure is based on the earlier Dash 8''s but with two entry doors at the forward and aft ends of the fuselage on the left side, with emergency exit doors opposite them on the right side.

The Q400''s inner wing section and wing fuselage wing join are new, while the outer wing has been strengthened. Power is from two FADEC equipped 3410kW (4573shp) Pratt & Whitney Canada PW150As.

The Q400 is fitted with Bombardier''s NVS active noise and vibration system which reduces cabin noise to levels comparable to the CRJ jet airliner. This is achieved through the use of computer controlled active tuned vibration absorbers (ATVAs) mounted on the airframe.

The flightdeck features five large Sextant LCD colour displays which present information to the pilots in a similar format to earlier Dash 8s, allowing a common type rating.

 ',' Canada ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Grumman G-1159 Gulfstream II/III ',48045078.0,'img/0254289-v40-6.jpg',' Collectively the most successful members of the Gulfstream corporate aircraft family, the Gulfstream II and Gulfstream III are Spey powered developments of the original turboprop powered Gulfstream I.

The Rolls-Royce Dart turboprop powered Grumman Gulfstream I proved to be quite successful as a large long range corporate transport, while the availability of an faster and more powerful turbojet powered model, the Rolls-Royce Spey meant that a jet powered successor was a logical development. Grumman launched such an aircraft, named the Gulfstream II or G-II, in May 1965.

While based on the original Gulfstream I - the G-II shares the same forward fuselage and cross section - there are more differences than similarities. The most obvious difference is the two rear mounted Spey axial flow turbojet engines, others include a new swept wing and tail. A similar size fuselage to the G-I seats 10 in a typical executive configuration.

No prototype G-II was built, instead the first to fly was a production standard aircraft, which first flew on October 2 1966. Certification and first production deliveries occurred in October and December 1967 respectively.

The improved Gulfstream III followed Gulfstream American''s purchase of Grumman''s GA lines in 1978. The Gulfstream III first flew on December 2 1979. Changes compared with the G-II include a revised wing of greater span and area with drag reducing winglets, more fuel tankage and thus range, reprofiled nose and a 97cm (3ft 2in) fuselage stretch. Gulfstream IIBs are G-IIs retrofitted with the G-III''s wing.

Production deliveries of G-IIIs began in late 1980 and continued until 1986 when production ceased in favor of the Gulfstream IV, a somewhat larger model with two new, quieter, more powerful and fuel efficient Rolls-Royce Tay turbofans.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('De Havilland Canada DHC-8-300 Dash 8 ',92192631.0,'img/0111550-v40-6.jpg',' With the success of the Dash 8-100 series, a stretched version with greater capacity was a logical development.

De Havilland Canada (now part of Bombardier) launched full scale development of a 50 seat stretched version of its Dash 8 regional airliner during 1986, approximately two years after the standard fuselage length aircraft had entered service. The first series 300 aircraft was in fact the prototype Dash 8 converted to the new length, and it flew for the first time in its new configuration on May 15 1987. Flight testing culminated in the awarding of Canadian certification in February 1989, with the first delivery to Time Air following late that same month. US certification was awarded in June 1989.

The stretch comprises fuselage plugs forward and aft of the wing, increasing length by 3.43m (11ft 3in). In addition, the wings are greater in span. The fuselage stretch increases typical seating capacity to 50 (at 81cm/32in pitch), or for up to 56 (at 74cm/29in pitch). Other changes compared with the Dash 8-100 were minor, but included a larger, repositioned galley, larger toilet, additional wardrobe, dual air conditioning packs, a new galley service door and optional APU.

The Dash 8-300 has been offered in a number of variants. The standard 300 was followed in 1990 by the 300A which introduced optional higher gross weights, interior improvements (as on the Dash 8-100A), and standard PW123A engines (with PW123Bs optional). The 300B was introduced in 1992 and has 1865kW (2500shp) PW123Bs as standard, as is the optional high gross weight of the 300A. The 300E has 1775kW (2380shp) PW123Es rated to 40 degrees, thus improving hot and high performance.

Like the Dash 8Q-200, all Dash 8-300s built since the second quarter of 1996 have been fitted with a computer controlled noise and vibration suppression system (or NVS) and so from then all models were designated Dash 8Q-300s. In 1998 the aircraft was again renamed, this time to Dash 8-Q300 when a new interior was also introduced. ',' Canada ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('De Havilland Canada DHC-6 Twin Otter ',50693524.0,'img/0125117-v40-6.jpg',' Still Canada''s most successful commercial aircraft program with more than 800 built, the Twin Otter remains popular for its rugged construction and useful STOL performance.

Development of the Twin Otter dates back to January 1964 when De Havilland Canada started design work on a new STOL twin turboprop commuter airliner (seating between 13 and 18) and utility transport. The new aircraft was designated the DHC-6 and prototype construction began in November that year, resulting in the type''s first flight on May 20 1965. After receiving certification in mid 1966, the first Twin Otter entered service with long time De Havilland Canada supporter the Ontario Department of Lands in Canada.

The first production aircraft were Series 100s. Design features included double slotted trailing edge flaps and ailerons that can act in unison to boost STOL performance. Compared with the later Series 200s and 300s, the 100s are distinguishable by their shorter, blunter noses.

The main addition to the Series 200, which was introduced in April 1968, was the extended nose, which, together with a reconfigured storage compartment in the rear cabin, greatly increased baggage stowage area.

The Series 300 was introduced from the 231st production aircraft in 1969. It too featured the lengthened nose, but also introduced more powerful engines, thus allowing a 450kg (1000lb) increase in takeoff weight and a 20 seat interior. Production ceased in late 1988. In addition, six 300S enhanced STOL performance DHC-6-300s were built in the mid 1970s.

All models have been fitted with skis and floats.

 ',' Canada ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('De Havilland Canada DHC-8-100/200 Dash 8 ',18144962.0,'img/0100963-v40-6.jpg',' Bombardier''s de Havilland Dash 8 has proven to be a popular player in the regional turboprop airliner market.

De Havilland Canada began development of the Dash 8 in the late 1970s in response to what it saw as a considerable market demand for a new generation 30 to 40 seat commuter airliner. The first flight of the first of two preproduction aircraft was on June 20 1983, while Canadian certification was awarded on September 28 1984. The first customer delivery was to norOntair of Canada on October 23 1984.

Like the Dash 7, the Dash 8 features a high mounted wing and Ttail, and has an advanced flight control system and large full length trailing edge flaps. Power meanwhile is supplied by two Pratt & Whitney Canada PW120 series (originally designated PT7A) turboprops.

Initial Dash 8 production was of the Series 100, which was followed by the Series 100A in 1990. The 100A introduced a revised interior with extra headroom and PW120A turboprops. The Series 100B was offered from 1992 with more powerful PW121s for better climb and airfield performance.

Production since switched to the improved performance Dash 8-200. Announced in 1992 and delivered from April 1995 the -200 features more powerful PW123C engines which give a 56km/h (30kt) increase in cruising speed, as well as greater commonality with the stretched Dash 8300. The 200B derivative has PW123Bs for better hot and high performance.

From the second quarter of 1996 all Dash 8s delivered have been fitted with a computer controlled noise and vibration suppression system (or NVS). To reflect this the designation was changed to Dash 8Q (Q for `quiet''). In 1998 that was changed again to Dash 8 Q200 when a new interior was introduced.

 ',' Canada ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('De Havilland Canada DHC-1 Chipmunk ',69377836.0,'img/1236049-v40-6.jpg',' Affectionately known as the Chippie, De Havilland Canada''s Chipmunk was designed in response to a growing need to replace the Royal Air Force''s ageing Tiger Moth two seat basic trainer biplane (described separately).

With a full design workload (courtesy of the revolutionary Comet jet airliner project among others) De Havilland decided to hand design responsibility for the new trainer to its Canadian subsidiary, De Havilland Canada. Design leadership for DHC''s first aircraft was the responsibility of W J Jakimiuk who had emigrated to Canada from Poland in 1940 and was previously responsible for the design of the PZL P-24 and PZL P-50 Jastrzab fighters and the DH-95 Flamingo airliner.

His new aircraft was designated the DHC-1 Chipmunk and flew for the first time on May 22 1946. Features of the design included a De Havilland Gipsy Major engine and all metal construction (but with fabric covered control surfaces). First deliveries took place the following year. Main Chipmunk models included the Canadian built DHC-1A-1 and DHC-1B-2 (Mk1 and Mk2 in the RCAF), and many featured clear view blown canopies, while main British production models included the initial T10 for the RAF, the Mk20 for foreign military users and the civilian Mk21. OGMA built 60 Mk20 under licence in Portugal.

Civilianised versions of RAF aircraft became available in large numbers from the late 1950s, and the T10 became the Mk22 in civil service, while the Mk22A was a Mk22 with greater fuel capacity. Farm Aviation Services in the UK heavily modified Chipmunks with a hopper tank in place of the forward cockpit for spraying duties, these aircraft were designated Mk23s. Three similar conversions were performed in Australia by Sasin/Aerostructures as the SA-29 Spraymaster. The Masefield Chipmunk was a conversion available for ex RAF T10s with a blown canopy, wheel pants, luggage space in the wing and increased fuel capacity.

In 1999 a kit version became available for the homebuilt market, developed by Gilles Leger in Montreal, Canada. Leger’s version is called the Super Chipmunk. It has a new more spacious fuselage while using original Chipmunk wings and tail unit, and is powered by a 156kW (210hp) Continental IO-360 engine.

Today the Chipmunk remains a very popular sport and private aircraft, while a small number are still used for pilot training and tailwheel endorsements. Some have also been extensively modified with the installation of Lycoming or Continental engines, e.g. the two Super Chipmunks of famous airshow performer Art Scholl.

 ',' Canada ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('De Havilland Canada DHC-3 Otter ',34962143.0,'img/1684643-v40-6.jpg',' Another in de Havilland Canada''s successful line of rugged and useful STOL utility transports, the Otter was conceived to be capable of performing the same roles as the earlier and highly successful Beaver, but was bigger.

Using the same overall configuration of the earlier and highly successful DHC-2 Beaver, the Otter is much larger overall. The Otter began life as the King Beaver, but compared to the Beaver is longer, has greater span wings and is much heavier. Seating in the main cabin is for 10 or 11, whereas the Beaver could seat six. Power is supplied by a 450kW (600hp) Pratt & Whitney R1340 Wasp radial. Like the Beaver the Otter can be fitted with skis and floats. The amphibious floatplane Otter features a unique four unit retractable undercarriage, with the wheels retracting into the floats.

De Havilland Canada began design work on the DHC-3 Otter in January 1951, the company''s design efforts culminating in the type''s first flight on December 12 1951. Canadian certification was awarded in November 1952.

De Havilland Canada demonstrated the Otter to the US Army, and subsequently that service went on to become the largest DHC-3 operator (as the U-1). Other military users included Australia, Canada and India.

Small numbers of Otters were converted to turbine power by Cox Air Services of Alberta, Canada. Changes included a Pratt & Whitney Canada PT6A turboprop, a lower empty weight of 1692kg (3703lb) and a higher maximum speed of 267km/h (144kt). It was called the Cox Turbo Single Otter. A number of other after market PT6 conversions have also been offered.

The Otter found a significant niche as a bush aircraft and today it remains highly sought after.

 ',' Canada ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('De Havilland Canada DHC-4 Caribou ',66241917.0,'img/0385612-v40-6.jpg',' De Havilland Canada''s fourth design was a big step up in size compared with its earlier products, and was the first powered by two engines, but the Caribou was similar in that it is a rugged STOL utility. The Caribou was primarily a military tactical transport that in commercial service found itself a small niche.

De Havilland Canada designed the DHC-4 in response to a US Army requirement for a tactical airlifter to supply the battlefront with troops and supplies and evacuate casualties on the return journey. With assistance from Canada''s Department of Defence Production, DHC built a prototype demonstrator that flew for the first time on July 30 1958.

Impressed with the DHC4''s STOL capabilities and potential, the US Army ordered five for evaluation as YAC-1s and went on to become the largest Caribou operator, taking delivery of 159. The AC-1 designation was changed in 1962 to CV-2, and then C-7 when the US Army''s CV-2s were transferred to the US Air Force in 1967. US and Australian Caribou saw extensive service during the Vietnam conflict. In addition some US Caribou were captured by North Vietnamese forces and remained in service with that country through to the late 1970s. Other notable military operators included Canada, Malaysia, India and Spain.

The majority of Caribou production was for military operators, but the type''s ruggedness and excellent STOL capabilities also appealed to a select group of commercial users. US certification was awarded on December 23 1960. AnsettMAL, which operated a single example in the New Guinea highlands, and AMOCO Ecuador were early customers, as was Air America (a CIA front in South East Asia during the Vietnam War era for covert operations). Other Caribou entered commercial service after being retired from their military users.

Today only a handful are in civil use as the Caribou''s thirsty twin row radial engines make commercial operations uneconomic where its STOL performance is not a factor.

Interest in the Caribou could be revived however, as Pen Turbo from Cape May, NJ has made a conversion with Pratt & Whitney PT6A-67T turbine engines with 5-bladed Hartzell propellers, named the DHC-4A Turbo Caribou, and is now offering this modification on the market under a STC (Supplemental Type Certificate). Apart from the engines, several upgrade possibilities are available.

 ',' Canada ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Dassault Mystère/Falcon 20 & 200 ',60562920.0,'img/0071813-v40-6.jpg',' The Mystère or Falcon 20 and 200 family remains Dassault''s most successful business jet program thus far, with more than 500 built. <p>Development of the original Mystère 20 traces back to a joint collaboration between Sud Aviation (which later merged into Aerospatiale) and Dassault in the late 1950s. Prototype construction began in January 1962, leading to a first flight on May 4 1963. This first prototype shared the production aircraft''s overall configuration, but differed in the powerplant. The prototype was initially powered by 14.7kN (3300lb) Pratt & Whitney JT12A8 turbojets, whereas production Mystère 20s (or Falcon 20s outside France) were powered with General Electric CF700s. The first GE powered 20 flew on New Year''s Day 1965. Throughout the type''s production life Aerospatiale remained responsible for building the tail and rear fuselage. <p>The Falcon 200 is a re-engined development of the 20 which Dassault first publicly announced at the 1979 Paris Airshow. A converted Falcon 20 served as the prototype, and first flew with the new Garrett ATF 3-6A-4C engines on April 30 1980. French DGAC certification was awarded in June 1981. <p>Apart from the Garrett engines, the Falcon 200 (initially the 20H) introduced greater fuel tankage and much longer range, redesigned wing root fairings and some systems and equipment changes. The 200 remained in production until 1988. <p>The Guardian is a maritime surveillance variant of the Falcon 200 sold the French navy (as the Gardian) and the US Coast Guard (HU-2J). <p>AlliedSignal offers a Falcon 20 re-engine program with its TFE731 turbofan. More than 100 Falcon 20s have now been re-engined with 21.1kN (4750lb) TFE731-5ARs or -5BRs. <p> ',' France ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('De Havilland Canada Dash 7 ',66286995.0,'img/0053924-v40-6.jpg',' Despite being out of production for some years now, the four engine de Havilland Canada Dash 7 remains unrivalled because of its impressive STOL and low noise capabilities.

The Dash 7 (or DHC7) was designed as a STOL (short takeoff and landing) 50 seat regional airliner capable of operating from strips as short as 915m (3000ft) in length. The main design features to achieve such a capability were an advanced wing and four Pratt & Whitney PT6A turboprops. Double slotted trailing edge flaps run the entire span of the high mounted wing, dramatically increasing the lifting surface available for takeoff. Extra lift is also generated by the airflow over the wing from the relatively slow turning propellers. The wings also feature two pairs of spoilers each - the inboard pair also operate as lift dumpers, the outboard pair can act differentially in conjunction with the ailerons to boost roll control.

Financial backing from the Canadian Government allowed the launch of the DHC7 program in the early 1970s, resulting in the maiden flight of the first of two development aircraft on March 27 1975. The first production Dash 7 flew on March 3 1977, the type was certificated on May 2 1977 and it entered service with Rocky Mountain Airways on February 3 1978.

The standard passenger carrying Dash 7 is the Series 100, while the type was also offered in pure freighter form as the Series 101. The only major development of the Dash 7 was the Series 150, which featured a higher max takeoff weight and greater fuel capacity, boosting range. The Series 151 was the equivalent freighter. Production of the Dash 7 ended in 1988, following Boeing''s takeover of de Havilland Canada.

 ',' Canada ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Dassault Mystère/Falcon 10 & 100 ',59562910.0,'img/0058194-v40-6.jpg',' The baby of Dassault''s corporate jet lineup, the Falcon 10 and Falcon 100 series (Mystère 10 and Mystère 100 in France) sold in good numbers during a production run that lasted almost two decades. <p>In concept a scaled down Falcon/Mystère 20, the Falcon 10/100 was an all new design except for similar wing high lift devices. Conceived in the late 1960s, the Falcon 10 was the second member of the Dassault Falcon family to be developed. Dassault originally intended the Falcon 10 be powered by two General Electric CJ610 turbojets, and a CJ610 powered prototype first flew on December 1 1970. <p>Flight testing was delayed until May 1971 while changes were made to the wing design, including increasing the wing sweepback angle. The second prototype was the first to be powered by Garrett TFE731 turbofans, and it completed its first flight on October 15 1971. Flight testing was completed with the aid of a third prototype, and French and US certification was awarded in September 1973. Deliveries of production aircraft began that November. <p>While almost all Falcon 10 production was for civil customers, the French navy ordered seven, designated the Mystère 10 MER, as multi purpose pilot trainers. Missions include simulation of targets for Super Etendard pilots and instrument training. <p>The improved Falcon 100 replaced the Falcon 10 in production in the mid 1980s. Certificated in December 1986, changes include an optional early EFIS glass cockpit, a higher maximum takeoff weight, a fourth cabin window on the right side and a larger unpressurised rear baggage compartment. <p>Production of the Falcon 100 ceased in 1990 with the last delivered that September. <p> ',' France ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Dassault Falcon 50 ',11558546.0,'img/0110474-v40-6.jpg',' The trijet Falcon 50 is a very substantial long range upgrade based on the earlier twinjet Mystère/Falcon 20 and 200 family. <p>The Dassault Falcon 50 was developed for long range trans Atlantic and transcontinental flight sectors, using the Falcon 20 as the design basis. However, to meet the 6440km (3475nm) range requirement significant changes mean that the Falcon 50 is for all intents and purposes an all new aircraft. <p>Key new features include three 16.6kN (3700lb) Garrett TFE731 turbofans, in place of the Falcon 20''s two General Electric CF700s, mounted on a new area ruled tail section, plus a new supercritical wing of greater area than that on the 20 and 200. Falcon 20 components retained include the nose and fuselage cross section. <p>The first flight of the prototype Falcon 50 occurred in November 1976, although it wasn''t until March 7 1979 that FAA certification was granted. In the meantime the design had been changed to incorporate the supercritical wing, although the original wing''s basic planform was retained. A second prototype first flew on February 18 1978, the first preproduction aircraft following on June 13 1978. First customer deliveries began in July 1979. <p>In April 1995 Dassault announced the long range Falcon 50EX with more fuel efficient TFE73140 turbofans, 740km (400nm) greater range (at Mach 0.80) than the base Falcon 50 and a new EFIS flightdeck based on the Falcon 2000''s with Collins Pro Line 4 avionics. The 50EX also features as standard equipment items offered as options only on the standard Falcon 50. <p>The Falcon 50EX''s maiden flight was on April 10 1996, with French and US certification in November and December 1996 respectively. First delivery (to Volkswagen) was in the following January. <p>The Surmar is a maritime patrol version of the 50 ordered by the French navy (fitted with a FLIR and search radar). <p> ',' France ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Dassault Falcon 900 ',15188354.0,'img/0290565-v40-6.jpg',' The Falcon 900 intercontinental range trijet is a substantially revised development of the Falcon 50.

Dassault announced it was developing a new intercontinental range large size business jet based on the Falcon 50 on May 27 1983 at the Paris Airshow. The prototype, "Spirit of Lafayette", flew for the first time on September 21 1984. A second prototype flew on August 30 1985, and this aircraft demonstrated the type''s long range potential by flying nonstop from Paris to Little Rock, Arkansas in the USA for a demonstration tour. French certification was awarded on March 14 1986, FAA certification followed on March 21, and first customer deliveries occurred in December that year.

While of similar overall configuration to the Falcon 50, the Falcon 900 intoduced an all new wider and longer fuselage which can seat three passengers abreast. The main commonality with the Falcon 50 is the wing, which despite being designed for a considerably lighter aircraft, was adapted almost directly unchanged. In designing the Falcon 900 Dassault made use of computer aided modelling, while the aircraft''s structure incorporates a degree of composite materials.

Two Falcon 900s entered service with the Japanese Maritime Safety Agency for the long-range maritime surveillance role as the Falcon 900MSA, equipped with search radar, special communications equipment, observation windows, a control station, and a drop hatch.

From 1991 the standard production model was the Falcon 900B, which differs from the earlier 900 in having more powerful engines, increased range, the ability to operate from unprepared strips and Category II visibility approach clearance. Earlier production 900s can be retrofitted to 900B standard.

The Falcon 900EX is a longer range development launched in October 1994. It features TFE731-60 engines, a Honeywell Primus 2000 EFIS avionics suite, optional Flight Dynamics head-up displays, increased fuel capacity and greater range. Its first flight was on June 1 1995 and first delivery was in May 1996.

The latest Falcon 900 model is the 900C. Revealed in 1998, the C is a development of the B but incorporates the advanced Honeywell Primus avionics of the 900EX, but without autothrottles. The 900C replaced the 900B in the Falcon product line with first deliveries in early 2000.

From 2003 the 900EX will introduce Dassault''s EASy avionics operating system with four colour displays, cursor control devices and multifunction keyboards.

 ',' France ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Dassault Falcon 2000 ',52023691.0,'img/0118762-v40-6.jpg',' The Falcon 2000 is the latest member of the Falcon business jet line, and is a transcontinental range, slightly smaller development of the Falcon 900 trijet <p>The Falcon 2000 shares the 900''s wing and forward fuselage, but there are a number of design changes. From the start the Falcon 2000 was designed with a range of 5560km (3000nm) in mind, which is less than the transcontinental 900''s range. This design range removed the need for the redundancy of three engines for long range overwater flights, allowing the two new CFE738 engines to be fitted, which offer considerable maintenance and operating economics benefits. The CFE738 engine was developed specifically for the Falcon 2000 by a partnership of General Electric and AlliedSignal, known as CFE. Meanwhile, the 2000''s fuselage is 1.98m (6ft 6in) shorter than the 900''s and so houses less fuel, passengers and baggage. <p>Another noticeable design change between the 900 and 2000 is the area ruled rear fuselage. Dassault engineers found that the three engine layout of the 900 to be aerodynamically efficient, whereas the twin engine design of the 2000 originally would have been comparatively draggy. To combat this and reduce drag to desired levels Dassault designed an area ruled (or Coke bottle) rear fuselage, using its Catia three dimensional computer aided design program. <p>Changes to the wing include a modified leading edge and the inboard slats have been removed, while the cockpit features a Collins four screen EFIS avionics system with optional Flight Dynamics head-up displays (allowing hand flown approaches in Cat II and Cat IIIa conditions). <p>Dassault has a number of industry partners in the Falcon 2000 program, foremost of these being Alenia, which is a 25% risk sharing partner. Alenia in turn has subcontracted some work to Dee Howard and Piaggio. <p>Dassault announced it was developing the Falcon 2000, then known as the Falcon X, in June 1989. First flight occurred on March 4 1993 and certification was awarded in November 1994. The first customer delivery occurred in March 1995. <p> ',' France ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Curtiss C46 Commando ',85254538.0,'img/0142023-v40-6.jpg',' The Curtiss Commando came into widespread civilian service as both an airliner and a freighter after a large number were built as transports for the US military during World War 2, although the original Curtiss design was intended as an airliner. <p>Originally intended as a competitor to the highly successful Douglas DC-3, which was the preeminent airliner of the time, the Curtiss CW20 was designed to operate on routes of up to 1000km (540nm), which at the time accounted for 90% of the US domestic airline system. The CW-20 featured two 1270kW (1700hp) Wright R2600 Twin Cyclone radial engines, twin vertical tails and a pressurised double lobe, or `double bubble'' fuselage. Accommodation would have been for 36 passengers plus four crew. <p>Later in timing than the DC-3, the CW20 first flew on March 26 1940. In July that year an impressed US Army Air Force ordered 20 unpressurised CW20s, which it named the C46 Commando. The first production aircraft was completed in May 1942, by which time the powerplant choice had been switched to P&W R2800s, and the first deliveries to the US Army occurred that July. <p>Initially the C46 was troubled with reliability problems in military service, but these were soon overcome and the Commando proved to be a useful transport with its relatively cavernous freight hold. <p>A proposed postwar commercial version was the CW20E, but it failed to attract customer interest and thus all Commandos to enter civilian service were ex military aircraft. Most were purchased by American operators for freight work. One postwar version though was the Riddles Airlines C46R which had more powerful engines and better performance. Thirty or so were converted. <p>In late 1998 five Commandos were believed to be operational in Alaska, four in Canada, and as many as seven in Bolivia. <p> ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Convair 240/340/440/540/580/600/640/5800 ',6633614.0,'img/0180136-v40-6.jpg',' The Convair 240, 340 and 440 was one of the closest designs to come near to being a Douglas DC-3 replacement as despite a glut of cheap DC-3s in the postwar years this family of airliners achieved considerable sales success.

Design of the original 110 was initiated in response to an American Airlines request for a DC-3 replacement. American found the 110 (which first flew on July 8 1946) to be too small and asked that the 110 be scaled up in size, and this resulted in the 240 ConvairLiner. The 240 was arguably the most advanced short haul airliner of its day, and first flew on March 16 1947 and entered service on June 1 1948.

The success of the 240 led to the 1.37m (4ft 6in) stretched 340, which first flew on October 5 1951, and the improved 440 Metropolitan which incorporated extra cabin sound-proofing, new rectangular exhaust outlets, tighter engine cowlings, and some other aerodynamic improvements and first flew on October 6 1955. Most of the 440s were also delivered with weather radar in an elongated nose, which had been an option on the 340.

The 240, 340 and 440 sold in large numbers, mainly to airlines in North America, and formed the backbone of many airlines'' short to medium haul fleets. Today the small number of piston Convairs that remain in service are mainly used as freighters.

Many of the Convairs were also built for the US Air Force as the C-131 and T-29 in many versions, and for the US Navy as the R4Y which were redesignated too as C-131 in 1962.

However, the original piston Convairs have been the subject of a number of turboprop modification programs, the line''s inherent strength and reliability making it a popular choice for conversions.

As early as 1950 the potential of turboprop powered 240s was recognised, leading to the first flight and development of the 240-21 Turboliner, while an Allison 501D powered YC-131C military conversion first flew on June 19 1954. One other early conversion occurred in 1954 when D Napier and Sons in Britain converted 340s with that company''s 2280kW (3060hp) Eland N.El.1 turboprops as the 540. Six such aircraft were converted for Allegheny Airlines in the USA, although these aircraft were later converted back to piston power. Canadair meanwhile built 10 new aircraft with Eland engines as the CL-66 for the Royal Canadian Air Force, where they were designated CC-109 Cosmopolitan.

The most popular Convair conversions were those done by PacAero in California for Allison, and this involved converting 340s and 440s to 580s with Allison 501D turboprops, plus modified tail control surfaces and a larger tail area. The first such conversion flew on January 19 1960, although it was not until June 1964 that a converted aircraft entered service.

Convair''s own conversion program involved Rolls Royce Darts, and the first of these flew on May 2 1965. Thus converted 240s became 600s, while 340s and 440s became 640s.

Super 580 Aircraft Company, a division of Flight Trails Inc., replaced the Allison 501-D13D engines by -D22Gs and incorporated some further improvements on two or three 580s which were redesignated Super 580.

Kelowna Flightcraft in Canada however has offered the most ambitious Convair conversion program, the 5800, having stretched the 580 by 4.34m (14ft 3in) and reverting to the 440''s original tail unit. Production conversions have a new freight door and digital avionics with EFIS.

Most of the remaining Convairs are now used as cargo transports.


 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Commander 114B ',27911544.0,'img/0090245-v40-6.jpg',' The Commander 114B is a new build, modernised development of the original Rockwell Commander 114. <p>The Rockwell Commander 114 was itself a more powerful development of the Commander 112 of 1970, one of only two new GA designs from Rockwell. Unfortunately for Rockwell, the 150kW (200hp) powered 112 was widely regarded as underpowered. To address concerns with the 112, Rockwell developed the 114 which incorporated a number of improvements plus most importantly a 195kW (260hp) six cylinder engine. <p>The 112 and 114 remained in production with Rockwell until 1979. In 1981 Rockwell''s General Aviation Division was sold to Gulfstream Aerospace. Gulfstream held the manufacturing rights for the Commander family but never built the 112 or 114, instead selling the rights to the newly formed Commander Aircraft Company in 1988. <p>Under the Commander Aircraft Company''s stewardship, the basic 114 design was improved and updated considerably. The main changes to the Commander 114B over the original 114 include a restyled engine cowling to reduce drag and other aerodynamic improvements, a quieter and more efficient three blade McCauley Black Mac propeller, and a new luxury leather and wool interior. <p>The revised Commander 114B was issued a new Type Certificate on May 4 1992 and production aircraft were delivered from later that year. <p>Apart from the 114B, Commander also offers the 114AT optimised for pilot training and the turbocharged 200kW (270hp) TIO540 powered 114TC, which entered service in 1995. A long range option for the 114B was announced in 1998. <p> ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Diamond DA-42 Twin Star ',45908763.0,'img/0566682-v40-6.jpg',' The Diamond DA-42 Twin Star is an all new four place carbonfibre construction light twin powered by jet fuel burning turbo diesel engines.

Austria''s Diamond Aircraft unveiled the DA-42 at the May 2002 Berlin Airshow. The new aircraft flew on December 9 2002, leading to European JAA certification in late 2003 and US FAA certification and first deliveries in mid 2004.

The Twin Star''s design objectives include high speed cruise at very low throttle settings and good low speed handling. It is loosely modelled on Diamond''s DA-40 Diamond Star single engine four place (see separate entry), and features an all composite airframe with a high aspect ratio wing with winglets.

The heart of the Twin Star is its two Thielert Centurion 1.7 (formerly TAE-125) turbo diesel four cylinder engines, which are designed to run on either diesel or Jet-A1/jet fuel. Germany based Thielert''s Centurion turbo diesel engine was certificated in early 2002 and is based on a Mercedes-Benz automotive design. Diamond expects the DA-42''s two engines will burn just 45 litres an hour while cruising at a very fast 333km/h (180kt). Standard fuel capacity is 200 litres, while optional long range tanks take maximum fuel capacity to 280 litres.

The engines drive slow turning three blade constant speed propellers, which combined with the engines'' low noise emissions and the DA-42''s fast climb rate will result in a low ground noise signature. The engines also feature electronic fuel management, automatic prop controls and auto feather.

The Twin Star will feature dual controls and an optional EFIS glass cockpit with three vertical format colour LCDs. The basic aircraft will be equipped with conventional IFR avionics.

Diamond Aircraft says the DA-42 will be suitable for flight training as well as private and business use.

Embry-Riddle Aeronautical University was the launch customer with an order for 10, and Lufthansa ordered 40 for its pilot training school. Another customer is PureFlight of the UK which ordered the Twin Star for its fractional ownership programme.

 ',' Austria ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cirrus SR-20/22 ',88332411.0,'img/0259233-v40-6.jpg',' Cirrus Design Corporation''s SR-20 is an all new, modern high performance four seat light aircraft.

Cirrus began life as a designer and manufacturer of kit aircraft. The company''s piston or turbine powered kit built VK-30 four seater in fact forms the basis of the SR-20 design, although the two aircraft are very different, particularly as the VK-30 features a pusher engine. The VK-30 first flew in February 1988 but kit production ceased in 1993 to allow Cirrus to relocate its manufacturing facilities to Duluth, Minnesota, and to concentrate on designing and manufacturing a family of fully certificated and factory built GA aircraft.

Details of the SR-20 were publicly revealed at the Oshkosh EAA Convention in July 1994. What was revealed is one of the most advanced four seaters in production or under serious development. The SR-20 features composite construction, advanced avionics including a large colour multifunction display, side mounted control yokes and a 150kW (200hp) Teledyne Continental IO-360 flat six piston engine with a single lever operating both mixture and throttle.

The SR-20 will also be fitted standard with a Ballistic Recovery System (BRS) parachute (a first for a certificated production aircraft), while various energy absorbing features have been designed into the airframe to reduce deceleration loads and increase its ability to absorb energy in the event of an impact.

Apart from its high levels of technology, Cirrus claims that the SR-20 offers significant improvements over current four seaters in the areas of performance, interior cabin space and internal noise levels. The cockpit interior is based on modern automotive designs.

The SR-20 prototype made its first flight on March 31 1995. Full FAA FAR Part 23 certification was awarded on October 23 1998, with first deliveries planned for that December (certification was delayed somewhat because Cirrus sought to lower the stall speed and improve lateral control). Cirrus aims to build up to 400 SR-20s a year once full production is achieved.

A number of developments of the SR-20 have been considered including a more basic version optimised for flying training powered by a 120kW (160hp) engine.  In the fall of 2000, Cirrus Design received FAA certification for the 310 hp SR-22.  With a longer wingspan, increased payload and higher cruise speeds, it promises to fill a market niche for those desiring these attributes.


 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna Corsair, Conquest I & II & Caravan II ',39889954.0,'img/0116656-v40-6.jpg',' The Corsair and Conquest I, and the 441 Conquest II are the turboprop powered equivalents of the 421 Golden Eagle and 404 Titan respectively. <p>The Model 441 Conquest was the first to be developed, it was designed concurrently with the piston engined 404 Titan in the mid 1970s. Development was announced in November 1974, and the first flight occurred in August 1976. First customer deliveries were from September 1977. The 441 shares a common fuselage with the Titan, but has a longer span (bonded and wet) wing, a pressurised fuselage, and most significantly, Garrett TPE331 turboprop engines. A PT6A powered 441, designated the 435, flew during 1986, but it did not enter production. <p>The 425 Corsair meanwhile was introduced to the Cessna model lineup from 1980. Based on the Model 421 Golden Eagle, it differs from its donor aircraft in having turboprop engines (in this case PT6As). Design work on the Corsair began in 1977, first flight was on September 12 1978 and first production deliveries took place in November 1980. <p>From 1983 Cessna renamed the Corsair the Conquest I, while the Conquest became the Conquest II. Production of both ceased in 1986. <p>The French built Reims Cessna F406 Caravan II meanwhile is something of a hybrid, incorporating 373kW (500shp) PT6A112s, the unpressurised fuselage of the Titan and the Conquest II''s wings. First delivered in late 1984, the Caravan II is the only Cessna turboprop twin currently in production. <p> ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna T303 Crusader ',29484493.0,'img/0089521-v40-6.jpg',' Cessna''s Model 303 started life as a four seat twin, intended for the hotly contested light transport and training role. <p>One four seat 303 was flown for a time from February 14 1978. Powered by two 120kW (160hp) Lycoming O320 engines it would have competed against the Beech Duchess, Grumman GA7 (Cougar) and Piper Seminole. However, a reappraisal of market demand for aircraft in this already crowded class led to Cessna rethinking the 303 design, and the outcome was a larger aircraft. Instead the resulting six seater aircraft was intended to replace Cessna''s 310, then nearing the end of its production life. <p>The new model, designated the T303 for its turbocharged (and fuel injected) Continental TSIO520 engines, flew for the first time on October 17 1979. Certification was granted in August 1981, and first production deliveries commenced in October 1981. For a time the T303 was named the Clipper, but this was changed to Crusader as PanAm held the rights to the Clipper name. <p>In its definitive form the T303 incorporated a number of advanced features, being the first entirely new piston twin from Cessna in over a decade. Features included bonded structures around the integral fuel tank, a supercritical wing section and counter rotating propellers, while standard equipment included integral airstairs and a full IFR avionics suite (Cessna claimed the latter as a first for its class). <p>Only minor changes were introduced during production, including the addition of anti ice equipment as an option in 1982, and in 1983 the rear cabin bulkhead was moved aft slightly which increased baggage space and allowed the addition of a cargo door. <p>Production of the Crusader wound up in 1985 as part of the general decline in light aircraft sales during that period, terminating prematurely what looked to be a successful program. The cancellation also put paid to rumours that Cessna planned to develop more powerful, pressurised, and turboprop powered versions of the aircraft. <p> ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna Citation II & Bravo ',91683886.0,'img/0171521-v40-6.jpg',' The early success of the original Citation led Cessna to develop a larger capacity Citation model in the mid 1970s. <p>Cessna announced the stretched Citation in September 1976. The fuselage was extended by 1.14m (3ft 9in) to increase maximum seating capacity to 10, while more powerful Pratt & Whitney Canada JT15D4 engines and greater fuel tankage meant higher cruise speeds and longer range. Increased baggage capacity and increased span wings were also added. <p>The new Model 550 Citation II first flew on January 31 1977 and FAA certification for two pilot operation was awarded in March 1978. The II/SP is the single pilot version. <p>Major improvements were made to the design with the arrival of the Model S550 Citation S/II. Announced in October 1983, this improved version first flew on February 14 1984. Certification, including an exemption for single pilot operation, was granted that July. Improvements were mainly aerodynamic, including a new wing designed using supercritical technology developed for the Citation III (described separately), plus JT15D4B turbofans. The S/II initially replaced the II in production from 1984, but the II returned to the lineup from late 1985, and both variants remained in production until the introduction of the Bravo. <p>The Bravo features new P&WC PW530A turbofans, modern Honeywell Primus EFIS avionics suite, a revised interior based on that introduced in the Citation Ultra and other improvements such as trailing link main undercarriage. The Bravo first flew on April 25 1995 and was granted certification in August 1996. First delivery was in February 1997. <p> ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna Citation III, VI & VII ',74092402.0,'img/0153627-v40-6.jpg',' The all new Cessna Model 650 Citation III was designed as a high performance, mid size long range corporate jet to supplement the much smaller Citation I and II. <p>Development of this very different Citation began in 1978. As it evolved, the III had little in common with the previous Citation models other than the name. The new design featured a swept supercritical wing optimised for high speed long range flight, new Garrett TFE731 turbofans, a Ttail, and a new fuselage. <p>The new jet made its first flight on May 30 1979 with a second prototype flying on May 2 1980. Certification was granted on April 30 1982, first customer deliveries occurring the following year. The Citation III set two time to height records for its class in 1983 and a class speed record by flying from Gander to Le Bourget in 5hr 13min. <p>Production improvements to the Citation III were first proposed in the cancelled Citation IV. This model was announced in 1989 and was to feature longer range through greater fuel tankage, and better short field performance. In its place instead Cessna developed the Citation VI and VII. The Citation VI was offered as a low cost development of the III with a different avionics package and a standard interior layout, with customised interiors unavailable. First flight of the Citation VI took place in 1991 but only 39 were built when production was wound up in May 1995. <p>The Citation VII meanwhile features a number of improvements including more powerful engines for improved hot and high performance. The first Citation VII prototype flew in February 1991 and the type was certificated in January 1992. The Citation VII remains in production as the only member of the Citation III/VI/VII currently available new build. <p>A recent significant customer for the Citation VII was Executive Jet Aviation which ordered 20 for its NetJets fractional ownership scheme for delivery from 1997. <p> <p> ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna CitationJet, CJ1 & CJ2 ',65266813.0,'img/0162451-v40-6.jpg',' The highly successful CitationJet was developed as a replacement for the Citation and Citation I. Improved and stretched developments, the CJ1 and CJ2 respectively, are under development.

Cessna launched the new Model 525 CitationJet at the annual US National Business Aircraft Association convention in 1989. First flight occurred on April 29 1991, FAA certification was awarded on October 16 1992 and the first delivery was on March 30 1993.

The CitationJet is effectively an all new aircraft. The same basic Citation forward fuselage is mounted to a new T-tail configured tailplane and a new supercritical laminar flow wing, and it features Williams Rolls FJ44 turbofans (with paddle thrust reversers) and trailing link main undercarriage. The CitationJet''s fuselage is 27cm (11in) shorter than the Citation/Citation I''s, while cabin height is increased courtesy of a lowered centre aisle. It features EFIS avionics and is certificated for single pilot operation.

At the 1998 NBAA convention Cessna revealed it was developing the improved CJ1 and stretched CJ2. The CJ1 will replace the CitationJet and will introduce a Collins Pro Line 21 EFIS avionics suite and a moderate increase in maximum takeoff weight. The CJ1 will be delivered from the first quarter of 2000.

The CJ2 meanwhile is a stretched, faster and more powerful development. Due to fly in the second quarter of 1999 and be certificated 12 months later, the CJ2 will feature a 89cm (35in) cabin and 43cm (17in) tailcone stretch allowing standard seating for six in the main cabin. Like the CJ1 it will feature Collins Pro Line 21 EFIS avionics, plus uprated FJ44-2C engines, increased span wings, larger area tail, six cabin windows per side and greater range. It will be certificated for single pilot operation.



 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 680 Citation Sovereign ',96634168.0,'img/1226334-v40-6.jpg',' Cessna is developing the new Citation Sovereign mid size corporate jet to meet what it sees as a large replacement market for ageing business aircraft such as the Falcon 10, Westwind and Sabreliner.

Cessna market research showed that of the 1760 or so mid sized corporate jets in service worldwide almost half are early generation aircraft which it felt would come up for replacement in the coming years. Its answer to this emerging market is to develop the Citation Excel based Model 680 Citation Sovereign, which it revealed at the October 1998 NBAA exhibition in Las Vegas. Certification is planned for late 2003 with customer deliveries getting underway in the first quarter of 2004.

The Sovereign is based on the Excel''s fuselage and shares some common systems but features an all new wing and numerous other differences. Cessna looked at an all new fuselage cross section for the Sovereign but opted instead to stretch the Excel fuselage (by 1.5m/4.9ft) to keep down costs and reduce development time. Even so Cessna claims the Sovereign''s eight seat cabin is the largest in its class with 40% more volume than the Bombardier Learjet 60 and 18% more than the Raytheon Hawker 800XP.

Power for the Sovereign will be from two FADEC equipped 25.3kN (5690lb) Pratt & Whitney Canada PW-306Cs. The PW-306 was selected in part as it also powers the 328JET regional airliner which should give maintenance and reliability benefits because of the airline industry''s more rigorous operating demands.

The mildly swept wing is an all new, supercritical design, based on Cessna''s experience with the Citation III/VII, V and X. The horizontal stabiliser is also slightly swept. The Sovereign will enjoy good field performance, being able to operate from 1220m (4000ft) runways at max takeoff weight. Another feature is trailing link main undercarriage.

The Sovereign will be equipped with a Honeywell Epic CDS avionics suite, with four 20 x 25cm (8 x 10in) colour flat panel liquid crystal displays, a digital dual channel autopilot and flight director, dual long range navigation systems and dual attitude/heading reference systems. Other standard equipment will include TCAS and an EGPWS (enhanced ground proximity warning system).

The first flight of the prototype was made on February 27, 2002. The first production model is scheduled to fly by July 2002

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 560 Citation V, Ultra & Ultra Encore ',70128068.0,'img/0114171-v40-6.jpg',' The Citation V, Citation Ultra and Ultra Encore are the largest straight wing members of Cessna''s highly successful Citation family.

Cessna publicly announced it was developing a stretched development of the Citation II at the annual NBAA convention in New Orleans in 1987. Earlier in August that year the first engineering prototype Model 560 Citation V had successfully completed the type''s maiden flight. A preproduction prototype flew in early 1986, while US certification was granted on December 9 1988. Deliveries began the following April.

The Citation V was based on the Citation II/SP, but differences over the smaller jet include more powerful Pratt & Whitney Canada JT15D5A turbofans and a slight fuselage stretch, allowing seating in a standard configuration for eight passengers. The Citation V proved quite popular, with 262 built through to mid 1994 before production switched to the modernised Ultra.

Cessna announced development of the upgraded Citation V Ultra in September 1993. FAA certification was granted in June 1994, allowing for deliveries of production aircraft to commence soon after. Compared with the Citation V, the Ultra features more powerful 13.6kN (3045lb) Pratt & Whitney Canada JT15D5D engines and Honeywell Primus 1000 EFIS avionics with three CRT displays (two primary flight displays and one multifunction display).

The Citation Ultra Encore is a new development announced at the 1998 NBAA convention. Compared with the Ultra the Encore introduces new Pratt & Whitney Canada PW535 engines, plus trailing link main undercarriage, more fuel payload, updated interior and improved systems. The Ultra''s Honeywell Primus 1000 EFIS avionics suite is retained.



 International Directory of Civil Aircraft





 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 560XL Citation Excel ',87004042.0,'img/0242795-v40-6.jpg',' One of the latest members of Cessna''s extensive line of Citation business jets, the Citation Excel combines the cabin width and standup headroom comfort of the Citation X in a new small/medium size package.

The new Excel resulted from customer consultation over what they wanted in a light corporate jet plus advances in engine and airframe technology. The basis of the Excel is a shortened Citation X fuselage (the same fuselage cross section as was used in the Citation III, VI and VII), combined with a modified unswept supercritical wing based on the Citation V Ultra''s, the V''s cruciform tail configuration and new Pratt & Whitney Canada PW-545A series turbofans.

Other design features include trailing link main undercarriage units and a standard Honeywell Primus 1000 three 20 x 18cm (8 x 7in) screen EFIS avionics package (two Primary Flight Displays, one for each pilot, and a multifunction display).

Cessna claims the Citation Excel''s cabin is the largest of any light business jet. It features standup headroom and a dropped aisle that runs the length of the main cabin. Seated head and elbow room is greater than that in the Citation II and V, while the cabin length is similar to the Citation I, II, VI and VII.

The Excel was one of the first applications for the new generation PW-500 series engines. The Excel''s 16.9kN (3804lb) PW-545As (derated from 19.9kN/4450lb, with a TBO of 5000 hours) are fitted with Nordam thrust reversers as standard and the engines allow it to cruise at 801km/h (432kt).

Cessna announced it was developing the Excel at the NBAA convention in October 1994. Prototype construction began in February 1995 and it flew for the first time on February 29 1996. The first production Excel rolled out in November 1997 and the type was certificated in April 1998, with first deliveries beginning mid that year at which stage over 200 were on order.

Cesna delivered the 100th Excel in August 2000, at which time the company was building one every three days. Cessna says this is the fastest ramp-up of production of any Citation jet yet.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 500 & 501 Citation, Citation I & Citation I/SP ',51118792.0,'img/0182535-v40-6.jpg',' The highly popular Cessna 500 Citation and 500 Citation I pioneered the entry level light business jet market, and their success formed the basis for the world''s largest family of corporate jets.

Cessna became the first of the big three American manufacturers (Piper, Beech and Cessna) to develop a jet powered transport. In October 1968 Cessna announced its plans to build a new eight place jet powered business aircraft that would be capable of operating into airfields already served by light and medium twins. Dubbed the Fanjet 500, the prototype flew for the first time on September 15 1969. Soon after the new little jet was named the Citation.

A relatively long development program followed, during which time a number of key changes were made to the design including a longer forward fuselage, repositioned engine nacelles, greater tail area and added dihedral to the horizontal tail. In this definitive form the Citation was granted FAA certification on September 9 1971.

Improvements including higher gross weights and thrust reversers were added to the line in early 1976, followed shortly after by the introduction of the enhanced Citation I later that same year. Features of the Citation I were higher weights, JT15D-1A engines and an increased span wing. A further model to appear was the 501 Citation I/SP, which is certificated for single pilot operation. The I/SP was delivered in early 1977.

Production of the Citation I ceased in 1985, its place in the Citation line left vacant until the arrival of the CitationJet (described separately) some years later.

Direct developments of the Citation were the Citation II (now Citation Bravo) and Citation V (now Citation Ultra Encore).

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 404 Titan ',53039114.0,'img/0155884-v40-6.jpg',' In July 1975 Cessna announced it was developing a new piston twin suitable for airline, freight and corporate work, capable of taking off with a 1560kg (3500lb) payload from a 770m (2530ft) strip, similar in concept to the successful 402, but larger overall.

The resulting aircraft was the Model 404 Titan, Cessna''s largest piston engined twin developed thus far. It shares the same basic fuselage as the turbine powered 441 Conquest which was developed concurrently, but differs in having geared 280kW (375hp) piston engines and it is unpressurised. Other features include a bonded wet wing (then appearing on a number of 400 series Cessna twins) and the trailing link main undercarriage design shared with the Conquest.

The prototype Titan first flew on February 26 1975, production deliveries got underway in October the following year. Throughout the Titan''s model life it was offered in three major versions, each differing in internal equipment fit.

The base aircraft was the Titan Ambassador, configured for passenger operations, while the Titan Courier was convertible from passenger to freight configurations, and the Titan Freighter was a pure cargo aircraft. The Titan Freighter was specially equipped for freight operations with a strengthened floor, cargo doors and walls and a ceiling made from impact resistant material. All were offered with II and III avionics equipment levels (as with other Cessna twins).

The Titan underwent minor modifications from 1980 when the wing span was increased and the wingtips redesigned, but production was to last for only another two years until 1982, by which time 378 had been built.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 421 & 414 ',54685120.0,'img/0165079-v40-6.jpg',' The lineage of the 421 and 414 traces back to the 411, the 421 beginning life as a pressurised development of the 411.

The prototype 421 took to the skies for the first time in October 1965 (three years after the 411). In comparison to the 411 on which it was based, the 421 introduced a cabin pressurisation system, more powerful geared and turbocharged GTSIO-520-D engines and a higher max takeoff weight. Deliveries of production 421s began in May 1967, Cessna at the time claiming it as the cheapest pressurised twin on the market.

First improvements to the 421 were offered with the 421A of 1969, but the 421B Golden Eagle of 1970 featured a number of significant improvements including lengthened nose and wing span, while the engines retained their power to higher altitudes than before. The final expression of the 421 was the 421C available from late 1975, with a bonded wet wing and no tip tanks, higher vertical tail, more efficient props and new trailing link undercarriage.

The 414 was developed as a less powerful, lighter, simpler and lower cost 421. First flown in 1968, it entered production in 1969. It features the wings and fuselage of the 401 and 402 (themselves lighter developments of the 411), plus direct drive, rather than geared engines. The improved 414A Chancellor appeared in 1978, introducing the bonded wet wing without tip tanks. It remained in production until 1985.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 340 & 335 ',46585113.0,'img/0082649-v40-6.jpg',' When released, the Cessna 340 joined the Beechcraft Duke as the only other six seat pressurised piston twin from a major manufacturer, positioned in Cessna''s product line between the 310 and the eight seat 414 and 421.

Development of the 340 began in 1969, but the loss of the prototype early in 1970 set back the development program so that production deliveries did not begin until early 1971. The resulting aircraft borrowed heavily from other Cessna twins of the time including the wings from the 414 and the 310''s undercarriage and a similar tail unit. Design features of the new aircraft included a pressurisation system with a differential of 0.29bars (4.2psi) that kept the cabin''s internal altitude at 8000ft while the aircraft was at 20,000ft, an all new fail safe fuselage and an integral airstair door.

Initial production 340s were powered by two 210kW (285hp) turbocharged Continental TSIO-520-K engines, but these were replaced on the improved 340A, which was first introduced in 1976. Power for the 340A was supplied by two 230kW (310hp) TSIO-520-NBs, while other improvements included reduced diameter props and a slight increase in weights. The 340A was offered in optional 340A II and 340A III forms with various levels of IFR avionics fitted.

The Cessna 335 is an unpressurised, lighter weight and thus lower cost development of the 340. Available from 1979, aside from being unpressurised it differed in having 225kW (300hp) TSIO-520-EB engines. Although claimed by Cessna as the lowest priced cabin class business twin on the market, just 64 335s were built before production was terminated in 1980.

Production of the 340 continued until 1984.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 336 & 337 Skymaster ',39142702.0,'img/0211070-v40-6.jpg',' Through their pushpull engine configuration the twin boom Cessna 336 and 337 were designed to overcome conventional twins'' problems of poor engine out asymmetric flight handling characteristics.

Cessna called the layout concept Centre Line Thrust, as the nose mounted tractor and rear fuselage mounted pusher engine eliminated asymmetric handling problems normally experienced when one of a twin''s engines fails. The concept was recognised by the US FAA which created a new centre thrust rating for pilots to be rated on the type.

The Model 336 Skymaster first flew on February 18 1961, but significant improvements to the design were made before production aircraft were delivered. Changes included more powerful engines, a larger fuselage with seating for six, and revised wing, tail and rear engine cowling. The 336 was delivered from mid 1963 and production lasted until late 1964 when it was replaced by the 337 Super Skymaster (''Super'' was later dropped) which was released in February 1965.

The improved 337 introduced retractable undercarriage, more powerful 160kW (210hp) engines, a dorsal air intake for the rear engine, variable cowl flaps, repositioned forward engine and cowl for improved visibility, and higher weights.

Subsequent development resulted in the turbocharged T337 (first released in the 1967 model year, dropped in 1972 and relaunched in 1978), while the ultimate 337 was the T337G Pressurized Skymaster, introduced from August 1972.

Development of the 337 continued in France by Reims after Cessna production ended in 1980, resulting in the FTB337 Milirole, a military STOL version with underwing hardpoints. Cessna also built more than 500 337s as O-2s for the US Air Force, used largely in the Forward Air Control role.
 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 210 Centurion ',97450156.0,'img/0162848-v40-6.jpg',' During its production life the Cessna 210 was at the top of the Cessna single piston engine model lineup, positioned between the 182 and the 310 twin.

First flight of the 210 occurred in January 1957. This new aircraft featured for the first time on a Cessna aircraft retractable undercarriage and swept back vertical tail surfaces. The 210 entered production in late 1959, and from that time the line was constantly updated.

Notable early upgrades include the 210B which introduced the wraparound rear windows, the 210D with a more powerful (210kW/285hp) engine and introduced the Centurion name, and the turbocharged T210F. The 210G introduced a new strutless cantilever wing, increased fuel capacity, restyled rear windows and enlarged tail surfaces. Continual development of the 210 and T210 range continued through until production ceased in 1985.

A significant development of the T210 was the high performance, pressurised P210 which first appeared in 1978. The pressurisation system meant that the cabin''s internal altitude was equivalent to 8000ft when flying at 17,350ft.

In 1998 Cessna was considering returning the 210 to production.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 208 Caravan I, Grand Caravan & Cargomaster ',56325173.0,'img/0208314-v40-6.jpg',' With sales exceeding the 1000 mark the useful Caravan is a popular utility workhorse worldwide.

Design work for the Caravan dates back to the early eighties. First flight of a prototype occurred on December 9 1982 and certification was granted in October 1984. When production began the following year it became the first all new single engine turboprop powered aircraft to achieve production status.

The Caravan I has had a close association with US package freight specialist Federal Express (FedEx), on whose request Cessna especially developed two pure freight versions. The first of these was the 208A Cargomaster (40 delivered), the second was the stretched 208B Super Cargomaster (260 delivered). The first Super Cargomaster flew in 1986 and features a 1.22m (4ft) stretch and greater payload capacity, including an under fuselage cargo pannier. FedEx''s aircraft lack cabin windows.

The 208B Grand Caravan first flew in 1990 and like the Super Cargomaster is a stretched version of the basic Caravan powered by a 505kW (675shp) PT6A-114. It can seat up to 14 passengers.

Announced at the 1997 NBAA convention, the 208-675 has replaced the basic 208. It combines the standard length airframe of the 208 with the more powerful PT6A-114 of the 208B.

Underbelly cargo pods, floats and skis are offered as options on the Caravan I family, and the type is easily converted from freight to passenger configurations.

A military/special missions version of the 208A, dubbed the U-27A, is also on offer. The Brazilian Air Force designation is C-98.

Soloy is offering a dual-engine conversion of the 208B, named Pathfinder 21. This version is powered by a 991kW (1329shp) Pratt & Whitney Canada/Soloy Dual Pac powerplant, consisting of two PT6D-114A engines driving a single propeller. Other distinguishing features of the Pathfinder 21 include a 72in cabin stretch behind the wing and a large integral cargo pod.



 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 205, 206 & 207 ',57401866.0,'img/0183813-v40-6.jpg',' The popular 205/206/207 line began life as a four seat utility aircraft, stretched from the 182 Skylane.

In its initial form the 205 (originally 210-5) was essentially a fixed undercarriage derivative of the 210 Centurion, optimised for utility roles, giving more baggage space. Introduced to the Cessna lineup in 1962, the 205 was powered by the same IO-470 engine as the 210B and featured an additional small cargo door on the left side of the fuselage. It later gained it''s 6th seat.

The 205 lasted in production until 1964 when it was replaced by the more powerful 206, which came in 2 options, the P206 Super Skylane and the U206 Super Skywagon, which respectively meant Passenger and Utility, the U206 featuring larger double cargo doors on the right fuselage side. Continuous improvement followed, including introduction of turbocharged and fuel injected models. The ''Super'' prefix for the Super Skywagon was dropped in 1969 and the Stationair name was adopted in 1971. Production originally ceased in 1985.

The 207 Skywagon meanwhile featured a .07m (3ft 6in) fuselage stretch (allowing seating for seven) and became available from 1969. Known as the Stationair 7 from 1978, it was replaced by the 207A Stationair 8 from 1979 which had seating for an eighth occupant. Production ended in 1984. A few were built in France by Reims as the F207. Several 206 and 207 aircraft have been converted to turbine power by Soloy as the Turbine 206 and 207.

The 206 is the third Cessna single to be returned to production at the company''s new Independence plant in Kansas. Two versions are offered, the normally aspirated 206H and turbo T206H. The T206H first flew on August 6 1996, powered by a TIO-580, while the normally aspirated 206H, powered by an IO-580, followed on November 6. A decision to switch to the TIO-540 and IO-540 because of reliability concerns pushed back production by about 10 months. The 206H was certificated on September 9 1998, the T206H on October 1.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 188 Agwagon series ',56959194.0,'img/0102519-v40-6.jpg',' The successful 188 Agwagon agricultural aircraft were Cessna''s only purpose designed agplanes.

Cessna''s Model 188 resulted from extensive research and consultation with agricultural aircraft operators conducted in the early 1960s. The design Cessna settled upon was of the conventional agricultural aircraft arrangement with a braced low wing (unique among Cessna singles) with seating for the pilot only. Like other ag aircraft the chemical hopper is of fibreglass and the rear fuselage is of semi monocoque construction and sealed to reduce the potential for damage from chemical contamination.

The prototype Cessna 188 Agwagon flew for the first time on February 19 1965, and type approval was awarded the following February. The 188 was initially offered in two forms, the 170kW (230hp) Continental O-470-R powered 188 (which was named the AgPickup from 1972) and the 250kW (300hp) Continental IO-520-D powered 188A Agwagon.

The 1972 model year also saw the introduction of the most successful 188 model, the AgTruck. The AgTruck has the same powerplant as the Agwagon, but a larger hopper and a higher max takeoff weight. The ultimate 188 model is the AgHusky, which was introduced in 1979. It features a turbocharged TSIO-520-T and a further increased max takeoff weight.

Production of the AgPickup was suspended in 1976, the Agwagon in 1981 and the AgTruck and AgHusky in 1985, when all Cessna light aircraft production ceased.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 182 Skylane ',38237435.0,'img/0107021-v40-6.jpg',' The popular, relatively high performance Cessna 182 began life as a tricycle development of the 180.

The first Model 182 appeared in 1956 while the Skylane name was first introduced with the 182A development to denote an optional higher level of equipment. Major changes were introduced with the 182C, including a third window on each side of the cabin and a swept vertical tail. Other improvements introduced over the 182''s lifespan included shorter undercarriage, reprofiled cowling, wrap around rear cabin window, progressively higher takeoff weights and improved wing root, fintip, and rudder fairings.

The retractable undercarriage Skylane RG arrived in 1977, giving a significant speed increase. A further performance boost came with the introduction of the turbocharged 175kW (235hp) Lycoming O-540-L engine on the T182RG, which became available from 1979. The AiResearch turbocharger meant that maximum power could be delivered right up to the 182''s service ceiling of 20,000ft. A turbocharged fixed gear model was also offered for a time, but only small numbers were built.

The 182 was also produced by Reims in France as the F182, and by DINFIA in Argentina as the A-182. Cessna 182 production initially ceased in 1985.

In 1994 Cessna announced plans to return the 182 to production, following the success of product liability law reforms in the USA. The new 182S prototype first flew on July 15 1996, the first was delivered in April 1997. Improvements include a IO-540-AB1A5 engine, new interior and avionics panel.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 310/320 ',60367049.0,'img/1026042-v40-6.jpg',' The sleek Cessna 310 was the first twin engine design from Cessna to enter production after WW2.

The 310 first flew on January 3 1953. The modern rakish lines of the new twin were backed up by innovative features such as engine exhaust thrust augmentor tubes and the storage of all fuel in tip tanks. Deliveries commenced in late 1954.

The first significant upgrade to the 310 line came with the 310C of 1959, which introduced more powerful 195kW (260hp) IO-470-D engines. The 310D of 1960 featured swept back vertical tail surfaces. An extra cabin window was added with the 310F. A development of the 310F was the turbocharged 320 Skyknight, with TSIO-470-B engines and a fourth cabin side-window. The Skyknight was in production between 1961 and 1969 (the 320D, E and F were named Executive Skyknight), when it was replaced by the similar Turbo 310.

The 310G introduced the ''stabila-tip'' tip tanks, while the 310K replaced the rear two windows on each side with a single unit. Subsequent significant developments include the 310Q and turbocharged T310Q with redesigned rear cabin with a skylight window, and the final 310R and T310R, identifiable for their lengthened noses. Production ended in 1980.

USAF military versions were the L-27A (310A) and L-27B (310M) Blue Canoe, later redesignated U-3A and U-3B.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 180 & 185 Skywagon ',87001614.0,'img/0271135-v40-6.jpg',' The 180 started life as a more powerful development of the 170, and evolved into a family of useful utility aircraft that was in production for over three decades.

The first 180s were essentially Model 170s with a more powerful 170kW (225hp) O-470-A engine. The first of the type flew in 1952 and deliveries began in February the following year. The 180''s career as a high performance single was short lived due to the arrival of the tricycle 180 based 182 in 1956, but by then the type had established itself a useful niche as a utility aircraft.

Progressive updating of the line led to a range of updated models including the 170kW (230hp) 180A, and 1964''s 180G with a third cabin window which from 1966 was offered as a six seater, by then having the same fuselage as the more powerful 185 Skywagon. The Skywagon name was applied to the 180 in 1969. The 180 remained in production until 1981.

The first 185 Skywagon flew in July 1960. It differed from the 180 in having a more powerful engine (195kW/260hp) and larger cabin, allowing six seats. Updated models include the 225kW (300hp) A185E from 1967 and the AgCarryall capable of chemical spraying.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna Citation X ',18591244.0,'img/0133144-v40-6.jpg',' The Citation X is Cessna''s largest, fastest and longest range aircraft yet, and Cessna claims it to be the fastest civil transport in service other than the supersonic Concorde.

The Citation X (as in the Roman numeral, not the letter, and Cessna''s Model 750) is also the largest member of business aviation''s biggest corporate jet family, the Citation series.

The design objectives behind the Citation X included transcontinental USA and trans Atlantic range in a mid size package that cruises faster than any other business jet available. This high speed cruise capability, which Cessna says is 105 to 210km/h (55 to 113kt) faster than other mid size corporate jet, means the X can save up to one hour''s flight time on transcontinental US flights, flying from Los Angeles to New York with normal wind conditions in 4 hours 10 minutes. Because of its ability to cruise at high speed at high altitudes, Cessna also says the Citation X will consume less fuel than current jets on such a transcontinental flight.

The X''s FADEC equipped Allison AE 3007A turbofans are very powerful for an aircraft of the X''s size, while the highly swept (37°) wings are also long in span.

Other design features of the Citation X include the fuselage cross section of the Citation III, VI and VII but with more efficient use of internal space that allows greater head and shoulder room, an area ruled, waisted rear fuselage, trailing link main undercarriage units and a modern Honeywell Primus 2000 EFIS avionics suite with five colour CRT displays.

Cessna announced that it was developing the Citation X in October 1990 at that year''s NBAA conference. The prototype was publicly rolled out in September 1993 and flew for the first time on December 21 that year. Certification was granted on June 3 1996, with the first customer delivery (to golfer Arnold Palmer) that month.

A Citation X was the 2500th Citation to be delivered, handed over on September 10 1997. The USA''s National Aeronautics Association awarded its prestigious Collier Trophy to the Citation X design team in February 1997.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 411, 401 & 402 ',72275875.0,'img/0210499-v40-6.jpg',' The 411 was Cessna''s entry into the eight seat cabin class twin market that had previously been dominated by the Beech Queen Air.

Much more modern than the Queen Air, the 411 was lighter, smaller and faster. The prototype first flew in July 1962 and differed from the following production aircraft in having two blade props and direct drive engines (as opposed to the geared GTSIO-520-C engines of production aircraft). Production deliveries commenced in October 1964. Optional features for corporate configured aircraft included folding tables, a toilet and refreshment centre. The 411 was followed up by the 411A from 1967 with lighter and more efficient props and optional extra fuel capacity.

The 411 was soon after replaced by the 401 and 402, which had first been introduced in late 1966. These developments of the 411 were lighter, less powerful and had direct drive engines, and thus were less costly to operate. While the 401 and 402 were essentially the same aircraft, the 401 was optimised for corporate transport and was fitted with fewer seats than the 402, which was configured for commuter and freighter work. A number of versions of both models were developed with minor refinements, including the 402A, which had a lengthened nose, square windows and an optional 10th seat.

The 402 replaced the 401 from mid 1972, and, as the 402B, was offered in Businessliner corporate configuration, and Utililiner convertible passenger or freighter aircraft. The 402C appeared in late 1978 and featured the longer span wings from the 414A and 421C and more powerful engines. It remained in production until 1985.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 177 Cardinal ',59635502.0,'img/0265105-v40-6.jpg',' The Cessna 177 (Cardinal for the Deluxe option) was developed in the mid 1960s as an all new replacement for the ubiquitous 172 family.

Announced in late 1967, this new aircraft featured a wide and fairly spacious cabin, a rear set flush riveted high wing which offered good visibility in turns, a single piece all moving tailplane, a high level of standard equipment and the 110kW (150hp) O-320-E recently installed on the 172 driving a fixed pitch prop. Offered in two versions, the standard 177 and upspec Cardinal (wheelspats, overall paint, etc.), it entered the marketplace priced around 10% more than the then current 172 model.

While not a failure, the 177 failed to attract anywhere near the sales volume of the 172 (in its first full year - 1968 - 601 were built, about half the number of 172s built that year). A perceived shortcoming of the initial model was a lack of power, this was addressed with the 135kW (180hp) O-360-A powered 177A introduced in late 1968. The increase in engine power and hence performance lifted the 177 into a more upmarket four seater market niche between the 172 and 182.

The 1970 model 177B introduced a revised aerofoil, conical camber wingtips, cowl flaps and a constant speed propeller. An up market version of the 177B known as the Cardinal Classic appeared in 1978 with full IFR instrumentation and luxury interior fittings.

The 177RG was announced in December 1970, and, as its designation suggests, featured hydraulically actuated retractable undercarriage, plus a 150kW (200hp) fuel injected IO-360-A engine and a constant speed prop.

Both the 177B and 177RG remained in production until 1978.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Cessna 172R/S Skyhawk ',91360908.0,' The Cessna 172R Skyhawk is possibly the most important light aircraft to enter production in the 1990s as it is the modern day development of the most popular GA aircraft in history.

Recession and crippling product liability laws in the USA forced Cessna to stop production of light aircraft, including the 172, altogether in 1985. It was not until the signing of the General Aviation Revitalisation Act by the US President in August 1994 that Cessna announced it would resume light aircraft production.

The new 172R Skyhawk is based on the 172N (the previous major Skyhawk production model), but features a fuel injected Textron Lycoming IO-360-L2A engine. Cessna says it is significantly quieter than the O-320 it replaced as it produces its max power at only 2400rpm.

Other changes include a new interior with contoured front seats which adjust vertically and recline, an all new multi level ventilation system, standard four point intercom, interior soundproofing, and energy absorbing 26g seats with inertia reel harnesses.

The 172R features epoxy corrosion proofing, stainless steel control cables, a dual vacuum pump system, tinted windows, long range fuel tanks, backlit instruments with non glare glass and an annunciator panel. 172R options include two avionics packages (one with GPS, the other with IFR GPS and a single axis autopilot) and wheel fairings.

An engineering prototype 172R (a converted 1978 172N) powered by an IO-360 first flew in April 1995, while the first new build pilot production 172R first flew on April 16 1996. This aircraft was built at Wichita, while production 172Rs are built at an all new factory in Independence, Kansas.

The higher performance 172S Skyhawk SP is pitched at `owner-users''. Delivered from July 1998 it features a IO-360-L2A (as on the 172R) but rated at 135kW (180hp) by increasing rpm. It also features a 45kg (100lb) increase in useful payload, a new prop and standard leather

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 172 Skyhawk (early models) & 175 Skylark ',54850558.0,'img/0182383-v40-6.jpg',' The Cessna 172 is without doubt the most successful mass produced light aircraft in history. From 1955 through to 1967 the 172 was powered by the six cylinder Continental O-300, before this engine was replaced by the four cylinder Lycoming O-320.

The Cessna 172 started life as a relatively simple tricycle undercarriage development of the taildragger 170, with a fairly basic level of standard equipment. First flight was in November 1955. The 172 became an overnight sales success and over 1400 were built in 1956, its first full year of production.

The basic 172 remained in production until replaced by the 172A of early 1960. The 172A introduced a swept back tail and rudder, while the 172B of late 1960 introduced a shorter undercarriage, equipment changes and for the first time the Skyhawk name for the Deluxe option.

The 172D of 1963 introduced the cut down rear fuselage with wraparound rear window. The 172F introduced electric flaps and was built in France by Reims Cessna as the F172 through to 1971. It also formed the basis for the US Air Force''s T-41A Mescalero primary trainer. The 172G of 1966 introduced a more pointed spinner, while the 172H was the last Continental powered 172.

The 175 (Skylark for the Deluxe option) meanwhile was powered by a 130kW (175hp) geared GO-300, the GO-300 powered P172D Powermatic of 1963 had a constant speed prop. The 1966 R172E had a Continental IO-360 and a constant speed prop. It was built in France as the FR172 Reims Rocket.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 172 Skyhawk (later models) ',73646559.0,'img/0160718-v40-6.jpg',' In the late 1960s Cessna re-engined its already highly successful 172 four seater with the four cylinder Lycoming O-320. These O-320 powered models were the most successful to bear the 172 model number (and the Skyhawk name for the Deluxe option), as they were in production during GA''s golden years, the 1970s.

Cessna re-engined the 172 with the Lycoming O-320-E as compared with the O-300 it had two less cylinders (and thus lower overhaul costs), a 200 hour greater TBO, improved fuel efficiency and more power. Even so, Cessna thought 172 production would be shortlived as the similarly powered but more modern 177 Cardinal was released at the same time. In spite of the Cardinal, the Lycoming powered 172 was a runaway success and easily outsold and outlived its intended replacement.

The first O-320 Skyhawk was the 172I introduced in 1968. The 1969 172K introduced a redesigned fin, reshaped rear windows and optional increased fuel capacity, while 1970''s 172K sported conical camber wingtips and a wider track undercarriage. The 172L in production in the 1971/72 model years was the first to feature the enlarged dorsal fin fillet.

The 172M of 1973/76 gained a drooped wing leading edge for improved low speed handling. The 172M was also the first to introduce the optional `II'' package of higher standard equipment. Also in 1976 Cessna stopped marketing the aircraft as the 172.

The 172N was powered by a 120kW (160hp) O-320-H designed to run on 100 octane fuel, but the engine proved troublesome and was replaced by the similarly rated O-320-D in the 172P of 1981. The P was the last basic 172 model, remaining in production until 1985.

Higher performance 172s include the R172 Hawk XP, powered by a 145kW (195hp) Continental IO-360 and the 135kW (180hp) Lycoming O-360 powered, retractable undercarriage 172RG Cutlass. The 172 was also produced under licence by Reims in France as the F172 and FR172.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('CASA C212 Aviocar ',64129952.0,'img/0035660-v40-6.jpg',' Initially conceived as a light STOL transport for the Spanish air force, the CASA C212 has found a handy market niche and is highly regarded for its utility in underdeveloped regions.

Designed to replace the Spanish air force''s mixed transport fleet of Douglas C47 Dakotas, CASA Azors and Junkers Ju 52s still in service in the 1960s, the C212 was also developed with the intention of offering a civil variant. Design work began in the late 1960s, the first prototype made the type''s first flight on March 26 1971. Preproduction examples followed, then the type entered air force service in 1974. The first commercial version was delivered in July 1975.

The basic civil version was designated the C212C, the military version the C2125. Production of these models ceased in 1978, CASA switching to the Series 200 with more powerful engines and higher operating weights. The first Series 200, a converted C212C prototype, flew for the first time in its new configuration on April 30 1978. A third development of the Aviocar is the Series 300 which first flew in 1984 and was certificated in late 1987. Improvements to this model are newer engines and winglets.

The latest development is the C212-400, which was launched at the 1997 Paris Airshow (after its first flight on April 4 that year). It features TPE331-12JR engines which maintain their power output to a higher altitude for improved hot and high performance and an EFIS flightdeck.

 ',' Spain ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 170 ',76332691.0,'img/0192161-v40-6.jpg',' A larger four seat development of the earlier Cessna Model 120 and 140, the four seat 170 was in production for almost a decade, and is the predecessor to the successful and long running 172 series.

The prototype Cessna 170 (NX41691) flew for the first time in September 1947. Notable features included the six cylinder 110kW (145hp) Continental C145 engine, extensive metal construction and the characteristic Cessna braced high wing.

The first production Cessna 170s were delivered from March 1948, but this model was soon replaced by the improved 170A. The primary improvement with the 170A was metal instead of fabric covered wings, but it also featured increased tail area.

The third and final major variant appeared in 1952. The Cessna 170B featured the most significant revisions to the line, including the large wing flaps (first developed for the military L-19 Bird Dog) that were to become characteristic of later single engine Cessna models, revised tail wheel steering, larger rear windows and revised and lengthened engine cowling.

The 170 remained in production until 1957, by which stage its popularity had waned and sales of the 172 had taken off. The early 172 was a direct development of the 170, but introduced tricycle undercarriage and squared up vertical tail surfaces.

It is interesting to note that the 170 laid the foundation for Cessna''s two most successful single engine light aircraft lines, the 172 and 182, as well as the 180 and 185. Apart from the 172 tricycle undercarriage development the 180 was developed as a more powerful, higher performance version of the 170, while the subsequent 182 was originally a tricycle undercarriage evolution of the 180.

 ',' United States of America ');

INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Canadair CL-600 Regional Jet CRJ-100 & 200 ',39629569.0,'img/0202432-v40-6.jpg',' Bombardier''s Canadair Regional Jet pioneered the new 50 seat jet class, and has since become a runaway sales success.

The Canadair Regional Jet - or CRJ - is designed to offer the high speed advantages of much larger jets, with similar standards of service while at the same time offering operating economics, particularly over longer stage lengths, close to that of comparable size turboprops.

The concept of a stretched airliner derivative of the Challenger is not new, Canadair (now part of Bombardier Aerospace) originally studied a 24 seat stretched development of the CL-600 up to 1981. Design studies for a stretched airliner based on the 601 however were first undertaken in 1987, leading Canadair to launch the Regional Jet program on March 31 1989. The first of three development aircraft took to the skies for the first time on May 10 1991. Transport Canada certification was awarded on July 31 1992, allowing the first customer delivery to Lufthansa that October.

Major changes over the Challenger apart from the stretched fuselage include a new advanced wing optimised for airline operations, higher design weights, EFIS flightdeck with Collins Pro-Line 4 avionics suite, new undercarriage, additional fuel capacity and slightly more powerful CF-34 engines.

The original CRJ-100 series - the 100, 100ER and 100LR - was augmented by the 200 series (with more efficient engines) in 1995. The Series 200 is available in standard 200, long range 200LR with optional greater fuel capacity, and the extended range Series 200LR (all three are offered in B form with CF34-3B1s for improved hot and high performance). Corporate shuttle configurations are also available as the Corporate Jetliner and the SE (Special Edition).

The stretched, 70 seat CRJ-700 is described separately.

 ',' Canada ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Canadair CL-600 Challenger 600 ',41167687.0,'img/0133730-v40-6.jpg',' The Canadair CL-600 Challenger had a troubled early history but formed the basis for what became a very successful business jet family.

In 1976 Canadair purchased the exclusive production, development and marketing rights to an all new business jet developed by Learjet designer Bill Lear. Known as the LearStar 600, this design was first conceived in 1974. Notable for its large size cabin, the LearStar promised long range and good operating economics and was also one of the first aircraft to be designed with a supercritical wing. Lear initially planned that the LearStar would be a trijet, but the design had evolved to become a twin by the time Canadair purchased the rights.

As the CL-600 Challenger, Canadair launched development of the LearStar design on October 29 1976 with 53 firm orders. Canadair made a small number of changes to the design including repositioning the horizontal tailplane to the top of the fin rather than on the fuselage.

Three development Challengers were built, the first of which flew for the first time on November 8 1978, the others flying in March and July the following year. However the first aircraft crashed in a deep stall accident and while certification was granted in August 1980, temporary restrictions limited maximum takeoff weight to 14,970kg (33,000lb) and maximum speed to 587km/h (317kt), with flight into known icing conditions and the use of thrust reversers prohibited.

A major weight and drag reduction program pared back the Challenger''s weight, improving range. The addition of General Electric CF-34 turbofans as options to the Challenger 601 (described separately under Bombardier), further addressed performance shortfalls and overcame problems with the ALF-502 turbofan.

One version that failed to see the light of day was the Challenger 610E, which would have featured a fuselage stretch allowing seating for 24 passengers, but Canadair suspended development in 1981.

Production of the 600 ceased in 1983, having switched to the much improved 601.  ',' Canada ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Canadair CL-600 Challenger 601 & 604 ',70135770.0,'img/1227659-v40-6.jpg',' The Challenger 601 addressed the original CL-600 Challenger''s weight problems and replaced the troubled ALF-502 turbofans, creating a highly successful full size corporate jet.

Troubles with the Avco Lycoming powered Challenger 600 led Canadair (now a division of Bombardier) to develop a vastly improved variant in the form of the General Electric CF-34 powered Challenger 601. Another important change was the addition of winglets, which are also offered as a retrofit to earlier aircraft. The 601 first flew on April 10 1982 and for a time was offered alongside the 600. The 600 was dropped from the model line in 1983.

Subsequent development of the Challenger led to the 601-3A. First flying in 1987, this variant introduced an EFIS glass flightdeck and upgraded engines. Available from 1989, the 601-3R was an extended range model with higher weights (the range increase modifications can also be retrofitted to earlier 601-3As).

Further improvements to the basic design led to the Challenger 604. Improvements include an advanced Collins ProLine IV EFIS avionics system with colour displays, higher weights, CF-34-3B turbofans and increased fuel tankage. Many other minor changes were incorporated based on Bombardier''s experience with the Canadair Regional Jet. First flight with CF-34-3A engines was in September 1994, first flight with the CF-34-3B engines was on March 17 1995, with Transport Canada certification granted that September. First delivery was in January 1996.

 ',' Canada ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Canadair CL-600 Regional Jet CRJ-700 ',96347361.0,'img/0199166-v40-6.jpg',' Bombardier''s 70 seat Canadair CRJ-700 is the first significant development of its fast selling 50 seat Canadair Regional Jet series.

Definition and development work on the Series 700 commenced in 1995 when Bombardier began consultation with a 15 member airline advisory panel on what the airlines wanted in a 70 seat class regional jet. Prior to its January 1997 formal launch the Series 700 was dubbed the CRJ-X.

Construction of the first prototype Series 700 began in late 1998 and first flight took place in May 1999. The CRJ-700 entered service in February 2001 with French airline Brit Air.

Compared with the 50 seat CRJ Series 100/200, the Series 700 is stretched by 4.72m (15ft 6in) with plugs forward and aft of the wing, while the cabin is .02m (19ft 9in) longer, aided by moving the rear pressure bulkhead 1.29m (4ft 3in) aft. The cabin windows are raised by 12cm (5in), the cabin floor is lowered slightly and the ceiling raised to provide 1.90m (6ft 3in) headroom, and an underfloor baggage compartment under the forward fuselage is added. Other changes include relocating the APU to the rear fuselage and redesigned overhead stowage bins.

The wing too comes in for attention, with span increased by a 1.83m (6ft 0in) wing root plug, while the leading edge is extended and high lift devices added. The main undercarriage units are lengthened and fitted with new wheels, tyres and brakes.

Power is from two FADEC equipped General Electric CF-34-8C1 turbofans (which were selected in February 1995), while the flightdeck is based on that in the earlier CRJs and features six CRT displays presenting information from the Collins Pro Line 4 EFIS avionics suite.

Like other Bombardier aircraft, the CRJ Series 700 is the product of a joint manufacturing effort. Canadair manufactures the wing and flightdeck and is responsible for final assembly, Mitsubishi builds the aft fuselage, Shorts is responsible for the fuselage and engine nacelles Avcorp the tail, and Westland the tailcone.

 ',' Canada ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('CAP Aviation CAP-10/20/21/230/231/232 ',72913675.0,'img/0063519-v40-6.jpg',' The successful CAP series of aerobatic aircraft dates back to the Piel CP-30 Emeraude of the early 1960s.

Claude Piel designed the two seat Emeraude in France in the early 1960s for kit builders, but more than 200 were built in four different factories across Europe. The Emeraude first flew in 1962 and was built in basic 50kW (65hp) Continental A65 power CP-30 form and 65kW (90hp) Continental C90 CP-301 Super Emeraude form.

One of the companies to build the Emeraude was CAARP, a company owned by Auguste Mudry. CAARP used the basic Emeraude design as the basis for the CAP-10, which was a similar aircraft other than its 135kW (180hp) Lycoming IO-360 engine and stressing for aerobatic flight. The prototype CAP-10 first flew in August 1968. CAARP built 30 CAP-10s for the French air force before Mudry started production for civil orders in 1972 at his other aviation company, Avions Mudry.

The CAP-10 remains in production today in 10B form with an enlarged tail. The CAP-20 meanwhile was a single seat development with a 150kW (200hp) AIO-360 engine.

The updated CAP-21 replaced the CAP-20 in 1981. The CAP-21 combined the fuselage of the CAP-20 with an all new wing and new undercarriage, and forms the basis for the similar CAP-231, CAP-231EX (with a carbon fibre wing) and latest CAP-232.

Following Mudry''s bankruptcy in 1996, Akrotech Europe took over the CAP series in May 1997, and in January 1999 changed name to CAP Aviation.

 ',' France ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('British Aerospace Jetstream 41 ',67499267.0,'img/0869051-v40-6.jpg',' The Jetstream 41 is a stretched and modernised development of the 19 seat Jetstream 31, designed to compete in the 29 seat commuter airliner class alongside such types as the Brasilia, Dornier 328 and Saab 340.

The Jetstream 41 (or J41) is based on the J31, but features a 4.88m (16ft) fuselage stretch, consisting of a 2.51m (8ft 3in) plug forward of the wing and a 2.36m (7ft 9in) stretch rear. The increased span wing (with reworked ailerons and flaps) is mounted lower on the fuselage so that it does not carry through the fuselage and interrupt the interior cabin aisle, unlike on the Jetstream 31. Other airframe modifications included a new reprofiled six piece windscreen and extended wing root fairing with greater baggage capacity. More powerful AlliedSignal TPE331 turboprops, mounted in new nacelles with increased ground clearance, drive advanced five blade McCauley propellers. The flightdeck has modern EFIS glass displays.

Development work on the J41 was announced in mid 1989, resulting in the type''s first flight on September 25 1991. Three further aircraft were also used in the flight test program, with European JAA certification being awarded on November 23 1992. The first delivery occurred two days later on November 25.

From mid 1994, all aircraft delivered benefited from various payload and range performance improvements, resulting from uprated engines and a higher maximum takeoff weight.

The J41 was initially known as the BAe Jetstream 41, but BAe''s establishment of a separate Jetstream Aircraft division in mid 1993 saw the name simplified to just Jetstream 41. From January 1996 the J41 became part of the Aero International (Regional) stable, but in May 1997 BAe announced that it was terminating J41 production.

Field Aircraft of the UK and Pilatus of Switzerland were risk sharing partners, while Gulfstream was to build 200 wingsets.

 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Britten-Norman BN-2A Mk.3 Trislander ',20308102.0,'img/0154927-v40-6.jpg',' The three engined Trislander takes its inspiration from the configurations of trijets such as the L-1011 and DC-10 in its answer to the need for more power for a stretched version of the Islander (described separately).

Britten-Norman research showed that there existed sufficient market demand to warrant the development of a stretched Islander, and the company concluded that any stretched version would need to offer a 50% increase in internal capacity. The company''s novel approach to the need for more power was to add a third engine, rather than two engines of increased power output. A nose mounted engine in the fashion of the Ju-52 was considered, but due to the Islander''s nose configuration, BrittenNorman settled on mounting the engine on the vertical tail, resulting in the BN-2A Mk.3 Trislander.

The tail mounted engine involved significant modification to the tail and strengthening of the rear fuselage. Other changes over the Islander include a 2.29m (7ft 6in) fuselage stretch forward of the wing, new main landing gear and larger diameter wheels and tyres.

The first Trislander was in fact converted from the second Islander prototype, and it made the type''s first flight on September 11 1970. Early production Trislanders were also conversions of Islanders, while subsequent Trislanders were built on the same production line as the Islander. The first production Trislander flew on March 6 1971, certification was granted on May 14, and first deliveries to a customer occurred on June 29 that year.

Britten-Norman Trislander production ceased in 1982 after 73 were ordered (by which stage the company had been acquired by Pilatus). Plans to produce the Trislander in the USA as the TriCommutair by the International Aviation Corporation, and in Australia never came to fruition. However one of 12 kits built for the TriCommutair project was assembled in Guernsey in the UK and flew in March 1996.

 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Britten-Norman BN-2 Islander ',9867374.0,'img/0108594-v40-6.jpg',' The BN-2 Islander was Britten-Norman''s second original design, work on which began during 1963.

Developed as a Dragon Rapide replacement, the emphasis was on producing a rugged and durable aircraft that had good field performance, low operating costs and was easy to maintain. One unusual feature is that there is no centre aisle between seats in the main cabin, instead there are three doors along each side of the fuselage for passenger boarding. The prototype BN-2 Islander was powered by two 155kW (210hp) IO-360s and first flight was on June 13 1965.

The first production machines were powered by 195kW (260hp) IO-540s and were simply designated BN-2, the first flew in 1967. A small number were built before production switched to the BN-2A which introduced fairings to the main undercarriage legs, wing leading edge and flap droop, and an increased max takeoff weight. From 1970 the base A model was the BN-2A-6 and the BN-2A-7 had extended wingtips, while the BN-2A-2 and BN-2A-3 were powered by the 225kW (300hp) IO-540, the latter with the extended wingtips.

Appearing in 1972 were the 195kW (260hp) powered BN-2A-26 and extended wingtips BN-2A-27, and the 225kW (300hp) BN-2A-20 and extended wingtips BN-2A-21, all four models having higher weights. Further improvements came with the BN-2B range with higher weights, improved interior and instrument panel and shorter diameter props. The 26, 27, 20 and 21 variants were available as before. The 27 and 21 were later dropped while the BN-2B-20 and BN-2B-26 remain in production. The turboprop (Allison 250) powered BN-2T has been built since 1981.

In September1979 Britten-Norman became Pilatus Britten-Norman, in July 1998 it was renamed back to Britten-Norman, and from April 2000 it became B-N Group.

 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('British Aerospace Jetstream 31/Super 31 ',75248754.0,'img/0275891-v40-6.jpg',' The successful Jetstream 31 traces its ancestry to the Turboméca Astazou powered Handley Page HP-137 Jetstream 1.

The HP-137 was designed as early ago as 1965, and flew for the first time on August 18 1967. Initial Handley Page production aircraft were powered by 635kW (850hp) Astazou XIVs and named Jetstream 1 (36 built), but deliveries were delayed by excess weight and drag problems. To overcome these problems Handley Page developed the Jetstream 2 with more powerful 800kW (1073shp) Astazou XIVCs. However Handley Page ran into serious financial difficulties in the late 1960s (causing the US Air Force to cancel an order for 10 Garrett TPE331 powered C-10A Jetstreams [3Ms]) and it folded in 1969, bringing to an end development of the more powerful Jetstream 2 and plans to market a civil version of the 3M in the USA.

A few unfinished aircraft were completed by Terravia, and development of the Jetstream 2 resumed in 1970 as the Jetstream 200 under the control of the newly formed Jetstream Aircraft in collaboration with Scottish Aviation. Scottish Aviation later assumed overall responsibility for the Jetstream and built a number as navigation and multi-engine trainers for Britain''s military services as the Jetstream T1 and T2. Development continued after Scottish Aviation was merged into British Aerospace in 1977, and work on the Jetstream 31 (or J31) began in 1978. The first flight of the Garrett TPE331 powered Jetstream 31 (a converted HP-137) occurred on March 28 1980. The first production aircraft flew in March 1982, UK certification was granted in June 1982. In British Naval service the J31 is designated the Jetstream T3.

Subsequent development led to the Super 31, certificated in October 1988. The Super 31 (or unofficially J32) features uprated engines, higher weights and better performance. The last J31/J32 was built in 1993.

Since 1997 British Aerospace Asset Management has been offering for sale or lease the upgraded J32EP (Enhanced Performance). Its minor aerodynamic and drag improvements enhance payload range and hot and high performance.

 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Canadair CL-215 & 415 ',22483203.0,'img/0209218-v40-6.jpg',' The CL-215 was designed as a specialist firebomber, particularly suited to Canada and other heavily forested regions.

The resulting amphibious aircraft is powered by two Pratt & Whitney R-2800 radials, and is capable of scooping up 5455 litres (1200Imp gal/1440US gal) of water in 12 seconds from a water source. The CL-215 first flew on October 23 1967, and first delivery was to the French civil protection agency in June 1969. Production of batches of CL-215s continued through to 1990.

Originally the subsequent CL-215T was to be a simple turboprop powered development of the CL-215, and Canadair converted two aircraft in 1989 to act as development aircraft. The first of these flew on June 8 that year. Retrofit kits for CL-215s to the new standard are offered, but Canadair elected not to build new CL-215Ts, and instead developed the CL-415.

The primary improvement added to the CL-415 over the CL-215T is an EFIS avionics suite, while other improvements, some of which first appeared on the CL-215T, include winglets and finlets, higher weights and an increased capacity firebombing system. Like the CL-215 its principle mission is that of a firebomber, but various special mission (including SAR and maritime patrol) and transport configurations are available.

The first CL-415 flew in December 1993 and was delivered from April 1994. The new CL-415GR has higher operating weights.

 ',' Canada ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Cessna 150 & 152 ',27585094.0,'img/0144183-v40-6.jpg',' The introduction of the Cessna 150 marked Cessna''s return to the two seat trainer market after a six year absence and resulted in the most prolific and successful two seat trainer line in history.

Development of the original 150 began in the mid 1950s, resulting in a first flight in September 1957. This modern, all new aircraft followed the Cessna conventions then gaining favour of a strut braced high wing, all metal construction and tricycle undercarriage. Production began in September 1958.

What followed was a continuous process of product improvement, although throughout the 150 model life the Continental O-200A powerplant remained unchanged. One of the most significant model changes was the 150D of 1964 which introduced the wraparound rear window. Most versions were built in Standard, Commuter and Trainer forms with differing equipment levels, while licence production was undertaken in France by Reims and in Argentina by DINFIA. Aerobat versions were stressed for limited aerobatic work.

The 152 was a response to availability problems with 80/87 octane fuel, and used the 150''s fuselage coupled with a Lycoming O-235 running on 100 Octane. The 152 replaced the 150 from 1977 and remained in production until late 1985. It too was progressively updated, offered in A152 Aerobat form, and also built in France.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Canadair CL-44 & Yukon ',39841529.0,'img/0098983-v40-6.jpg',' The CL-44 can be seen as an enhanced Bristol  Britannia 300.
In mid 1950s the Royal Canadian Air Force has a requirement for a maritime patrol aircraft to replace their Lacanster aircraft serving in this role. What resulted was the CP-107 Argus. which was licence built on the base of the Bristol Britannia. The Argus differed from the Britannia in a number of significant respects - it was powered by Wright Turbo Compound radial engines (selected in place of turboprops to give better endurance and low speed performance at low altitude), and a redesigned unpressurised fuselage incorporating a weapons bay. With Canadair already producing the Argus, it was a relatively simple matter to offer a Britannia based design to meet an RCAF requirement for a transport to replace the aging DC-4M Northstar.

The transport became the CC-106 Yukon (or to Canadair, the CL-44-6). Twelve were built, featuring Rolls Royce Tyne turboprops, lengthened fuselage with two large conventional side freight doors. The wings and tail plane, landing gears and cockpit were kept mostly the same as on the Britannia. The first Yukon flew on November 15 1959. It also featured some extra military stuff which was not taken up on the civillian version. This included an APU, elektrik trimming, enhanced radar, transportable loading system etc.

Canadair then began to offer the Yukon to commercial customers and developed the CL-44D-4, which featured a hinged tail which considerably simplified loading. (Swingtail) Due to new FAA/CAA regulations on visibility requirements the Britannia type winshields were replaced by newer and bigger windshield originating from the Convair 880. The first CL-44D-4 flew on November 16 1960, and at that time the model was the largest and first commercial freighter in the world to offer a 30t turn around in less then 60 minutes. The CL-44 is the first modern aircarft specially built for the commercial freight market.

While all CL-44s in civil service have sooner or later been used as freighters, Loftleidir Icelandic Airline operated four CL-44Js plus a single CL-44D-4 in passenger configuration. The J, or  "Rolls Royce 400 JetProp", differed from the D-4s in that it featured a 4.62m (15ft 2in) fuselage stretch. It is the only aircraft to be redrawn from service, cut, stretched and put into service again. In late sixties the CL-44J was the largest passenger aircraft over the Atlantic ocean with 189 passengers. This was bigger then 707 and DC-8.

One CL-44 was converted by Conroy Aircraft in the US as a large volume freighter. Jack Conroy was hoping to get the lucratif contract to fly Rolls Royce engines for the Tristar. Instead Lockheed stretched their own L-100 and flew the engines themselves. The CL-44-O "Guppy" got a new voluminous cargo hold (similar to the Boeing 377ST Super Guppy conversions), and it flew after conversion for the first time on November 26 1969.

All military Yukons found their way into civil service in Africa and South America after retirement in 1973. In 2001 no J-model has survived. Only one Yukon is alive and six CL-44D-4 remain in poor condition. Most have been parked for years.

 ',' Canada ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('British Aerospace BAe-146 ',85535559.0,'img/0764839-v40-6.jpg',' The BAe-146 family, which includes the Avro RJ and the cancelled RJX (both described separately), is likely to remain Britain''s most succesful jet transport program, with 395 built.

In August 1973 the then Hawker Siddeley Aviation announced it was designing a short range quiet airliner powered by four small turbofans with British government financial aid. Under the designation HS-146, large scale development lasted just a few months before a worsening economic recession made the risk of the project seem unjustifiable. Development then continued on a limited scale, but it was not until July 1978 that the project was officially relaunched, by which time Hawker Siddeley had been absorbed into the newly created British Aerospace.

The resulting BAe-146-100 made its first flight on September 3 1981. Certification was granted in early 1983 with first deliveries following shortly afterwards in May 1983. A VIP version was offered as the "Statesman" which was ordered by the Royal Air Force as the BAe-146 CC2, the standard transport version being the BAe-146 C1. An air refuel receptacle equipped military version, the -100STA flew in prototype form only.

The BAe-146-200 is a stretch of the 146-100, and is essentially similar to its smaller stablemate, but has a 2.39m (7ft 8in) longer fuselage, features 35% greater underfloor cargo volume, has slightly different performance figures and heavier weights. The stretch consists of five extra fuselage frame pitches. The first BAe-146-200 made the type''s maiden flight on August 1 1982, while the UK Civil Aviation Authority awarded the 146-200s type certificate on February 4 the following year.

Versions of the 146-200 include the -200QT Quiet Trader freighter, which has been fairly succesful because of its low external noise footprint, and the -200QC (Quick Change) passenger or freight convertible.

The 146-300 is a further stretched derivative of the original short fuselage BAe-146-100, but unlike the midsize 200 series, was not developed until later in the 1980s. The first 146-300, an aerodynamic prototype based on the original prototype 146-100, flew for the first time on May 1 1987, with certification granted that September.

Like the 146-200, a freighter version of the 300 series is known as the 146-300QT Quiet Trader. The prototype -300 was converted to 146-301ARA configuration, an atmospheric research aircraft operated by the Facility for Airborne Atmospheric Measurements as a replacement for the previously operated Hercules W2.

The last of the original 146s were built in 1993, with the series succeeded by the Avro 146-RJ family, described separately.



 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('British Aerospace ATP ',27806110.0,'img/0935942-v40-6.jpg',' The largest twin turboprop powered western regional airliners currently in service, the ATP and Jetstream 61 trace their development history back to the British Aerospace 748.

The ATP and J61 are stretched developments of the 748, but they incorporate a great number of major and minor detail changes. The 748''s fuselage cross section and basic wing structure were retained, but otherwise the ATP and J61 are all new aircraft.

British Aerospace announced it was developing an advanced derivative of the 748 in March 1984. The BAe ATP, or Advanced TurboProp, first flew on August 6 1986, while the first production aircraft flew in February 1988. Certification was granted in March 1988 and the ATP entered airline service that May.

Compared to the 748 the ATP features a stretched fuselage taking maximum seating up to 72 passengers, while Pratt & Whitney Canada PW126 turboprops drive slow turning six blade propellers. Much of the systems and equipment was new or significantly improved. The flightdeck has EFIS instrumentation, while the cabin interior was thoroughly revised and modernised. The nose was reprofiled and some sweep back was added to the tail.

The further improved Jetstream 61 was marketed and built by the newly created BAe division of Jetstream Aircraft. Apart from the name change it introduced a number of minor technical changes including an interior based on the Jetstream 41 (including the innovative arm rests incorporated into the cabin walls for window seats), more powerful PW127D engines and increased operating weights giving higher speeds and longer range. The Jetstream 61 was available for delivery from 1994, but marketing efforts ceased when the AI(R) consortium was formed because it was a direct competitor to the now disbanded consortium''s far more successful ATR 72. Just four were completed.

Meanwhile the last three whitetail ATPs were not sold until late 1998 (two went to British World, one to SunAir of Scandinavia).





 International Directory of Civil Aircraft ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Brantly B2 & 305 ',6131860.0,'img/0073725-v40-6.jpg',' The Brantly B2 series of light helicopters first flew in the early 1950s and returned to production in the early 1990s, while the larger five seat 305 dates to the early 1970s. <p>The original B2 two seat light helicopter was designed and built by Mr N Brantly, and flew for the first time on February 21 1953. Certification was awarded in April 1959 allowing production deliveries to get underway soon after. The initial production B2 model featured a 135kW (180hp) VO360A1A flat four, the same basic powerplant that powered the B2 series through to the 1990s. The initial B2 was followed by the improved B2A with a redesigned cabin and the B2B, which became the definitive production model. <p>Brantly also developed a larger five seat Model 305 based on the B2, with a larger cabin and more powerful VO540 engine. The 305 first flew in January 1964 and was certificated in July the following year. <p>Brantly production ceased in the early 1970s after more than 400 B2s had been built. However production resumed in 1976 when the Hynes company acquired the design and production rights to what became the BrantlyHynes B2 and 305. <p>BrantlyHynes continued low rate manufacture of both models through to the mid 1980s when it too ceased production. Finally in 1989 James Kimura formed Brantly Helicopter Industries to build both models, and low rate production resumed for a time. By 1998 the Chinese backed Brantly International Inc had resumed low rate B2B production at Vernon, Texas. <p> ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Bombardier Learjet 45 ',49308911.0,'img/0067108-v40-6.jpg',' The new Bombardier Learjet 45 is Learjet''s latest entry into the medium size corporate jet market.

Bombardier owned Learjet announced it was developing the Model 45 at the US National Business Aircraft Association''s annual convention in Dallas in September 1992. First flight was on October 7 1995 (the 32nd anniversary of the original Lear 23), and, after some delays, US FAA certification was granted on September 22 1997. The first customer aircraft was delivered in January 1998

The 45 is of classic Learjet design and layout. However a number of key design changes were made early into the 45''s design life including a larger fin and rudder, extended engine pylons, smaller delta fins, full span elevators, and single piece flaps.

Larger than the Learjet 31 and smaller than the 60, Learjet states that the 45''s 1.50m (4.9ft) high and 1.55m (5.1ft) wide cabin will provide more head and shoulder room than any other aircraft in its class. The cabin is designed to accommodate double club seating, a galley and a full width aft rest room, while eight windows line each side of the cabin.

The flightdeck features a four screen (two primary flight displays and two multifunction displays) Honeywell Primus 1000 integrated avionics suite, while an APU is standard.

The 20 FADEC equipped version of the proven AlliedSignal TFE731 engine was developed in cooperation with Learjet for the 45 and incorporates 60 design changes to increase fuel economy and reduce operating and maintenance costs.

While Learjet retains overall 45 program leadership, and is responsible for the aircraft''s design, other Bombardier Group companies participate in Learjet 45 production. De Havilland Inc in Canada is responsible for wing construction, while Shorts of Northern Ireland in the UK builds the fuselage and empennage.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('British Aerospace Avro RJ70/85/100',31237942.0,'img/0758907-v40-6.jpg',' The Avro RJ series are upgraded developments of the BAe-146 family (see separate entry), and like the 146 was built in three fuselage length variants, the RJ70, RJ85 and RJ100.

In 1990 British Aerospace first offered the improved RJ70 and RJ80, both of which were based on the 146-100. They would have seated 70 and 80 passengers respectively, but these two designs matured in the Avro RJ70 (officially Avro 146-RJ70) with improved FADEC equipped LF-507 engines and digital avionics.

The 146-200 based Avro RJ85 was the first member of the new family to fly, on March 23 1992. The biggest member of the family, the 146-300 based RJ100, first flew on May 13 1992. The 146-100 based RJ70 was delivered from late 1993 but due to low customer interest, only 12 were sold.

RJ improvements over the 146 include more reliable and efficient FADEC equipped AlliedSignal (now Honeywell) LF-507 engines, new "Spaceliner" cabin interior and a digital flightdeck. Weight and drag savings were introduced in 1996.

The RJ100 was also offered as the RJ115 with extra emergency exits to seat 116 to 128 in a high density six abreast configuration. None were built however. The RJ was also offered as the Avro Business Jet, but also none of these were built.

The RJ series was originally manufactured and marketed by Avro International Aerospace, a separate British Aerospace company, so named as RJ production was undertaken at the former Avro factory near Manchester (most 146s were built at Hatfield). Subsequent plans for a partnership with Taiwan Aerospace, which would have seen the RJ series built in Taiwan fell through and Avro subsequently became part of AI(R) to handle marketing, sales and support of British Aerospace (Avro and Jetstream) and ATR commercial aircraft. However, AI(R) disbanded in mid 1998 and the Avro RJ range became again a  British Aerospace (later BAE Systems) product.

The last RJ was delivered in 2002. A modernised development became the Avro RJX, for which see the  separate entry.


 ',' United Kingdom ');

INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Bristol 170 Freighter',4255548.0,'img/0214043-v40-6.jpg',' Design of the Bristol Freighter began in 1944 in anticipation of demand for a rugged airliner and freighter once WW2 was over, plus potential military requirements.

Bristol''s Type 170 started out as a private venture design and was developed under the leadership of technical director L G Frise (who also designed the Frise aileron). Design features of the 170 include its slab sided fuselage, fixed taildragger undercarriage, clamshell style nose doors, raised flightdeck, and a relatively large wing of two spar construction with swept back leading edge and straight trailing edge. As originally proposed the 170 was to be powered by improved sleeve valve Bristol Perseus radials.

The 170 soon caught the British Air Staff''s attention which considered the design well suited for use in the India-Burma theatre carrying supplies and vehicles to jungle strips. Two prototypes were ordered with a slightly enlarged fuselage and more powerful Hercules 630 radials.

The 170 made its first flight from Filton on December 2 1945 and while it was too late to be ordered into production for military service in WW2 the type''s potential had been demonstrated. The second prototype, configured in 32 seat Wayfarer airliner form (without the nose freight doors) flew the following April. Civil certification was granted in June 1946.

Early production was of the Mk1 Freighter and Mk2 Wayfarer. The Mk11 (later the Mk21) was unveiled at the 1947 SBAC airshow and introduced rounded wingtips and more powerful Hercules 672 engines, allowing an increase in gross weight of 1360kg (3000lb). The Mk31 introduced more powerful engines and remained in production until 1950.

The final 170 model is the Mk32, developed at the request of Silver City Airways. The Mk32 featured a lengthened nose which allowed it to carry three cars, rather than two, in a car ferry configuration.

The last flight of a Bristol 170 was made on September 6 2004, when Hawkair Aviation ferried C-GYQS to the Reynolds Alberta Museum in Wetaskiwin, Alberta, Canada.

 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Bombardier Learjet 55 & 60',4848132.0,'img/0079596-v40-6.jpg',' The Learjet 55 and its followon successor, the Learjet 60, are the largest members of the Learjet family, and date back to development work undertaken in the late 1970s.

In designing the 55, Learjet (or Gates Learjet as the company was then known as) took the wing of the earlier Longhorn 28/29 series and married it to an all new larger 10 seat fuselage. The original Model 55 Longhorn prototype first flew on November 15 1979. The first production aircraft meanwhile flew on August 11 1980, with the first delivered in late April 1981 (after FAA certification was granted in March that year).

Development of the 55 led to a number of sub variants, including the 55B which introduced a digital flightdeck, modified wings, improved interior, and most importantly, the previous optional higher takeoff weights becoming standard. The 55C introduced `Delta Fins'' which gave a number of performance and handling advantages, the 55C/ER is an extended range version with additional fuel in the tail cone (the additional tank can be retrofitted to earlier aircraft), while the 55C/LR introduced more fuel capacity.

The improved Learjet 60 first flew in its basic definitive form in June 1991 (the modified Learjet 55 prototype earlier served as a proof of concept aircraft for the 60 with Garrett engines). It differs from the 55 in having a .09m (43in) fuselage stretch and new Pratt & Whitney Canada PW305 turbofans. Certification of the 60 was awarded in January 1993, with first deliveries following shortly afterwards.





 International Directory of Civil Aircraft



 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Bombardier BD-100 Challenger 300',1021174.0,'img/0240845-v40-6.jpg',' Bombardier''s all new Challenger 300 is a transcontinental range eight-seat corporate jet which will sit in the company''s model line-up between the Learjet 60 and Challenger 604. It is developed for a non-stop 5471km (3100nm) mission with a load of eight passengers and NBAA IFR reserves.

Bombardier revealed it was developing the Continental (as it was known then) at the 1998 National Business Aircraft Association''s annual convention in Las Vegas in October 1998. The program was officially launched at the Paris Air Show on June 13, 1999. It would compete for what Bombardier sees as a market for 1230 super mid size corporate jets by 2012. The Continental was renamed Challenger 300 on September 9, 2002.

The new jet will compete with the Hawker Horizon and Galaxy, among others. Bombardier claims the Continental will offer 39% more cabin space and 20% more range "than the leading mid size business jet". It is also claimed to have a larger cabin than the intercontinental range Falcon 50 and high speed Citation X.

Features of the Challenger 300 are a cockpit equipped with Collins Pro Line 21 four-tube EFIS, EICAS, TCASII, and EGPWS avionics, a standard eight place double club interior with galley and toilet, stand-up headroom, a flat floor, an auxiliary power unit and thrust reversers, all metal construction and a large area wing for good field performance.

The Challenger 300 has a primarily light-alloy structure, with composites used for some non-structural items. The fuselage is of a semi-monocoque construction with frames and stringers. The wing has two spars.

The first Continental risk sharing partner is AlliedSignal, which will supply its new FADEC equipped AS-907 turbofan to power the new jet, as well as the engine nacelles and thrust reversers. The AS-907 itself is developed with a number of partner companies, with AIDC of Taiwan selected to provide the fan.

Wing/fuselage mating of the first aircraft was achieved on November 19, 2000. The first flight was made on August 14, 2001, and certification is due in the third quarter of 2002. The aircraft will start corporate service in 2003.

The Challenger 300 made its official debut at Orlando Executive Airport on September 8, 2002 at the NBAA Convention. At that time, four aircraft were flying in the test program.

 ',' Canada ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing C-97 Stratofreighter',42566996.0,'img/0235844-v40-6.jpg',' Boeing''s Stratofreighter formed the backbone of the US Air Force''s Military Airlift Transport Service (MATS) during the early 1950s, and more than 800 were built for use as freighters and air-to-air refuellers.

The Model 367 Stratofreighter is based on the Boeing B-29 Superfortress, the Allies'' most technologically advanced bomber to see service in World War 2, and an aircraft famous (or infamous) for dropping the only atomic bombs used operationally in warfare on Japan in the closing stages of that conflict. The B-29 flew for the first time in September 1942 by which time Boeing had already studied a transport version, utilising the B-29''s wing, engines, tail and lower fuselage, combined with a new upper fuselage section. The new double lobe fuselage shape was very distinctive, and also formed the basis for future Boeing jet airliner fuselage cross sections.

The US Army Air Force was impressed with Boeing''s proposals and ordered three prototypes be built, the first of which flew on November 15 1944. Ten development YC-97s were subsequently ordered, the last of which represented production aircraft, featuring the more powerful R-4360 engines and taller tail developed for the B-50, an improved B-29. The first production C-97A was delivered in October 1949.

Development of the C-97 led to the C-97C, which was used for casualty evacuation, and the KC-97E, KC-97F and KC-97G aerial tankers. More than 590 KC-97Gs were built. The KC-97 was the US Air Force''s primary tanker until replaced by the jet powered KC-135, the predecessor to the Boeing 707. Small numbers of 377 Stratocruiser airliners were also built, but the last of these have long been retired.

Many Stratofreighters survived their military service to be acquired by civilian operators for use as freighters and fire bombers. Only two were still airworthy in 2002, one of them operated by the Berlin Airlift Historical Foundation and the other as a firefighter by Hawkins & Powers.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing Stearman',71199257.0,'img/0093521-v40-6.jpg',' The Boeing Stearman is perhaps the most widely known and recognised biplane in the USA, as it was that country''s primary basic trainer throughout World War 2.

This famous biplane began life as a design of the Stearman Division of United Aircraft (at that time United Aircraft also owned Boeing and United Airlines), which Boeing acquired as a wholly owned subsidiary in 1934. At the time of the takeover development on the X-70 training biplane was well advanced, and Stearman continued work on the type under Boeing ownership. The prototype of the Stearman Model 75, as the X70 became, flew for the first time in 1936. That year Stearman delivered the first production Model 35s, as the PT13, to the US Army Air Corps. That service immediately found the Lycoming R680 powered PT13 to be an ideal basic trainer, the airframe was rugged and forgiving, and the slow turning radial engine reliable and reasonably economical.

America''s entry into World War 2 brought with it massive requirements for pilot training and the US Army and Navy went on to buy thousands of PT13s and Continental engined PT17s and N2Ss. During the war almost all American pilots undertook basic training on the PT13 or PT17, and the type was exported to Canada (as the Kaydet), Britain and other nations. Apart from in Canada the Kaydet name was unofficially widely adopted for the type.

Postwar, the Stearman''s rugged construction and good low speed handling saw large numbers converted for agricultural spraying work. Many conversions involved replacing the Stearman''s fabric covering with metal (to avoid problems with chemical contamination), while many were fitted with more powerful 335kW (450hp) P&W R985A61 radials.

Today many hundred Stearmans are still flown in private hands, although its crop spraying days are mostly over.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Boeing Vertol (Kawasaki) KV 107',82957685.0,' Boeing Vertol''s Model 107 is best known as the military CH46 Sea Knight, but small numbers were built as airliners and utility transports for commercial customers. <p>The then independent Vertol company (previously Piasecki) designed the 107 in the late 1950s as a medium lift helicopter for US Army evaluation. Three prototype Lycoming turboshaft powered Vertol 107s were built (the Army ordered 10) designated YHC1As, and first flight occurred on August 27 1958. By that time though the Army''s interest had switched to what would become the Chinook and it placed no orders. However in February 1961 Vertol (Boeing acquired Vertol in 1960) won a US Marine Corps competition with a developed General Electric T58GE8 powered version of the BV 107, and the type was ordered into production as the CH46A Sea Knight. <p>The commercial 107 is based on the CH46A powered by the civilianised CT58110 (equivalent to the T58GE8). The first commercial 107 to fly was one of the three original development aircraft built for the US Army converted to the new standard, its first flight in the new configuration was on October 25 1960. Offered in two forms, the KV 107/II1 utility transport and KV 107/II2 airliner, only the latter was built. KV 107/II2 customers included New York Airlines, who ordered three configured to seat 25, Columbia Helicopters in the US (Columbia still operates KV 107s) and Japan''s Air Lift. A more powerful 1045kW (1400shp) CT581401 powered longer range KV 107/IIA17 was offered and one was built for the Tokyo Police. <p>Japan''s Kawasaki built all commercial 107s, and has held manufacturing rights to the 107 since 1965. Kawasaki has also built KV 107s for the Japanese military and Saudi Arabia. <p> ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing MD Explorer',47084815.0,'img/0113735-v40-6.jpg',' Developed by McDonnell Douglas, the Boeing MD Explorer light twin helicopter is the first all new design to incorporate the unique NOTAR (NO TAil Rotor) system. <p>McDonnell Douglas Helicopters launched the Explorer as the MDX in January 1989. First flight took place on December 18 1992. Full certification for the initial PW206B powered MD 900 version was granted in December 1994. <p>One of the most advanced helicopters in its market segment, the MD Explorer features Boeing''s unique NOTAR anti torque system (described in detail under the MD 520N entry), with benefits including increased safety, far lower noise levels and performance and controllability enhancements. <p>The design also features an advanced bearingless five blade main rotor with composite blades, plus a carbonfibre fuselage and tail. Initial aircraft are powered by two Pratt & Whitney Canada PW206Bs (the Explorer was the first application for the PW200 series). <p>The improved Explorer 902 replaced the MD 900 in September 1997. Features of the MD 902 include PW206E engines with higher one engine inoperative ratings, revised engine air inlets, improved NOTAR inlet design and a more powerful stabiliser control system. Benefits include improved range and endurance and an increased max takeoff weight. <p>On August 31 1998 the 902 configured Explorer became the first helicopter to be validated by Europe''s JAA JAR Part 27 Category A guidelines, which requires helicopters be capable of safely continuing flight during takeoff or landing on a single engine. <p>Like the MD 520N and MD 600N singles the MD Explorer line is for sale. In 1998 US regulatory authorities prohibited a planned sale of all three lines to Bell. Belgian company HeliFly has expressed an interest. <p> ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 787-8 Dreamliner',40993712.0,'img/1999379-v40-6.jpg',' The Boeing 7E7 was announced on 29th January 2003 following the cancellation of the Sonic Cruiser. The aircraft was renamed the Boeing 787 in 2005.

This important design marked a major shift in technology for Boeing, which aimed for maximum fuel efficiency in a number of ways. Chief among these was a radical change of construction material, with much of the aircraft being built of carbon fibre reinforced plastic (CFRP). Additionally, the fuselage was produced as ''barrels'' rather than sheets of material, reducing the number of fastenings required. This further increased the weight savings. Many of the aircraft''s systems are now electrically operated, replacing the heavier hydraulic systems of earlier Boeing designs with lighter technology.

The engines are new designs with increased fuel efficiency. Both the General Electric GEnx and Rolls-Royce Trent 1000 designs are available. Boeing decided to use bleedless designs, another major change for aircraft of this class. Interestingly, Airbus decided not to use bleedless technology on its competing Airbus A350 design and it remains to be seen which approach offers the greatest benefits over the other. The rear engine nacelle has a distinctive rippled look which reduces noise as the engine exhaust and external air mix.

For passengers, there have been a number of technology improvements. Most noticeably, the windows are amongst the largest in a civil airliner and are lower on the fuselage than is usual, so that passengers have a better view downwards. The lighting system use LED technology allowing each customer great flexibility on the lighting schemes it can use. The pressurisation system features a lower cabin altitude than normal and allows increased humidity, both factors which will contribute to passenger comfort during a long flight.

With all these technology advances and a distributed manufacturing program that was very new to Boeing, it is not suprising that the program encountered a number of delays. However, the first aircraft was delivered to a customer, All Nippon Airways, in September 2011.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing Commercial Chinook',28846030.0,'img/0070594-v40-6.jpg',' The Boeing Helicopters Model 234 Commercial Chinook is, as its name suggests, a commercial variant of the successful CH47 Chinook military airlifter. <p>The Chinook was developed for the US Army and first flew in September 1961, and since then has been developed into a number of progressively improved variants. The Commercial Chinook was not launched until 1978, following a British Airways Helicopters order for three for North Sea oil rig support missions. The Commercial Chinook''s first flight occurred on August 19 1980, certification was granted in June 1981, and service entry was the following month. <p>Largely identical in configuration to the CH47, the Commercial Chinook retains the former''s rear cargo ramp, but has a slightly reprofiled nose, commercial avionics and large passenger windows along both sides of the main cabin. <p>The initial orders were for the 234 LR Long Range, which compared with the CH47 has roughly twice the fuel load, plus a 44 seat passenger interior based on that used in Boeing jetliners. A number of other versions were offered - the 234 ER Extended Range with additional tankage, the 234 UT Utility, and 234 MLR Multi purpose Long Range which can be used for passenger or freight operations, or a combination of both. <p> ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 767-400',42946104.0,'img/0116088-v40-6.jpg',' Boeing''s 767-400ER is a stretched development of the popular 767-300ER, designed to replace early A300, A310 and 767 twins used on transcontinental services and DC-10-30s and L-1011 trijets used for intercontinental work. It competes with the A330-200.

Design work on the then 767-400ERX began in late 1996 when Boeing signed a technical assistance agreement covering the program with the then independent Douglas Aircraft Company division of McDonnell Douglas. At the time Boeing suffered from a shortage of engineering talent with a number of other key programs underway while Douglas had surplus engineering capacity following the cancellation of the MD-XX (Boeing and McDonnell Douglas subsequently merged in August 1997). The program was formally launched as the 767-400ER in January 1997 when Delta Airlines ordered 21.

The most significant change with the 767-300 is the 6.4m (21ft) fuselage stretch, which increases typical three class seating capacity from 218 to 245. Because of the increased fuselage length the -400 features all new, 46cm (18in) taller landing gear to restore rotation angles for acceptable takeoff and landing speeds and distances which would otherwise have been adversely affected by the fuselage stretch. The wheels, tyres and brakes are common with the 777.

Compared to the 767-300, the 767-400ER''s wing features 2.34m (7ft 8in) long raked wingtips which improve aerodynamic efficiency. Winglets were originally considered but the wingtip extensions proved more efficient. The wing is also made from increased gauge aluminium with thicker spars.

Inside, the 767-400ER features a 777 style advanced flightdeck with six colour multifunction displays, which can present information in the same format as earlier 767s, allowing a common type certificate, or as for the 777 and Next Generation 737s. The all new passenger interior is similar to that in the 777.

Other features include common engines with the 767-300, a new APU, new tailskid and increased weights.

The first flight was made 9 October 1999. Four aircraft took part in the development program.

Delta Airlines was the launch customer, and, as of December 2001, the aircraft was also ordered by Continental Airlines and Kenya Airways. ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 777-300',42956094.0,'img/0158648-v40-6.jpg',' Boeing''s 777-300 is powered by the world''s most powerful turbofan engines.

The stretched 777-300 is designed as a replacement for early generation 747s (747-100s and 200s). Compared to the older 747s the stretched 777 has comparable passenger capacity and range, but burns one third less fuel and features 40% lower maintenance costs.

Compared with the baseline 777-200 the 300 features a 10.13m (33ft 3in) stretch, comprising plugs fore and aft of the wings. The longer fuselage allows seating for up to 550 passengers in a single class high density configuration. To cope with the stretch and the up to 13 tonne (28,600lb) increased max takeoff weight the 300 features a strengthened undercarriage, airframe and inboard wing. Other changes compared with the 777-200 include a tailskid and ground manoeuvring cameras mounted on the horizontal tail and underneath the forward fuselage. Otherwise changes have been kept to a minimum to maximise commonality.

Boeing publicly announced it was developing the 777-300 at the Paris Airshow in mid June 1995 where it revealed it had secured 31 firm orders from All Nippon, Cathay Pacific, Korean Airlines and Thai Airways. Later that month Boeing''s board authorised production of the new aircraft.

The 777-300 rolled out on September 8 1997, followed by first flight on October 16 that year. The type made history on May 4 1998 when it was awarded type certification simultaneously from the US FAA and European JAA and was granted 180min ETOPS approval. Service entry with Cathay Pacific was later in that month.

Like the 777-200, a 777-300ER long range version has been developed. Changes made to the 777-300ER are more powerful General Electric GE90-115B engines (currently the world''s most powerful jet engine), raked wingtips, strengthened body, wings, empennage, nose gear, engine struts and nacelles, new main landing gear, and provision for extra fuel tanks. The range, carrying 365 passengers, is increased up to 13,427km (7,250nm).

Roll-out of the first 777-300ER was made on November 14 2002, followed by the first flight on February 24 2003. First delivery, to Air France, is scheduled for March 2004.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 767-200 ',42946084.0,'img/0089938-v40-6.jpg',' The narrowest widebody in service, the 767 started life as an advanced technology mid to large size airliner in the late 1970s.

Launched in July 1978, the 767 was developed in tandem with the narrowbody 757 with which it shares a common two crew EFIS flightdeck (with six colour CRT displays) and many systems. The 767 also features a unique width fuselage typically seating seven abreast in economy, and a new wing design with greater sweepback (compared to the 757) which was designed with high altitude cruise in mind.

The 767 program also features a high degree of international participation, with Japanese companies in particular having a large share of construction.

Initially Boeing intended to offer two versions, the longer 767-200 and short fuselage 767100 (which was not launched as it was too close in capacity to the 757). The 767 first flew on September 26 1981, and entered service (with United) on September 26 1982 (certification with P&W engines was awarded on July 30 1982).

The longer range 767-200ER (Extended Range) version features higher weights and an additional wing centre section fuel tank. It first flew on March 6 1984, and service entry, with Ethiopian Airlines, was two months later. The 200ER accounts for 111 of the total 239 767-200s ordered.

The last airliner 767-200/-200ER was delivered in 1994 until a November 1998 order from Continental. These had all been delivered by 2002, but military orders for 767 tankers will keep the -200 in production.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 777-200',42956084.0,'img/0237637-v40-6.jpg',' Boeing''s advanced widebody 777 twin incorporates more advanced technologies than any other previous Boeing airliner, and has been progressively developed into increasingly longer range developments.

The 777 was originally conceived as a stretched 767, but Boeing instead adopted an all new design. Notable 777 design features include a unique fuselage cross section, Boeing''s first application of fly-by-wire, an advanced technology glass flightdeck with five liquid crystal displays, comparatively large scale use of composites (10% by weight), and advanced and extremely powerful engines. The 777 was also offered with optional folding wings where the outer 6m/21ft of each would fold upwards for operations at space restricted airports.

The basic 777-200 as launched in October 1990 was offered in two versions, the basic 777-200 (initially A-Market) and the increased weight longer range 777-200IGW (Increased Gross Weight, initially B-Market). The IGW has since been redesignated 777-200ER.

The 777-200 first flew on June 12 1994, with FAA and JAA certification awarded on April 19 1995. The FAA awarded full 180 minutes ETOPS clearance for PW4074 -200s on May 30 that year. First customer delivery was to United Airlines in May 1995. The first 777-200IGW/ER was delivered to British Airways in February 1997.

The 777-100X was a proposed shortened ultra long range (16,000km/8635nm) model, dropped in favour of the 777-200LR (originally 777-200X) design study. Boeing claims the 777-200LR will be the longest ranging airliner, capable of flying 16,417km (8865nm) - 18 hours flying time. It will achieve this with awesomely powerful 489kN (110,000lb) thrust GE90-110B1 turbofans, a significantly increased max takeoff weight and optional auxiliary fuel tanks in the rear cargo hold. Other changes include 2m (6.5ft) raked wingtips, new main landing gear, structural strengthening and optional overhead crew and flight attendant rest stations above the cabin. The 777-200LR was launched in 2000, but is now delayed until 2006.

The stretched 777-300 is described separately.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing B-17 Flying Fortress',92983201.0,'img/0241885-v40-6.jpg',' The Fortress was originally designed to meet a bomber specification issued by the U.S. Army Air Corps in 1934. The prototype, Boeing Model 299, first flew on July 28, 1935 and the first Y1B-17 of a production order of thirteen was delivered to the Air Corps in March, 1937. In January, 1939 an experimental Y1B-17A fitted with turbo-supercharged engines was delivered to the Army Air Corps. Following successful trials with this aircraft an order for 39 was placed for this model under the designation B-17B.

The B-17G was introduced onto the Fortress production line in July of 1943, and was destined to be produced in larger numbers than any other Fortress variant. The most readily-noticeable innovation introduced by the B-17G was the power-operated Bendix turret mounted in a chin-type installation underneath the nose. This turret was equipped with two 0.50-inch machine guns. This installation had first been tested in combat by the YB-40 and was found to be the only viable innovation introduced by the unsuccessful escort Fortress. Another innovation introduced by the G was having the waist guns being permanently enclosed behind windows instead of being mounted behind removable hatches. This made the rear fuselage somewhat less drafty. The cheek nose guns introduced on the late B-17F were retained, but were staggered so that the left gun was in the forward side window and the right gun was in the middle side window, which reversed the positions used on the late Fs. The cheek gun mounts bulged somewhat outward into the airstream, which helped to improve the forward view from the cheek gun positions. The forward chin installation and the associated cheek guns were first tested out on B-17F-115-BO 42-30631. Originally, the Bendix turret was to be introduced on the Boeing production line with F-135, but the changes were sufficient to justify a new series letter, and the F-135s became G-1.

The B-17G now had the defensive firepower of no less than thirteen 0.50-inch machine guns: two chin guns, two cheek guns, two guns in the dorsal turret, two guns in the ventral turret, two guns in the waist, two guns in the tail and one gun in the roof of the radio operator''s position. B-17Gs were built by all three members of the "B.V.D." production pool, with the Boeing lots ranging from production blocks G-1 to G-110, the Douglas blocks ranging from -5 to -95, and the Lockheed-Vega blocks ranging from -1 to -110.

The B-17G entered service with the Eighth and Fifteenth Air Forces in late 1943. Camouflage paint was deleted from production B-17Gs starting in January of 1944. B-17Gs were delivered in natural metal finish starting in (but not at the beginning) of production blocks G-35-BO (Boeing), G-20-VE (Lockheed-Vega), and G-35-DL (Douglas-Long Beach). The so-called "Cheyenne" tail gun mounting modifications were incorporated in the B-17G-80-BO, -45-DL, -35-VE and subsequent batches. These tail gun mountings also had a reflector gunsight instead of the previous ring and bead. With this installation, these B-17Gs were five inches shorter than the earlier versions. On later production versions, it was found necessary to stagger the waist gun positions so that the two gunners would not get in each other''s way. On the last production batches (B-17G-105 and -110-BO, B-17G-75 to -85-DL, and B-17G-85 to -110-VE), the radio compartment gun was not installed. The ammunition capacity of the waist guns was increased to 600 rpg. When production terminated in 1945, a total of 4035 B-17Gs had been built by Boeing, 2395 by Douglas and 2250 by Lockheed-Vega. The last Boeing-built B-17G was delivered on April 13, 1945. B-17G-1-VE 42-38940 was redesignated XB-17G when assigned to test work. It was not a prototype.
   ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 757-300',42936094.0,'img/0245961-v40-6.jpg',' The stretched, 240 seat Boeing 757-300 is the first significant development of the basic 757-200 and is aimed primarily at the European vacation charter market.

Although design work on the original 757 began in the late 1970s and its entry into service was in 1983, it wasn''t until over a decade later in the mid 1990s that Boeing began to study a stretched development of its popular narrowbody twin. This new 757 stretch was covered by the 757-300X designation until its launch at the Farnborough Airshow in England in September 1996.

The most obvious change over the 757-200 is the 300''s 54.43m (178ft 7in) long fuselage, which is 7.11m (23ft 4in) longer than the standard aircraft (and only fractionally shorter than the 767-300). This fuselage stretch allows a 20% increase in seating to 225 to 279 passengers, depending on the interior configuration. Lower hold freight capacity is also increased by 40% over the 757-200 by virtue of the longer fuselage.

Another feature of the 757-300 is its new interior which is based on that developed for the Next Generation 737 models. Features include a new sculptured ceiling, larger overhead bins, indirect overhead lighting and vacuum toilets.

The 757-300 shares the 200''s cockpit, wing, tail and powerplant options, although the 300 will feature strengthened structure and landing gear to cope with the increased weights, new wheels, tyres and brakes and a tailskid.

The 757-300 first flew on August 2 1998, with certification in January 1999, and entry into service (with launch customer Condor - the charter arm of German flag carrier Lufthansa) in March 1999. The -300''s 27 month development program from final configuration to planned first delivery is the fastest for any Boeing airliner (the 777-300 took 31 months for example). Other early customers are Icelandair, Arkia, Northwest, American Trans Air, Continental, and JMC Air.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 747SP',42674722.0,'img/0667602-v40-6.jpg',' Boeing developed the 747SP in the mid 1970s as a longer range, shortened 747, trading passenger seating for extra range. The 747SP is the only 747 model to feature a changed fuselage length compared with the 747-100.

The 747SP first flew on July 4 1975, certification was awarded on February 4 1976 and first delivery (to Pan American) was in March 1976.

The 747SP''s fuselage is shortened by 14.35m (47ft 1in) compared to other 747 models, while the vertical tail was increased in height to compensate for the reduced moment arm with the shorter fuselage. Structurally the 747SP was lightened in some areas because of the significant reduction in gross weights. Overall though the 747SP retained 90% commonality of components with the 747-100 and 200. While shortening the 747''s fuselage increased the fuel fraction and thus range, it also meant that seating capacity was reduced.

The SP suffix in 747SP stands for Special Performance, and points to the ultra long range abilities of this 747 variant that preceded the later 747-400 by 15 years. The 747SP''s range is best illustrated by the spate of long range distance records it set in the mid 1970s. The most prominent of those was the delivery flight of a South African Airways SP, which over March 23/24 1976 flew nonstop with 50 passengers from Paine Field in Washington State to Cape Town, South Africa, a distance of 16,560km (8940nm). This world nonstop record for a commercial aircraft stood until 1989 when a Qantas 747-400 flew 17,945km (9688mn) nonstop from London to Sydney.

Sales of the 747SP were modest despite the increased range, as the SP had poorer operating economics per seat compared to the 747-200. However the 747SP did pioneer a number of long range nonstop services that are now commonly flown by the 747-400.

Notable SP customers included South African Airways (who found the SP''s extended range a great asset in bypassing African nations that denied it landing rights while South Africa''s apartheid policies were in place), Qantas and PanAm, the latter pioneering nonstop trans Pacific Los Angeles/Sydney services.

In early 2005 less than twenty SPs remain in airline or corporate service.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 747-300',42926094.0,'img/0112575-v40-6.jpg',' Boeing''s 747-300 model introduced the distinctive stretched upper deck which can seat up to 69 economy class passengers.

The 747-300 was the end result of a number of Boeing studies which looked at increasing the aircraft''s seating capacity. Ideas studied included fuselage plugs fore and aft of the wing increasing seating to around 600, or running the upper deck down the entire length of the fuselage. In the end Boeing launched the more modest 747SUD (Stretched Upper Deck) with greater upper deck seating on June 12 1980.

The 747SUD designation was soon changed to 747EUD (for Extended Upper Deck), and then 747-300. The new model first flew on October 5 1982 and was first delivered to Swissair on March 28 1983. Other customers included UTA, Saudia, SIA, Qantas and Cathay.

Compared to the -200, the -300''s upper deck is stretched aft by 7.11m (23ft 4in), increasing economy class seating from 32 to a maximum of 69. The lengthened upper deck introduced two new emergency exit doors and allows an optional flightcrew rest area immediately aft of the flightdeck to be fitted. Access is via a conventional rather than spiral staircase as on the earlier models.

Otherwise the 747-300 is essentially little changed from the 747-200 and features the same takeoff weight and engine options. 747-300 variants include the 747-300M Combi and the short range 747-300SR built for Japan Air Lines for domestic Japanese services.

The extended upper deck was also offered as a retrofit to existing 747-100/-200s, although the only airlines to take up this option were KLM and UTA. KLM has since converted two to freighters, resulting in the first 747 freighters with the stretched upper deck. Also, two JAL 747-100s were delivered new with the extended upper deck.



 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 737-800/900',26572292.0,'img/0294569-v40-6.jpg',' Boeing''s Next Generation 737-800 and 737-900 are the largest members of the strong selling 737 family. Unlike the other Next Generation 737s, the -800 and -900 introduce new fuselage lengths, extending 737 single class seating range out to 189, compared with 100 in the original 737-100.

Like the -600 and -700, the -800 and -900 feature the Next Generation improvements including more efficient CFM56-7B turbofans, the new wing with greater chord, span and wing area, larger tail surfaces and the 777 style EFIS flightdeck with six flat panel LCDs which can present information as on the 777 or as on the 737-300/400/500 series, the latter allowing a common pilot type rating for the two 737 families. A HUD is optional. BBJ style winglets are offered as an optional feature for the -800.

Until its launch on September 5, 1994 the 737-800 was known as the 737-400X Stretch. Compared with the -400 the -800 is .02m (9ft 9in) longer, taking typical two class seating from 146 to 162, while range is significantly increased. The -800 has sold strongly since its launch, and early 2002 was the highest selling Next Generation model. First flight was on July 31 1997, first delivery (to Hapag Lloyd) was in April 1998.

The largest single order for the -800 series has come from the Irish budget carrier, Ryanair. After 28 had already been ordered earlier, a firm order for 100 aircraft was made in January 2002, with an option of another 50, to be delivered over the next 8 years. Ryanair will use the aircraft in a single class configuration, to seat 189 passengers

A variant of the 737-800 is the Boeing Business Jet 2 (BBJ2), which is described separately.

The 737-900 is the largest and latest member of the 737 family, and was launched on September 10, 1997 with an order for 10 from Alaska Airlines. A 1.57m (5ft 2in) plug forward of the wing and a .07m (3ft 6in) plug rear compared with the -800 increases seating to 177 in two classes (maximum seating is the same as the 737-800''s due to emergency exit requirements). First flight was made August 3, 2000, and the first delivery (to Alaska Airlines) May 15, 2001.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 747-400',42926104.0,'img/0064022-v40-6.jpg',' The 747-400 is the latest, longest ranging and best selling model of the 747 family.

Boeing launched the 747-400 in October 1985 and the first development aircraft first flew on April 29 1988. US certification (with PW-4000s) was awarded in January 1989.

The 747-400 externally resembles the -300, but it is a significantly improved aircraft. Changes include a new, two crew digital flightdeck with six large CRT displays, an increased span wing with winglets (the -400 was the first airliner to introduce winglets), new engines, recontoured wing/fuselage fairing, a new interior, lower basic but increased max takeoff weights, and greater range.

Apart from the basic passenger 747-400 model, a number of variants have been offered including the winglet-less 747-400 Domestic optimised for Japanese short haul domestic sectors, the 747-400M Combi passenger/freight model, and the 747-400F Freighter (which combines the 747-200F''s fuselage with the -400''s wing).

The latest model is the 747-400ER, which was launched on November 28, 2000 when Qantas placed an order for 6. The -400ER has the same size as the -400, but has more range or payload capability. The MTOW was increased by 15,870kg (35,000lb) to 412,770kg (910,000lb), giving a further range of 805km (435nm) or a 6800kg (15,000lb) greater payload. The -400ER also features a wholly new cabin interior with larger luggage bins, and several flight deck improvements.

The -400ER incorporates the strengthened wing, body, and landing gear of the -400F, plus an auxiliary fuel tank in the forward cargo hold, and an optional second one. Operators who don''t need these can remove them both, gaining additional cargo volume.

The first 747-400ER was rolled out in June 2002, and flew for the first time on July 31, 2002, and this was the 1308th 747 to fly.

A cargo version, the 747-400ERF, followed the standard -400ER, and was launched April 30, 2001 on an order by leasing company ILFC for 5. The first -400ERF is the 1315th 747 built. The -ERF has the same MTOW as the -ER, and this will give an extra range of 970km (525nm), or an extra payload of 9980kg (22,000lb) at MTOW compared with the standard -400F.

Shortly before delivery of the first -400ER, Boeing had received orders for 15 ER/ERFs from 5 customers.

Various growth 747 models have been studied. The 747-500X and -600X models were dropped in January 1997.  Boeing is currently proposing the 747-400XQLR (Quiet Longer Range) to 747-size customers which will offer more range, more quiet, and more features.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 737-700/800 BBJ/BBJ2',71486270.0,'img/0261216-v40-6.jpg',' The Boeing Business Jet - or BBJ - is a long range corporate jet development of the 737-700 and -800.

Boeing Business Jets is a joint venture formed by Boeing and General Electric in July 1996 to develop and market a corporate version of the popular 737 airliner, initially focusing on the 737-700 based BBJ (or 737-700 BBJ). The first BBJ rolled out from Boeing''s Renton plant on August 11 1998 and flew for the first time on September 4 that year. On October 30 the US FAA awarded certification to the developed 737-700 airframe on which the BBJ is based. The first completed BBJ was delivered on September 4 1999.

The BBJ combines the Next Generation 737-700''s airframe combined with the strengthened wing, fuselage centre section and landing gear of the larger and heavier 737-800, with three to 10 belly auxiliary fuel tanks. It features the Next Generation 737 advanced two crew six LCD screen EFIS avionics flightdeck, equipped with embedded dual GPS, TCAS, enhanced GPWS and Flight Dynamics head-up guidance system. Following their certification in September 2000, winglets became a standard option.

Boeing supplies unfurnished or ''green'' BBJ airframes to DeCrane of Georgetown, Delaware for long range fuel tank installation. From DeCrane the BBJ is flown to a customer specified completion centre for interior fit-out and exterior painting.

On October 11, 1999 Boeing launched the BBJ2, based on the stretched 737-800 airframe, which is 5.84m (19ft 2in) longer than the BBJ, and is offering 25% greater cabin space (and 100% more baggage space), but has slightly reduced range. It is fitted with between three and seven auxiliary belly fuel tanks. The winglets are standard on this version. The first delivery was made on February 28, 2001.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 747-100 & 200',87326795.0,'img/0116440-v40-6.jpg',' The hugely significant 747 revolutionised airline transport. Far bigger than anything before it, the 747 slashed operating costs per seat and thus cut the cost of long haul international airline travel.

Boeing conceived the 747 in the mid 1960s following its failure to secure a US Air Force contract for an ultra large strategic transport (which resulted in the Lockheed C-5 Galaxy), when it identified a market for a high capacity ''jumbo jet''. Boeing was able to draw upon design experience with the USAF transport and launched the new airliner on July 25 1966. First flight occurred on February 9 1969, certification was awarded on December 30 that year.

The basic 747-100 entered service with Pan American in January 1970. Progressive development of the 747 led to the 747-200B with higher weights, more powerful engines and longer range. The -200B first flew in October 1970 entering service with KLM, while nine higher weight 747-100Bs were built.

Developments include the 747-200F freighter, the SR (short range) optimised for high cycle short sector operations and the C (Combi).

The 747 holds a place in the public eye unlike any other aircraft. The so called `Queen of the Skies'' opened up international travel to millions. It is also notable for being the first widebody airliner, the largest and heaviest airliner, and the first to use fuel efficient, high bypass turbofans.



 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 767-300',42946094.0,'img/0247956-v40-6.jpg',' Boeing announced that it was developing a stretched development of the 767-200 in February 1982.

The resulting 767-300 features a 6.42m (21ft 1in) stretch consisting of fuselage plugs forward (.07m/10ft 1in) and behind (3.35m/11ft) the wing centre section. The flightdeck and systems were carried directly over from the 767-200, the only other changes were minor, and related to the increased weights of the new version. Initially the max takeoff weight was the same as the later 767-200ER.

The 767-300 flew for the first time on January 30 1986, and was awarded certification and entered service in September that year. The higher weight Extended Range ER version flew on December 19 1986, while RollsRoyce RB-211-524G engines became available from 1989. The range of the 767-300ER has proven to be very popular with a number of airlines using them for long range low density flights.

In 1993 Boeing launched the 767-300F General Market Freighter. Changes include strengthened undercarriage and wing structure, a cargo handling system, no cabin windows and a main deck freight door. Capacity is 24 containers. The further stretched 767-400 is described separately.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 737-500',42916114.0,'img/1171595-v40-6.jpg',' The 737-500 is the shortest and smallest member of the second generation 737-300/-400/-500 family, and the last to be developed.

When the new stretched 737-300 first appeared it was intended to supplement, rather than replace, the 737-200. However the evolution of the 737-300 into a family of models led to the development of a new model comparable in size to the 737-200, but offering better fuel economy and extensive commonality with the 737-300 and -400 models. This was the 737-500, known before its May 1987 formal launch as the 737-1000.

Like the preceding 737-300 and 737-400, the 737-500 is powered by CFM International CFM56s turbofans, in this case either 82.3kN (18,500lb) CFM563B1s or 8.0kN (20,000lb) CFM56-3C-1s. All three second generation 737 models share extensive systems and structure commonality, and a common aircrew type rating. These benefits offer real cost savings to an airline with two or more variants of the family in its fleet.

The 737-500 is 3.01m (101ft 9in) in length, comparable to the 737-200''s 30.53m (100ft 2in) length, and as such is a viable direct replacement for the earlier type. Like the 300 and 400, a higher gross weight longer range version is offered, featuring auxiliary fuel tanks and uprated engines.

The 737-500''s first flight occurred on June 30 1989, FAA certification was awarded on February 12 1990, with service entry later that same month.

The 737-500''s main appeal is for operators of large 737-400 and 737-300 fleets, as because the 500 is a shortened development of the 300, it still carries much of the structural weight needed for the higher weight models. This makes it less efficient than if it was designed specifically for its size category, however for operators of large 737-300/400 fleets, the extensive commonality benefits more than compensate for this.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 737-400',42916104.0,'img/0270952-v40-6.jpg',' Boeing announced it was developing a new higher capacity version of the fast selling 737-300 in June 1986.

The new aeroplane, the 737-400, was developed as a 150 seat class 727 replacement. Although Boeing had initially developed the 180 to 200 seat 757 to replace the successful 727, there still existed a considerable market for a near direct size replacement for the popular trijet. By developing the 737-400 as a minimum change stretch of the 737-300, Boeing was also able to offer considerable commonality, and thus cost, benefits to operators already with the 737-300, and to a lesser extent, the 737-200 in their fleets.

The major change of the 737-400 over the smaller 300 is a .05m (10ft 0in) fuselage stretch, consisting of a 1.83m (6ft 0in) stretch forward and a 1.22m (4ft 0in) plug rear of the wing. The stretch increases maximum passenger seating to 188. To cope with the increased weights, more powerful CFM56s are fitted. Other changes are minor, such as a tail bumper fitted to protect against over rotation at takeoff, something that could have become a problem due to the increased fuselage length.

A higher gross weight longer range version is offered. It features increased fuel capacity, and strengthened undercarriage and structures, but is otherwise identical to the standard 737-400.

The first flight of the 737-400 occurred on February 19 1988 and it entered airline service in October that year with Piedmont. Of the 737-300/-400/-500 family the 400 has proven the most successful member behind the 300, its larger capacity and transcontinental US range meaning it has found a very useful market for Boeing as a 727 replacement. However the 737-400 does face stiff competition from the similar size Airbus A320, which has higher levels of technology, longer range and is faster (but is also heavier).

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 727-100',42906074.0,'img/0228041-v40-6.jpg',' The 727 short to medium range trijet is the world''s second most successful jet airliner built.

Initial design studies began in 1956, although for a time it appeared that a new short/medium range airliner would not be built at all due to Boeing''s financial position before sales of the 707 had taken off. Boeing persisted however and serious development of the 727 beginning in June 1959. The program was launched on the strength of orders for 80 from Eastern and United in 1960.

The resulting Boeing Model 727 pioneered the rear trijet configuration, with power from three specially designed Pratt & Whitney JT8D turbofans (although RollsRoyce Speys were originally considered). The trijet design was settled upon as it gave the redundancy of three engines, better climb performance than a twin and improved operating economics over a four engine jet. The 727 also introduced an advanced wing design with the first airliner application of triple slotted Krueger flaps. The 727 retained the 707''s fuselage cross section, but with a redesigned smaller lower fuselage due to the need to carry less baggage on shorter range flights, and it has limited parts commonality with the 707 and 720. The 727 was also the first Boeing airliner to feature an APU (auxiliary power unit).

The prototype 727 first flew on February 9 1963, with certification granted in December that year. The first 727 entered service with Eastern Airlines on February 9 the following year.

Development of the initial 727-100 resulted in a small family of sub variants, including higher gross weight options for the basic passenger carrying 727, the 727-100C Convertible and 727-200QC Quick Change, both with a large freight door on the forward left hand side of the fuselage. Many were subsequently converted to pure freighters. The stretched 727-200 is described separately.

Production of the 727-100 ceased in 1973 but one recent notable development was Dee Howard in the USA upgrading a number of 727-100 freighters for express freight operator UPS. The major feature of the upgrade was reengining with RollsRoyce Tays, which improves performance, reduces fuel consumption and more importantly, allows the aircraft to meet Stage 3 noise requirements.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 737-100/200',25872222.0,'img/0778691-v40-6.jpg',' The 737-100 and 200 are the first generation production models of the world''s most successful jet airliner family, Boeing''s 737 twinjet.

The 737 was conceived as a short range small capacity airliner to round out the Boeing jet airliner family beneath the 727, 720 and 707. Announced in February 1965, the 737 was originally envisioned as a 60 to 85 seater, although following consultation with launch customer Lufthansa, a 100 seat design was settled upon. Design features included two underwing mounted turbofans and 60% structural and systems commonality with the 727, including the same fuselage cross section (making it wider than the competing five abreast DC-9 and BAC-111).

The 737-100 made its first flight on April 9 1967 and entered service in February 1968 with Lufthansa, while the last of 30 built was delivered to Malaysia-Singapore Airlines in October 1969.

By this time however the larger capacity 1.93m (6ft 4in) stretched 737-200 was in service after it had made its first flight on August 8 1967. First delivery, to United, was that December.

Developments of the -200 include the -200C convertible and quick change -200QC, while an unprepared airfield kit was also offered. The definitive Advanced 737-200 appeared in 1971, featuring minor aerodynamic refinements and other improvements.

Sales of the 737-200 far exceeded that of the shorter -100 and the 737-200 remained in production until 1988, by which time it had been superseded by the improved 737-300, after 1114 had been built. Many have been fitted with Stage 3 engine hushkits, and a number of passenger aircraft have been converted with cargo doors.

The USAF ordered 19 as navigation trainers, and some were later converted to standard transport aircraft as CT-43A. A few other air forces received 737-200s to serve in general transport, surveillance or VIP transport tasks.



 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 757-200',42936084.0,'img/0117340-v40-6.jpg',' After a slow sales start, the medium range single aisle 757 has become yet another sales success story for Boeing.

Boeing considered a number of proposals for a successor to the 727 tri-jet during the 1970s, with many of these designs featuring the nose and T-tail of the earlier jet. It was not until later in that decade however that Boeing settled on a more conventional design featuring the same cross section as the 727 (not to mention the 737, 707 and 720) but with the fuselage considerably longer in length, an all new wing, nose and flightdeck and fuel efficient high bypass turbofan engines.

Boeing launched development of the 757 in March 1979 following orders from British Airways and Eastern. Developed in tandem with the larger widebody 767 the two types share a number of systems and technologies, including a common early generation EFIS flightdeck.

First flight was on February 19 1982 and the 757 entered service in January the following year. Subsequent versions to appear are the 757-200PF Package Freighter, a pure freighter, and the 757-200M Combi (only one has been built). The standard passenger aircraft is designated the 757-200, there being no -100. The stretched 757-300 is described separately.

Initial sales of the 757 were fairly slow, however orders picked up significantly in the mid to late 1980s as traffic on routes previously served by smaller 727s and 737s grew to require the 757''s extra capacity. Today 757 sales comfortably exceed those of the 767, a position that was reversed until the late 1980s.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 727-200',42906084.0,'img/0245027-v40-6.jpg',' The 727-100 had been in service barely a year when Boeing began serious consideration of a stretched, greater capacity development.

This resulted in the 727-200, which Boeing announced it was developing in August 1965. The 727-200 was essentially a minimum change development of the 100, the only major change being the 6.10m (20ft) fuselage stretch, which increased maximum seating to 189 passengers. The 727-200''s stretch consisted of two .05m (10ft) plugs, one forward and one rear of the wing. Otherwise the 727-100 and 200 shared common engines, fuel tank capacity and the same maximum takeoff weight.

The first flight of the 727-200 occurred on July 27 1967, with certification granted in late November that year. The -200 was placed into service by launch customer Northeast Airlines (this airline was later acquired by Delta) the following month, by which time total 727 orders for both models had exceeded 500.

The 727-200 helped broaden the sales appeal of the 727 considerably and snared significant sales. However the 200 was restricted by its relatively short range, due to it having the same fuel capacity as the 727-100, so Boeing developed the increased range Advanced 727-200. First flown in March 1972 changes introduced on the Advanced model included increased fuel capacity, and thus range, the option of more powerful engines, quieter engine nacelles and strengthened structure. The Advanced remained the primary 727-200 production model until production ceased in 1984.

The 727-200 remains popular with passengers and pilots but it does not meet Stage 3 noise requirements. To overcome this a number of hushkit programs are on offer while Valsan converted 23 727s to its Stage 3 compliant Quiet 727 standard (before the company collapsed). This retrofit included installing JT8D-217s on the outer pylons and acoustic treatment of the centre engine. Other 727s have been fitted with winglets for improved performance.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 737-600/700',26372272.0,'img/0291918-v40-6.jpg',' The 737-600 and -700 are the smaller members of Boeing''s successful Next Generation 737-600/700/800/900 family.

Among the many changes, the Next Generation 737s feature more efficient CFM56-7B turbofans. The CFM56-7 combines the core of the CFM56-5 with the CFM56-3''s low pressure compressor and a 1.55m (61in) fan. The 737''s new wing has greater chord, span and wing area, while the tail surfaces are also larger. The 2.4m (8ft) high winglets first developed for the Boeing Business Jet development are now offered as an option on the 737-700 (and -800).

The new engines and wings allow the 737 to cruise at Mach 0.78 to Mach 0.80, while the larger wing allows greater fuel tankage and transcontinental USA range. Other features include a 777 style EFIS flightdeck with six flat panel LCDs which can be programmed to present information as on the 777 or as on the 737-300/400/500 series, allowing a common pilot type rating for the two 737 families.

The improved Next Generation Boeing 737 family (originally covered by the 737X designation) was launched in November 1993. The 737-700 was the first member of the new family to be developed, and is based on the 737-300, while the 737-600 is based on the 737-500.

The 737-700 rolled out on December 7 1996, was granted certification in November 1997 and entered service (with Southwest) the following month. The 737-600 was launched was launched on March 16 1996, first flew on January 22 1998 and entered service (with SAS) in September that year.

The Boeing Business Jet or BBJ (described separately) is based on the fuselage of the 737-700 with the larger 737-800''s wing.

The BBJ''s airframe also forms the basis for the convertible passenger/freighter variant of the 700, the 737-700QC, which has been ordered by the US Navy as the C-40A Clipper (to replace the DC-9 based C-9B). The C-40 first flew on April 17 2000. The naval aircraft can be converted to carry 121 passengers, or 3 pallets of cargo plus 70 passengers, or 8 pallets of cargo only. These aircraft are currently (2002) based at Naval Air Station Fort Worth, Texas (VR-59) and Naval Air Station Jacksonville, Florida (VR-58).

The US Air Force has bought two ex-Fordair BBJs, which are designated C-40B.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 720',61338746.0,'img/0996055-v40-6.jpg',' The 720 is a smaller capacity, lighter, medium range variant of the 707, given its own model number to indicate significant engineering changes.

Introduced in 1959, the 720 (originally designated 707-020) retained the same basic structure as the 707-120, but was 2.54m (8ft 4in) shorter, which reduced seating to 112 (38 + 74) in a typical two class arrangement. Other changes were made to the wing which introduced full span leading edge flaps, while a glove between the inner engines and the fuselage increased wing sweep and wing area and decreased the wing''s thickness/chord ratio. The changes to the wing made it more aerodynamically efficient, permitting higher cruising speeds and lowered minimum speeds (which aided field performance).

Like the early 707s the first 720s had JT3C turbojets, although less powerful models lacking water injection because of the 720''s lighter weight. Compared with the 707-120 the 720 also had reduced fuel capacity and a lower max takeoff weight. But many components were interchangeable between the 720 and 707, while inside the cabin the 720 and 707 shared the same passenger interior and flightdeck.

The initial 720 (bound for launch customer United) first flew on November 23 1959. Certification was awarded on June 30 1960, and entry into service with United Airlines was on July 5 that year.

The availability of the far more fuel efficient Pratt & Whitney JT3D turbofan resulted in the 720B, which was powered by either JT3D1s or 3s. First flight of the 720B was on October 6 1960, with certification awarded on March 3 1961. The 720B also featured a higher maximum zero fuel weight (significantly boosting payload/range) and an increased max takeoff weight due to the heavier turbofan engines.

Major 720 operators included American Airlines (a number of its 720s were converted to 720Bs with turbofan engines), United, Continental, Eastern, Northwest Orient and Western, while operators outside the US included Lufthansa and Avianca.

Today (early 2002) three 720s are believed to be in use as corporate transports, and two are used by Pratt & Whitney as engine testbeds.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 717',61338745.0,'img/0312683-v40-6.jpg',' The 100 seat 717 is the latest development of the popular DC-9/MD-80/MD-90 family and the only Douglas airliner which Boeing (which merged with McDonnell Douglas in 1997) plans to retain in its product line-up. It is designed for high cycle, short range regional airline operations.

McDonnell Douglas first announced the MD-95 at the Paris Airshow in June 1991. At the time MDC anticipated a formal program launch by late 1991 and a first flight in July 1994. As it happened program launch was not until October 1995 when US airline ValuJet (now AirTran Airlines) ordered 50 and optioned 50.

In January 1998 Boeing (following the August 1997 Boeing/McDonnell Douglas merger) relaunched the aircraft as the 717-200 (the second use of the Boeing designation "717", as this was previously allocated to the military C-135/KC-135 family). First flight took place on September 2 1998, followed by a second development 717 on October 26. Certification was awarded on September 1 1999 while the first delivery, to AirTran, was on September 23 that year.

Initially MDC studied powering the MD-95 with Pratt & Whitney JT8D-218s or Rolls-Royce Tays. In February 1994 however MDC announced it had chosen the new BMW Rolls-Royce (now just Rolls-Royce) BR715 over the JT8D-200 and an engine from the proposed "Project Blue" teaming of General Electric, Snecma, MTU and P&W.

Other 717-200 features include a fuselage 1.45m (4ft 9in) longer than the DC-9-30''s, a wing based on the DC-9-34''s, an advanced six LCD screen Honeywell EFIS flightdeck, and a cabin interior similar to that developed for the MD-90. It is offered in standard 717-200BGW (Basic Gross Weight) and extended range 717-200HGW (High Gross Weight) forms. In addition, 80 seat shortened 717-100 (formerly MD-95-20) and 120 seat stretched 717-300 (formerly MD-95-50) models have been studied, as has a business jet variant.

Companies participating in 717 production include Alenia (fuselage), Korean Air (nose), AIDC of Taiwan (empennage), ShinMaywa of Japan (engine pylons and horizontal stabilizers), Israel Aircraft Industries (undercarriage), and Fischer of Austria (interior). Final assembly is at Boeing''s Long Beach plant, in the same building that the DC-9 and MD-80 were built in.

Initial orders and operators are:
AeBal, Airtran, Bangkok Air, Bavaria International Leasing, Hawaiian Airlines, Impulse Airlines, Midwest Express Airlines, Olympic Aviation, Pembroke Leasing, Qantas Link, Siam Reap Air, Trans World Airlines, and Turkmenistan Airlines.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Beriev Be-30/32',21086524.0,'img/1136752-v40-6.jpg',' The Beriev Be-32 is an upgraded development of the Be-30 commuter that was originally developed for Aeroflot in the late 1960s.

The Beriev Be-30 was designed against an Aeroflot requirement for a twin turboprop airliner and utility transport in the late 1960s as a replacement for the Antonov An-2 on low density routes, or where airfields were inadequate for larger aircraft.

The prototype Be-30 first flew on March 3 1967, temporarily powered by two 550kW (740hp) ASh-21 piston radial engines. These engines were replaced by 723kW (970shp) TVD-10 turboprops, with which the first flight was made on July 13 the same year. The prototype was displayed statically at the Domodedovo air show in July 1967. Two other prototypes were also built. The Be-30 had accomodation for 14 passengers. The aircraft was further developed into the Be-32, which had higher powered TVD-10B engines, and accomodation for up to 17 passengers. It is reported that eight production aircraft were manufactured, between 1968 and 1976, three at the experimental factory No.49, and five at the Taganrog factory No.86. It is thought however that the first three are the prototype Be-30s, and the next five the (pre)production Be-32s. The airplane was thoroughly tested in many different regions in Russia under various operating conditions. In the mid seventies Beriev used the Be-32 to claim two time-to-height records (3000m in 2min 24.8sec, 6000m in 5min 18sec). NATO assigned the code name Cuff to the Be-30/32.

The Be-30 had to compete with the Antonov An-28 (first flight September 1969) for the large Aeroflot orders that were to be expected. The Be-30 had a longer range, was faster, and had better crosswind handling. The An-28 had better landing and take-off performance and a larger capacity. Therefore both aircraft were recommended for production. But the whole project was cancelled about 1972 when Aeroflot chose the Czech Let L-410 Turbolet (described separately) in preference to Beriev''s (and Antonov''s) design. The L-410 had a slightly larger load capacity, but was mainly chosen for political reasons, strengthening the economical ties with the East European countries. Since then the Be-30/32 lay dormant until Beriev resurrected it in the early 1990s in a bid to attract new business. As Czech and other foreign aircraft and spare parts had now to be paid in hard currency, it was thought that domestic aircraft could be preferred for the internal Russian market, and could gain hard currency when exported.

Beriev exhibited the Be-32 at the 1993 Paris and Dubai air shows, the design bureau claiming that the Be-32 incorporated a number of improvements, including more powerful engines. This demonstrator was one of the original aircraft built in the early seventies. This Be-32 was painted in the colors of Moscow Airways, who had placed an order for 50 earlier in 1993, but this company ceased operations before any were delivered.

Technical features of this high wing unpressurised commuter include a fuselage of all-metal semi-monocoque structure covered mainly with large chemically-milled panels attached by bonding and spot-welding. The cantilever wing has anhedral on the outer panels. The spars of the main torsion box and the skin panels are made of mechanically and chemically-milled profile pressings. The detachable leading edge is of bonded construction. Thin 3-layer honeycomb panels stiffened by stringers are used for about half of the wing skin. Bonding and spot-welding is used for most of the joints. Double-slotted flaps occupy the trailing edge inboard of the ailerons.
The tail unit has a similar all-metal cantilever structure with a thin honeycomb skin covering. For weight saving, glass fibre reinforced plastics are used for some non-load-carrying parts, such as the wingtips, some tail surfaces, and wing/fuselage fillets.

A hot-air de-icing system using engine-bleed air is provided for the wings, tail unit, and engine air intakes, while the windscreen and propellers have electric de-icing. The aircraft has a retractable tricycle landing gear with a single wheel with a low pressure tire on each unit. The main units retract rearward into the engine nacelles. The nosewheel retracts forward and is steerable. Floats and skis are optional. There is provision for an interconnecting shaft between the engines that permits power on both propellers during an engine-out condition. This system was installed and flight tested on the second prototype. There are four integral fuel tanks, located in the wing torsion box.

The Be-30 has accomodation for a crew of two on the flight deck and 14 passengers in the cabin, later increased to 17 in the Be-32. There are two small compartments, for mail and small freight, on the port side between the flight deck and the cabin. On the starboard side, aft of the cabin, is a carry-on baggage compartment, and a toilet is provided at the rear of the cabin. The aircraft carries its own folding stairway.

On August 15, 1995, a prototype was flown of the Pratt & Whitney PT6A-65B powered Be-32K, a conversion of the Be-32 exhibited at Paris and Dubai in 1993. Production aircraft will be powered by the Russian built version of this successful engine, the Klimov PK6A-65B.

In September 1996 it was announced that the Be-32 would be produced by IAR in Romania, but these plans were later denied. In 1998 it was stated that the Be-32K would be built by Taganrog Aviation, but flight testing was reportedly still under way in 1999. Apparently there has not been much progress in recent years, and as far as is known, no new aircraft have been built since the mid seventies.

 ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 707',61338744.0,'img/0238807-v40-6.jpg',' The 707''s jet speed, long range, high seating capacity and operating economics revolutionised airliner travel when it was introduced into service in 1958. The 707 also laid the foundations for Boeing''s dominance of the jet airliner market.

Recognising the jet engine''s potential for commercial aviation, Boeing (at great financial risk) decided to develop a jet powered transport that could fulfil military tanker transport roles but be easily adapted to become an airliner.  The resulting prototype, known as the 367 Dash 80, flew for the first time on July 16 1954. Impressed, the US Air Force ordered a larger version, with a wider fuselage (12 ft, vs 11 ft for the Dash 80) into production as the KC-135 tanker/transport (more than 800 were built).  At first, Boeing wanted to sell the same size aircraft to the airlines, but the airlines insisted on an even larger airplane, which Douglas promised to build (this became the DC-8).  Boeing finally relented, designing the 707 as a longer aircraft with a slightly wider fuselage (12 ft 4 in).

The first production 707 (a 707-120 for Pan Am) flew on December 20 1957, and entered service later the following year. Developments of the 707-120 include the similar 707-220, the shorter 138 for Qantas, and the stretched 707-320, which flew in July 1959. The 707-120 and 320 were later reengined with JT3D turbofans (in place of the original JT3 and JT4 turbojets) to become the 707-120B, and the 707-320B respectively. The 707-320C was a convertible model, the 707-420 was powered by RollsRoyce Conways, while the proposed CFM-56 powered 707-700 upgrade was flight tested in the late 1970s but never entered production.

Most civil 707s in service today have been converted to freighters, while a number are used as corporate transports.

Many air forces have bought 707s, new or converted second-hand aircraft, for general transport, aerial refuelling, and electronic warfare. The E-3 Sentry is a dedicated airborne warning and control system (AWACS) platform with a large rotodome above the fuselage. The E-6 Mercury performs the TACAMO (Take Charge and Move Out) role with the US Navy, maintaining communication with the ballistic missile submarines. The E-8 J-Stars (Joint Surveillance Target Attack Radar System) performs the battlefield control role. Other military 707s received the designations C-137, or C-18, but many others have no special military designation. ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Beriev Be-200',4140661.0,'img/1046235-v40-6.jpg',' The Beriev Be200 jet powered multirole amphibian is based on the larger military A40 Albatross.

Beriev has extensive experience in building large amphibious aircraft. The turboprop ASW Be12 Tchaika was built in fairly large numbers from the mid 1960s (approx 150) for the Soviet navy. The Be42 Albatross jet meanwhile (which has the NATO reporting name `Mermaid'') first flew in prototype form in December 1986 and is being developed for the Russian navy for maritime surveillance and ASW.

The Be200 is based on the Be42 and it uses many of the design features and technologies developed for the Be42, but is smaller overall and designed for civil roles, in particular firefighting. Aerodynamically the Be200 is very similar to its larger forebear, with the same overall proportions. The all metal hull design is based on the Be42''s, and the Be200 has a mildly swept wing with winglets, above fuselage mounted turbofan engines and a swept Ttail.

The airframe is strengthened to cope with the demands of water operations and firebombing and there is some use of advanced aluminium lithium alloys. The two crew flightdeck features an ARIA2000 EFIS avionics suite (ARIA is a collaboration between the Russian avionics research institute and AlliedSignal). The ARIA2000 suite includes specialist firefighting functions including an automatic glidescope and water source/drop zone memorisation.

Design work on the Be-200 began in 1989. It is being developed by Betair, a collaboration between Beriev and Irkutsk in central Russia where the aircraft will be built, Swiss company ILTA Trade Finance, which is providing marketing and financing support, and other partners.

The Be200 is being built to meet western certification requirements. After a number of delays the first flight took place on September 24 1998 from Irkutsk Aviation Production Organisation''s airfield in Irktusk, Siberia.

 ',' Russia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Bell 47',7729177.0,'img/1063152-v40-6.jpg',' The familiar and distinctive Bell 47 is an especially significant aircraft as it was one of the world''s first practical helicopters.

The ubiquitous Bell 47 dates back to Bell''s Model 30 of 1943, an experimental helicopter evaluated by the US Army (10 were ordered for that service). The first subsequent prototype Bell Model 47 (with a car type cabin and two seats) first flew on December 8 1945. In May 1946, this early model Bell 47 became the first civil helicopter in the world to gain civil certification.

The first civil variants to see production were the similar Model 47B, and the 47B3 with an open cockpit. The 47D followed and was the first model to feature the famous `goldfish bowl'' canopy and the distinctive uncovered tail boom. The Model 47E was similar but powered by a 150kW (200hp) Franklin engine.

The definitive Model 47G followed the 47E into production in 1953, and it was this variant, in a number of successively more powerful versions, that remained in production until 1974, testament to the utility and success of Bell''s basic design. The 47G had optional metal rotor blades and was powered by a range of Lycoming engines outputting 150 to 210kW (200 to 280hp).

The Model 47H is based on the 47G, but with a fully enclosed fuselage and conventional cabin, and formed the basis for the 47J Ranger. The Ranger had a further enlarged cabin for four, and entered production in 1956. The 47J2 Ranger introduced powered controls and metal blades as standard, and was powered by a 195kW (260hp) VO540.

Kawasaki in Japan licence built a development of the 47G, the KH4 with more traditional style enclosed cabin

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Bell-Agusta BA-609',98087927.0,'img/1016848-v40-6.jpg',' The Bell BA 609 is set to become the first civil application of the revolutionary tiltrotor technology, taking advantage of its experience with the military V22 Osprey.

Bell pioneered the tiltrotor concept with the experimental XV3 which first flew as early as 1957 and then with NASA developed the XV15 experimental demonstrator which first flew in 1977. In conjunction with Boeing it is building the military V-22 Osprey - the first production Ospreys are due to be delivered to the US Marines in 1999.

In late 1996 Bell and Boeing announced that they intended to use their expertise and experience with the V22 to develop a nine seat civil tiltrotor. The Bell Boeing 609 was formally unveiled on November 18 1996. However in early 1998 Boeing announced its withdrawal from the program as a risk sharing partner to remain as a major subcontractor. Then in September that year Bell announced that Agusta would become a risk sharing development partner in the redesignated BA 609. Agusta will participate in BA 609 development, manufacture components and assemble BA 609s for European and other markets.

First flight for the BA 609 is planned for mid 1999 with certification and first deliveries scheduled for April 2002. (The US FAA is drawing up a new certification category for tiltrotors and a new pilot type rating.)

The benefits of a tiltrotor are that it has the vertical takeoff, landing and hovering abilities of a helicopter combined with fixed wing turboprop speed and performance. As such Bell anticipates that the 609 will compete against helicopters such as the Sikorsky S76 and turboprops such as Beech''s King Air. As well as point to point corporate transport Bell envisages that the 609 will be used for offshore oil rig support, search and rescue and medevac missions, where its unique capabilities would be particularly useful.

The 609 will incorporate advanced technologies such as a glass cockpit, flybywire flight controls and a composite construction fuselage. Power will be from two PT6C67A turboprops.

The 609 could form the basis for a family of civil tiltrotors.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Bell 430',77291775.0,'img/0879607-v40-6.jpg',' Bell''s 430 intermediate twin helicopter is a stretched and more powerful development of the 230.

Bell began preliminary design work on the 430 in 1991, even though the 230 itself had only flown for the first time in August that year. The 430 program was formally launched in February 1992. Two prototypes were modified from Bell 230s, and the first of these flew in its new configuration on October 25 1994. The second prototype featured the full 430 avionics suite, its first flight was on December 19 1994.

The first 430 production aircraft was completed in 1995, while Canadian certification was awarded on February 23 1996, allowing first deliveries from mid that year. Meanwhile 230 production wound up in August 1995, making way for the 430.

Compared with the 230, the 430 features several significant improvements. Perhaps the most important of these is the new four blade, bearingless, hingeless, composite main rotor. Other changes include the 46cm (1ft 6in) stretched fuselage, allowing seating for an extra two passengers, 10% more powerful Allison 250 turboshafts (with FADEC) and an optional EFIS flightdeck. As well as the optional EFIS displays the 430 features as standard a RogersonKratos Integrated Instrument Display System (IIDS), comprising two LCD displays to present engine information. The 430 is offered with skids or retractable wheeled undercarriage.

Between August 17 and September 3 1996 Americans Ron Bower and John Williams broke the round the world helicopter record with a Bell 430, flying westwards from England. International Directory of Civil Aircraft
 ',' Canada and United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Bell 412',77291774.0,'img/0999584-v40-6.jpg',' The 412 family is a development of the 212, the major change being an advanced smaller diameter four blade main rotor in place of the 212''s two blade unit.

Development of the 412 began in the late 1970s and two 212s were converted to the new standard to act as development aircraft for the program. The first of these flew in August 1979, and the 412 was awarded VFR certification in January 1981. That same month the first delivery occurred. Subsequent development led to the 412SP, or Special Performance, with increased fuel capacity, higher takeoff weight and more optional seating arrangements. The 412HP, or High Performance, superseded the 412SP in production in 1991. Features include improved transmission for better hovering performance.

The current standard production model is the 412EP, or Enhanced Performance. The 412EP features a PT6T3D engine and a dual digital automatic flight control system fitted as standard, with optional EFIS displays. Fixed tricycle landing gear is optional.

Meanwhile in Indonesia, IPTN has a licence to build the 412SP, which it calls the NBell412. IPTN has a licence to build up to 100 NBell412s.

Like the 212, the 412 is in widespread use for a number of utility roles, including EMS and oil rig support, its twin engine configuration being an asset, particularly in the latter role. It too is in military service, Canada once again being a major customer (including 100 recently delivered 412EP based CH-146 Griffons).



 ',' United States of America and Canada ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Bell 214ST SuperTransport',83707453.0,'img/1115676-v40-6.jpg',' Despite sharing a common model number with the 214 Huey Plus and Big Lifter (described separately), the Bell 214ST is a larger, much modified helicopter.

Bell''s biggest helicopter yet was developed to meet an Iranian requirement for a larger transport helicopter with better performance in its hot and high environment than its 214 Isfahans. Bell based its proposal on the 214 but made substantial design changes, resulting in what is essentially an all new helicopter with little commonality with the smaller 214 series.

The 214ST features two General Electric CT7 turboshafts (the commercial equivalent of the military T700), a stretched fuselage seating up to 17 in the main cabin, glassfibre main rotor blades, and lubrication free elastomeric bearings in the main rotor hub. The ST suffix originally stood for Stretched Twin, reflecting the changes over the 214, but this was later changed to stand for Super Transporter.

The 214ST was to have been built under licence in Iran as part of that country''s plans to establish a large army air wing (other aircraft ordered in large numbers under this plan were the 214A Isfahan and AH1J SeaCobra), but the Islamic revolution and fall of the Shah in 1979 put paid to these plans.

Undeterred, Bell continued development of the 214ST - which first flew in February 1977 - for civil and military customers. Three preproduction 214STs were built from 1978 and 100 production aircraft were built through to 1990.

Most 214ST sales were to military customers. Iraq was the 214ST''s largest customer, taking delivery of 45 during 1987 and 1988, some most likely seeing service in the Gulf War.

Civil applications for the 214ST are numerous, including oil rig support, where its twin engine configuration and 17 passenger main cabin are useful assets.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Bell 206LT TwinRanger & Tridair Gemini ST',34192414.0,'img/0809768-v40-6.jpg',' Bell''s 206LT TwinRanger, is, as its name suggests, a new build twin engined development of the 206L LongRanger, while Tridair helicopters in the USA offers its twin engine Gemini ST conversion for existing LongRangers.

The name TwinRanger predates the current 206LT to the mid 1980s when Bell first looked at developing twin engine version of the LongRanger. The Model 400 TwinRanger did fly (maiden flight was on April 4 1984) and it featured two Allison 250 turboshafts, the four blade main rotor developed for the military Bell 406/OH58 Kiowa and a reprofiled fuselage, but development was later suspended.

The current 206LT TwinRanger is based on Tridair Helicopters'' Gemini ST conversion program. Tridair announced it was working on a twin engine conversion of the LongRanger in 1989, and the prototype flew for the first time on January 16 1991. Full FAA certification was awarded in November and covers the conversion of LongRanger 206L1s, L3s and L4s to Gemini ST configuration.

In mid 1994 the Gemini ST made history when it was certificated as the first Single/Twin aircraft, allowing it to operate either as a single or twin engine aircraft throughout all phases of flight. This unique certification allows it to operate with a single engine for maximum economy (for ferrying etc), with the extra redundancy and performance of a twin available when required.

Bell''s 206LT TwinRanger is a new build production model equivalent to Tridair''s Gemini ST and based on the LongRanger IV. The first example was delivered in January 1994. The TwinRanger will be replaced by the 427 which is currently under development.

 ',' United States of America & Canada ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Bell 212 Twin TwoTwelve',59269545.0,'img/0647191-v40-6.jpg',' The Model 212 is a twin engined development of Bell''s earlier and highly successful Model 204 and 205 series.

Bell announced its decision to develop the Model 212 in early May 1968 in large part in response to a Canadian Armed Forces requirement for a twin engined development of the CUH1H (Model 205) then entering military service in that country, and following successful negotiations with Pratt & Whitney Canada and the Canadian government. Development of the Model 212 was a joint venture between Bell, Pratt & Whitney Canada and the Canadian government, the latter providing financial support. The resulting helicopter (designated CUH1N in Canadian and UH1N in US military service) first flew in 1969 and was granted commercial certification in October 1970. The first Canadian CUH1Ns were handed over in May 1971.

The most significant feature of the Twin TwoTwelve is the PT6T Twin-Pac engine installation. This consists of two PT6 turboshafts mounted side by side and driving a single output shaft via a combining gearbox. The most obvious benefit of the new arrangement is better performance due to the unit''s increased power output. However, the Twin-Pac engine system has a major advantage in that should one engine fail, sensors in the gearbox instruct the remaining operating engine to develop full power, thus providing a true engine out capability, even at max takeoff weight.

Aside from the twin engines, the 212 features only minor detail changes over the earlier Model 205 and UH1H, including a slightly reprofiled nose. The 212 is also offered with a choice of IFR or VFR avionics suites. Production was transferred to Bell''s Canadian factory in August 1988.

 ',' United States of America and Canada ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Bell 427',77291775.0,'img/1067985-v40-6.jpg',' Bell''s latest helicopter, the 427 is a replacement for the 206LT TwinRanger and the cancelled 407T, which was to be a twin engine 407 (described separately).

When Bell first looked at a twin engine version of its new 407 light single, the company originally anticipated developing the 407T which would have been a relatively straightforward twin engine development (with two Allison 250-C22Bs). However, Bell concluded that the 407T would not offer sufficient payload/range performance, and so began studies of a new light twin.

The result was the all new 427, which Bell announced at the Heli Expo in Dallas in February 1996. Prior to this announcement Bell had signed a collaborative partnership agreement with South Korea''s Samsung Aerospace Industries covering the 427. Samsung''s role on the 427 program is significant, the South Korean company builds the 427''s fuselage and tailboom, and may later assemble any 427s sold in South Korea and China at its Sachon plant. (Samsung also builds the left and right fuselage halves and the tailboom for the Bell 212 and 412). Bell builds the 427''s flight dynamics systems at Fort Worth in Texas, with final assembly at Bell''s Mirabel, Quebec plant.

The 427 was the first Bell designed entirely on computer (including using CATIA 3D modelling). Compared to the 407 the 427''s cabin is 33cm (13in) longer, is largely of composite construction amd lacks the roof beam which obstructs the cabin on the 206/206L/407.

Power is from two FADEC equipped Pratt & Whitney Canada PW-206 turboshafts, driving the composite four blade main rotor and two blade tail rotor (based on those on the OH-58D Kiowa and Bell 407) through a new combining gearbox. The main rotor''s soft-in-plane hub features a composite flexbeam yoke and elastomeric joints, eliminating the need for lubrication and any form of maintenance. The 427''s glass cockpit features an integrated instrument display system (IIDS). A hinged main cabin door is standard but a sliding door is optional.

First flight was on December 11, 1997 and Canadian certification was awarded on November 19, 1999. First customer deliveries followed US certification in January 2000. US FAA dual pilot IFR certification was awarded in May 2000.


 ',' Canada, United States of America and South Korea ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Bell 407',77291773.0,'img/0571765-v40-6.jpg',' Bell''s already popular 407 is the long awaited successor to its JetRanger and LongRanger light singles.

Development work on Bell''s New Light Aircraft replacement for the LongRanger and JetRanger dates back to 1993. The end result was the 407, an evolutionary development of the LongRanger.

A modified 206L3 LongRanger served as the concept demonstrator 407 and first flew in this form on April 21 1994, while the 407 was first publicly announced at the Las Vegas HeliExpo in January 1995.

The 407 concept demonstrator mated the LongRanger''s fuselage with the tail boom and dynamic system of the military OH58D Kiowa (which has a four blade main rotor). Fake fairings were used to simulate the wider fuselage being developed for the production standard 407. The first preproduction 407 flew in June 1995, the first production 407 flew in November 1995. Customer deliveries commenced the following February.

Compared with the LongRanger, the 407 features the four blade main rotor developed for the OH58, which uses composite construction, and the blades and hub have no life limits. Benefits of the four blade main rotor include improved performance and better ride comfort.

Another big change over the LongRanger is the 18cm (8in) wider cabin, increasing internal cabin width and space, plus 35% larger main cabin windows. Power is from a more powerful Allison 250C47 turboshaft fitted with FADEC, allowing an increase in max takeoff weight and improving performance at hotter temperatures and/or higher altitudes. The tail boom is made from carbonfibre composites, while Bell has studied fitting the 407 with a shrouded tail rotor.

Bell looked at the 407T twin 407 for a time, but opted instead to develop the substantially revised twin PW206D powered 427.

 ',' Canada and United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Bell 206L LongRanger',82580783.0,'img/0848949-v40-6.jpg',' Bell developed the LongRanger to offer a light helicopter with greater capacity and utility over the JetRanger.

Bell announced it was developing a stretched JetRanger in September 1973, the subsequent Model 206L flew for the first time on September 11 1974, and production began in early 1975. The LongRanger seats a further two passengers compared to the JetRanger, and introduced a more powerful engine and NodaMatic transmission suspension system for greater passenger comfort.

Subsequent versions have been the 206L1 LongRanger II, introduced in 1978, the 206L3 LongRanger III, and the current 206L4 LongRanger IV, introduced in 1992. Each subsequent version features increasingly more powerful engines and other minor improvements. LongRanger production, along with the JetRanger, was transferred to Mirabel in Canada in 1986.

The LongRanger has found favour not only as a corporate transport, but with police and medical services worldwide, its extra cabin size providing a very useful increase in utility. Bell currently offers a twin engined LongRanger, the TwinRanger, while a US company offers the twin engine Gemini ST conversion of the LongRanger. It also forms the basis of the 407.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Beech 99 Airliner',93087457.0,'img/0154560-v40-6.jpg',' The Beech 99 is an evolution of the successful Queen Air/King Air series, and shares the King Air''s basic powerplant and layout, but otherwise is a new design, with a significantly lengthened cabin with greater seating capacity.

Design of the 99 began in the late 1960s, in part to find a replacement for the venerable Beech 18. In December 1965 a stretched fuselage Queen Air was flown for the first time, while the Pratt & Whitney Canada PT6 powered prototype model 99 made its first flight in July 1966. The first customer aircraft was delivered in May 1968, the series then known as the Commuter 99. At the time the 99 was Beech''s largest aircraft yet and Beech was optimistically forecasting a production rate of 100 per year.

Subsequent models were the A99, A99A and B99, with differing powerplants, submodels and weights. The B99 was available in two variants, the B99 Airliner and the B99 Executive, a corporate transport version with seating for between eight and 17 passengers.

Production of early models was halted in 1975, and it was not until 1979 that the improved C99 Commuter (plus the larger 1900, described separately) was announced as part of Beech''s return to the commuter airliner market. A converted B99 fitted with P&WC PT6A34 engines served as the C99 prototype, and flew in this form for the first time on June 20 1980.

Production aircraft featured PT6A36 engines, and deliveries recommenced following certification, both in July 1981. Shortly afterwards it became known as the C99 Airliner.

C99 production ceased in 1986.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Bell 206 JetRanger',90039621.0,'img/0976018-v40-6.jpg',' The JetRanger series has become the definitive turbine powered light utility and corporate helicopter of the past three decades.

The JetRanger can trace its lineage back to an unsuccessful contender for a US Army competition for a light observation helicopter, which was won by the Hughes 500. This first Model 206 made its first flight on December 8 1962, while the following civil 206A, powered by a 235kW (317shp) Allison C18A, followed, flying on January 10 1966. Deliveries of the first production JetRangers began late in that same year.

In the early 1970s production switched to the Model 206B JetRanger II with a 300kW (400shp) 250C20 turboshaft, while conversion kits to upgrade earlier As to the new standard were made available. The third major variant of the JetRanger is the 315kW (420shp) 250C20B powered JetRanger III, with first deliveries commencing in late 1977. Once again Bell offered a conversion kit to update earlier JetRangers to the new standard. Other features introduced on the JetRanger III were a larger and improved tail rotor and minor modifications.

JetRanger production was transferred from Texas to Mirabel in Canada in 1986, where the current production model remains the 206B3 JetRanger III.

The JetRanger was also accepted by the US Army as an observation helicopter as the OH58 Kiowa, and variants of the Kiowa remain in production in the USA. Military 206Bs were also built in Australia for the Australian Army, where plans were also held to build civilian 206Bs for the Australian market under license, but these fell through.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Bell 204/205/214B',46927794.0,'img/0874505-v40-6.jpg',' The Bell Model 204B and 205A1 are the civil counterparts to the highly successful UH1B and UH1H Iroquois military helicopters.

Bell designed the Model 204 in response to a 1955 US Army requirement for a multi-purpose utility helicopter. The 204 was something of a quantum leap forward in helicopter design as it was one of the first to be powered by a turboshaft. The turboshaft engine radically improved the practicality of the helicopter because of its lower maintenance and operating costs, lower fuel consumption, light weight and high power to weight ratio. The use of a turboshaft in the 204 allowed it to carry a useful payload over respectable ranges and at reasonable speeds, which resulted in the 204 and 205 becoming the most successful western helicopter series in terms of numbers built.

The UH1B, from which the 204B was derived, was first delivered March 1961. The subsequent Model 205A1 is based on the UH1H, which, when compared to the B model, is greater in length and capacity, has better performance and a more powerful engine.

In civil guise the 204 and 205 have been operated in a number of utility roles including aerial cranes and firebombing.

The 214A & C were developed for Iran from the 214 Huey Plus (an improved version of the 205), powered by a massive 2185kW (2930shp) Lycoming LTC4B-8D (with more than twice the power of the 205''s T53). Iran''s Army took delivery of 287 214A Isfahan troop carrier and supply transport helicopters during the 1970s, while another 39 were delivered as 214C SAR helicopters. A commercial derivative, the 214B BigLifter, powered by a 1185kW (2930shp) Lycoming T5508D turboshaft, was built in smaller numbers for civil customers through to 1981. Its main use is as an aerial crane.  ',' United States of America ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('Beech 76 Duchess',44975257.0,' The Model 76 Duchess was one of a new class of light four place twins developed in the mid 1970s.

The prototype of the Duchess, designated the PD-289, made its first flight in September 1974. However a further 30 months of development work passed before the first production Model 76 took to the air on May 24 1977. Certification was granted in early 1978, with first deliveries commencing in that May.

The Duchess was positioned between the Bonanza and the Baron in the Beechcraft model range. Beech developed it for its Beech Aero Centers, and pitched it at the personal use light twin, light charter and multi engine training markets. Design aims included good low speed and single engine handling.

Aside from the prototype PD-289, no variations of the Duchess 76 were built before production ended in 1982. All Duchesses therefore feature two Lycoming O-360 engines (with counter rotating propellers), a T-tail (incorporated to reduce control forces and improve elevator response), entry doors on either side of the cabin and electric trim and flap controls (the prototype PD-289 featured manually operated flaps). The fuselage was based loosely on the single engine Sierra''s, and like the Sierra and its Musketeer predecessors featured a bonded honeycomb construction wing. The Sierra and Duchess also share common structural components.

Beech offered three factory option packages on the Duchess - the Weekender, Holiday and Professional - and 11 factory installed avionics packages.

Beech developed the Duchess for low cost, high volume production, but the falling popularity of light twins, an economic recession and crippling product liability laws in the USA all contributed to a relatively short production run which wound up in 1982. Sales had peaked in 1979 when 213 were built.

Like its contemporaries the Grumman/Gulfstream American Cougar and Piper Seminole, the Duchess'' success was hampered through unfortunate timing. Ever increasing advances in engine efficiency, safety and reliability led to a rise in popularity for big high performance singles such as Beech''s own Bonanza series, which lacked the maintenance overheads of two engines, but had comparable performance. However, to a greater extent than the Seminole and Cougar, the Duchess enjoyed some success as a twin engine pilot trainer, a role in which it is widely used for today.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Beech 65/70/80/88 Queen Air',54026240.0,'img/0675659-v40-6.jpg',' The versatile Queen Air is Beech''s largest and heaviest piston twin apart from the WW2 era radial powered Beech 18.

The prototype Model 65 Queen Air made its first flight on August 28 1958, with deliveries of production aircraft in late 1960 marking the beginning of a production run that would last almost two decades. This first model combined the wings, undercarriage, Lycoming engines and tail surfaces of the Model E50 Twin Bonanza with a new and substantially larger fuselage. A Queen Air 65 established a new class altitude record of 34,882ft in 1960.

Many variants subsequently followed, including the 3630kg (8000lb) max takeoff weight Model 80 with more powerful 285kW (380hp) engines and swept fin and rudder. This model evolved into the A80, the first to be offered as a commuter airliner. Introduced in 1964, the A80 had a redesigned nose and interior, increased wing span and a 227kg (500lb) greater takeoff weight. The pressurised 88 had round windows and the longer wingspan of the A80 and a 3992kg (8800lb) MTOW.

The Model B80 was the last major production model and appeared in 1966. It featured the longer span wing and the 88''s MTOW. The model A65 was essentially a Model 65 with the swept fin and rudder of the Model 80, and entered production in 1967. The Model 70 entered production in 1969, it featured the longer span wings, 3720kg (8200lb) MTOW and 255kW (340hp) engines. Production of the Queen Air ceased in 1977.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Beech 77 Skipper',56382153.0,'img/0294521-v40-6.jpg',' Beech developed the Skipper as a low expense two seat trainer in response to the growing costs (mainly fuel) of pilot training in the mid 1970s.

Starting life as the Beech PD (for Preliminary Design) 285, the new Skipper was intended to be a simple and cost effective new generation pilot training aircraft combining low purchasing and operating costs with lightweight but sturdy construction. A PD-285 prototype first flew on February 6 1975, but this differed from production aircraft in that it was powered by a 75kW (100hp) Continental O-200 engine and featured a conventional low set tailplane.

Protracted development meant that the first of the definitive Model 77 Skippers did not fly until September 1978, by which time the 85kW (115hp) Lycoming O-235 engine and T-tail had been settled upon. In the Beech product line-up the Skipper was to replace the two seat Model 19 Sport variant of the Musketeer family, production of which ended in 1978.

US FAA certification for the Skipper was awarded in April 1979, and the first production aircraft were delivered in May 1979 to Beechcraft''s own Beech Aero Center pilot training centres.

Production lasted just three years until mid 1981 (at the time Beech said the halt in production was a "suspension" pending an improvement in market conditions). During that time little more than 300 Skippers had been built (at a rate of about 10 per month). Unsold Skipper stocks kept the type available for a further year.

The Skipper was in direct competition with Piper''s very successful PA-38 Tomahawk and Cessna''s 152. The Tomahawk was developed in a very similar time scale to the Skipper (entering service in early 1978) and both aircraft share a T-tail, low wing and canopy style cabin configuration (with 360° all round vision and a door on each side), and the Lycoming O-235 powerplant. Of the three the Skipper was the least successful, being comfortably outsold by the Cessna and Piper products.

Other features of the Skipper design are a NASA developed GA(W)1 high lift wing (the result of joint NASA and Beech research into high lift, supercritical aerofoils), bonded metal construction, tubular spars, and flap and aileron actuation by torque tubes rather than the more conventional cable and pulley system. New construction techniques were intended to reduce manufacturing costs.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Beech 18',77219774.0,'img/0623348-v40-6.jpg',' Beech''s most successful airliner, more than 9000 Beech 18s were built over an uninterrupted three decade long production run, and while many of those were built against wartime military contracts, vast numbers went on to see civil service.

The prototype Beech 18 first flew on January 15 1937. The design followed conventional design wisdom at the time, including twin radial engines, metal construction and taildragger undercarriage, while less common were the twin tail fins. Early production aircraft were either powered by two 225kW (300hp) Jacobs L6s or 260kW (350hp) Wright R760Es. The Pratt & Whitney Wasp Junior became the definitive engine from the prewar C18S onwards.

The demands of World War 2 significantly boosted the already successful Beech 18''s fortunes, with 5000 built as C45s for the US Army Air Force for use as transports and multi engine pilot trainers.

Postwar, large numbers of C45s entered civil service, while Beech resumed production of the C18S. Progressive development resulted in the D18S of 1946, the Continental powered D18C of 1947, the E18S of 1954, the G18S from 1959 and the H18 with optional tricycle undercarriage from 1962. Beech production ceased in 1969.

The Beech 18 has also been the subject of numerous conversions. Volpar has offered tricycle undercarriage conversions, conversions with TPE331 turboprops and stretched and TPE331 powered conversions (described in the specifications above). Hamilton meanwhile converted Beech 18s as Westwinds with Pratt & Whitney Canada PT6 turboprops and also offered stretches.

 ',' United States of America ');

INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Beagle B-121 Pup',80445255.0,'img/0242074-v40-6.jpg',' The Pup was one of two new designs to be produced by the British Executive and General Aviation Ltd or Beagle company, which was formed in October 1960 following the merger of Auster and Miles.

The Pup evolved from the Miles M-117 project, which was to have made extensive use of plastics. A range of (conventional construction) Pups was planned, from a 75kW (100hp) two seat trainer through to retractable undercarriage four seaters, a light twin and a fully aerobatic 155kW (210hp) military trainer, the Bull Pup. All would have featured metal construction.

The Pup made its first flight on April 8 1967 and deliveries of the initial Pup 100 began a year later in April 1968. The Pup is one of the few light aircraft to feature control sticks and not control columns.

In the meantime Beagle had flown the first of the more powerful Pup 150s in October 1967. The 150 featured a 110kW (150hp) engine, as the designation reflects, and seating for an extra adult.

Another more powerful variant originally designed in response to an Iranian Civil Air Training Organisation requirement was the Pup 160. The Pup 160 featured a 120kW (160hp) IO-320 Lycoming, but only nine were built.

Continuing financial difficulties finally forced Beagle to close its doors in January 1970 after building 152 Pups, despite holding orders for an additional 276. As a result plans for the extended Pup based family came to nought. A further 21 near complete were subsequently assembled.

The B-125 Bulldog military basic trainer development first flew in May 1969. Scottish Aviation (which took over the design following Beagle''s collapse) built 328 150kW (200hp) Lycoming IO-360 powered Bulldogs for a number of air forces, including Britain''s Royal Air Force. Scottish Aviation became part of British Aerospace in the late 1970s.





 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Beech 19/23/24 Musketeer/Sierra/Sport/Sundowner',23796989.0,'img/0909161-v40-6.jpg',' Beechcraft developed the Musketeer family as a lower cost, lower performance four seater below its Bonanza, which would compete with the Cessna 172 and Piper Cherokee.

The prototype O-320 powered Musketeer flew in October 1961 and Beech added the type to its sales range in 1962. A series of continual product updating followed, resulting in the aircraft in its final Sierra form being very different to the original Musketeer. The first improved model was the A23 Musketeer II with a 125kW (165hp) Continental IO346 engine (later replaced with a Lycoming O360 in the B23).

The A23 was further developed into a three aircraft family (dubbed the Three Musketeers by Beech marketing) - the A23A Musketeer Custom III with greater max takeoff weight, the reduced MTOW A2319 Musketeer Sport III trainer with a 110kW (150hp) Lycoming O320, and the 150kW (200hp) IO360 powered and increased MTOW Musketeer Super III. From 1970 these three introduced a more rounded fuselage and were renamed the Musketeer B19 Sport, C23 Custom and A24 Super respectively.

A retractable undercarriage variant of the Super is the A24R Super R. The Musketeer name was dropped in 1971, with the Custom renamed the Sundowner, and Super R the Sierra, and the Musketeer Sport becoming simply the Sport. The Sierra underwent significant changes for the 1974 model with a new cowling, quieter engine and more efficient prop. Further aerodynamic clean ups were introduced in 1977. Series production ended in 1983.





 International Directory of Civil Aircraft



 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Bell 222 & 230',24181443.0,'img/0517587-v40-6.jpg',' Bell announced development of the all new 222 twin in 1974, following the positive response generated by a mockup proposal displayed at that year''s Helicopter Association of America convention.

Having taken note of potential customers'' preferences and suggestions, Bell modified its design accordingly, and the subsequent development effort led to the Model 222''s first flight in August 1976. A number of advanced features were designed into the 222, including the Noda Matic vibration reduction system developed for the 214ST, stub wings housing the retractable undercarriage, provision for IFR avionics, and dual hydraulic and electrical systems.

The 222 was awarded FAA certification in December 1979. Production deliveries commenced in early 1980. Subsequent development led to the more powerful 222B with a larger diameter main rotor, introduced in 1982, and the essentially similar 222UT Utility Twin, which features skid landing gear in place of wheels.

The Bell 230 is a development of the 222 with two Allison 250 turboshafts instead of the 222''s LTS 101s plus other refinements. First flight of a 230, a converted 222, took place on August 12 1991, and Transport Canada certification was awarded in March 1992. The first delivery of a production 230 occurred that November and customers had a choice of skid or wheel undercarriage. Production ceased in 1995. The 230 has been replaced by the stretched, more powerful 430, described separately.

 ',' Canada and United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Boeing 737-300',42916094.0,'img/1179344-v40-6.jpg',' The 737-300 is the first of the three member second generation CFM56 powered 737 family, which also comprises the stretched 737-400 and shortened 737-500. The success of the second generation Boeing 737 family pushed sales of the mark to over 3000, a record for a commercial jetliner.

Boeing announced it was developing the 737-300 in March 1981. This new variant started off as a simple stretch over the 737-200 but Boeing decided to adopt the CFM International CFM56 high bypass turbofan (jointly developed by General Electric and SNECMA) to reduce fuel consumption and comply with the then proposed International Civil Aviation Organisation Stage 3 noise limits.

Despite the all new engines and the 2.64m (104in) fuselage stretch, the 737-300 retains 80% airframe spares commonality and shares the same ground handling equipment with the 737-200. A number of aerodynamic improvements were incorporated to further improve efficiency including modified leading edge slats and a new dorsal fin extending from the tail. Another feature was the flattened, oval shaped engine nacelles, while the nosewheel leg was extended to increase ground clearance for the new engines. Other internal changes include materials and systems improvements first developed for the 757 and 767 programs, including an early generation EFIS flightdeck (with four colour CRT screens).

The 737-300 flew for the first time on February 24 1984, while first deliveries were from November 1984. Since that time well over 1000 737-300s have been sold and it forms the backbone of many airlines'' short haul fleets.

The stretched 737-400 and shortened 737-500 are described separately.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('BAE Systems Avro RJX85/100',27575109.0,'img/0648594-v40-6.jpg',' The Avro RJX range is a modernised development of the Avro RJ family, with the key change being new Honeywell AS977 powerplants which promised greater range, improved fuel burn and lower maintenance costs.

British Aerospace Regional Aircraft (later BAE Systems Regional Aircraft) announced it was conditionally offering the improved RJX range on February 16 1999 at the Avalon Airshow (near Melbourne, Australia). At the same time British Aerospace announced the selection of the Honeywell AS977 turbofan. At that stage certification was planned for December 2000 and service entry in May 2001.

The RJX was formally launched on March 21 2000 (somewhat later than envisaged when the program was announced). Assembly of the first RJX, an RJX85, began before formal launch in March 2000, and the first flight was made April 28 2001. The RJX100 followed with the first flight made on September 23 2001.

The RJX''s AS977 powerplant is a two spool design with dual FADEC, and compared with the LF-507 of the Avro RJ it replaces, it claimed to produce 5% more thrust in the climb, 15% lower fuel burn, 20% lower direct engine operating costs, lower emissions, and even quieter noise levels. The RJXs would have an up to 17% range increase and a 227kg (500lb) empty weight reduction over the RJs.

Like the earlier Avro RJ and BAe-146, the RJX family was offered in three sizes, the 70 seat RJX70, 85 seat RJX85 and 100 seat RJX100. The airframes are unchanged from the corresponding RJ models apart from the engine nacelles and pylons (supplied by GKN Westland). BAE Systems calls the engine, nacelle, pylon and associated accessories package the IPPS (Integrated Power Plant System). Like the RJ, the RJX was also offered as the Avro Business Jet.

However, in the wake of BAE Systems'' post September 11 concerns of poor sales prospects, the whole RJX program was cancelled on November 27 2001. Only one RJX85 and two RJX100s had flown by then. The RJX85 was parted out at Woodford, and the prototype RJX100 was transferred to the Heritage Aircraft Park at Manchester airport, and the fuselage of the second one became stored at Woodford. Some incomplete aircraft were scrapped. Just 14 aircraft had been ordered prior to program cancellation.




   ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('BAC 111 One-Eleven',65490485.0,'img/0310095-v40-6.jpg',' The One-Eleven can trace its origins back to the proposed Hunting H-107 jet airliner project of 1956.

Protracted development followed, but by 1961, when Hunting had been absorbed into British Aircraft Corporation (BAC), a larger Rolls-Royce Spey turbofan powered design was finalised.

British United Airways placed a launch order for 10 of the new jets, then known as the BAC-111, in May 1961. The new aircraft took to the skies for the first time on August 20 1963, while the first production Series 200 first flew on December 19 1963. Certification was eventually awarded on April 6 1965, following a troubled flight test program, during which one prototype crashed with the loss of its crew, the cause attributed to deep stall from the rear engine and the T-tail configuration. With the deep stall issue resolved, the BAC-111 entered service on April 6 1965.

Development of the basic Series 200 led to the higher weight Series 300, followed by the Series 400 designed for American requirements with a higher US equipment content.

The Series 500 introduced a 4.11m (13ft 6in) stretched fuselage and lengthened wings and greater seating capacity for up to 119 passengers. It first flew (converted from a -400) on June 30 1967. The Series 475 was optimised for hot and high operations and combined the Series 500''s more powerful engines with the earlier shorter length fuselage.

The last UK built One-Eleven (by this time a British Aerospace product) flew in 1982, by which time production was progressively being transferred to Bucuresti in Romania where nine were built as the Rombac 1-11.

In the mid 1990s Bucuresti was working on a Rolls-Royce Tay 650 powered development called the Airstar 2500. The Airstar was planned to fly in late 1996 but the program has been suspended.

In the USA, Dee Howard converted two Srs 400 to Tay powered Srs 2400.





  ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Beech 2000 Starship 1',46734073.0,'img/0602060-v40-6.jpg',' Despite its extensive use of modern technologies and innovative design the Starship was a commercial failure.

Conceived as a new generation light corporate transport in the King Air class, the Starship traces back to the 85% scale proof of concept demonstrator built by Scaled Composites, which first flew in August 1983. The prototype Starship 2000 proper made its first flight on February 26 1986, provisionally powered by PT6A65 turboprops. A second prototype equipped with Collins avionics entered the flight test program in June 1986, while a third development aircraft took flight in January 1987. Initial US FAA certification was awarded on June 14 1988, while the first production example was flown on April 25 1989.

The unconventional Starship design incorporates many innovations. Foremost of these is its rear mounted laminar flow wing and variable geometry canards or foreplanes. The foreplanes sweep forward with flap extension for pitch trim compensation, designed to make it impossible for the Starship to stall on takeoff or landing.

The wing itself is constructed almost entirely of composites (something which attracted much criticism because of the associated difficulties of inspecting it thoroughly), and has tip mounted tails. The rear mounted engines are in a pusher arrangement, being behind the cabin noise is reduced, while their relatively close proximity to each other also improves single engine handling. The EFIS flightdeck has Collins avionics with early generation colour and monochrome CRTs.

The improved Starship 2000A was certificated in April 1992. It introduced changes including seating for six instead of eight, a slightly higher max takeoff weight and increased range.

A lack of customer interest forced Beech to terminate Starship production in early 1995 after just 53 had been built (including three prototypes), a somewhat inglorious end to a technologically innovative and promising design.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Beagle B-206',34472456.0,'img/0592376-v40-6.jpg',' The cabin class Beagle B.206''s origins lie in a late 1950s Bristol project for a four seat twin.

Although not built, the Bristol 220 evolved into one of Beagle''s first and few designs to reach production. The prototype of the new twin engine design, known as the B.206X, made its first flight on August 15 1961. A five/six seater powered by two 195kW (260hp) Continental IO470 engines, it was considered too small by its creators, and the design grew into the B.206Y with 230kW (310hp) Continental GIO470 engines, greater wing span, a larger cabin with increased seating capacity, greater fuel capacity and increased weights.

This allowed it to meet a Royal Air Force requirement for a communications aircraft capable of transporting a Vbomber support crew. Twenty were ordered for this role in place of the originally planned buy of 80, selected in preference to the de Havilland Dove. In RAF service the B.206 was designated the CC.1 Basset. Basset deliveries began in May 1965.

Following the B.206Y were two evaluation B.206Z aircraft, then the initial civil production version, the Series 1 B.206C. Poor hot and high performance was in part responsible for slow sales and so Beagle designed the Series 2 B.206S with more powerful turbocharged GTSIO520 engines. The B.206S also introduced a slightly revised cabin to seat eight with the entry door repositioned from above the wing to the rear port side fuselage.

A commuter airliner development was also built in prototype form, the 10 seat Series 3 which a featured a further enlarged cabin. Flown in prototype form, the design died when Beagle entered liquidation in early 1970.

 ',' United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Airbus A330-200',73454864.0,'img/1237863-v40-6.jpg',' The A330-200 is the newest member of Airbus'' widebody twinjet family and is a long range, shortened development of the standard A330, developed in part as a replacement for the A300-600R and a competitor to the 767-300ER.

Airbus launched development of the A330-200 in November 1995, followed by the first customer order, for 13 from ILFC, placed in February 1996. First flight was on August 13 1997, with certification and first customer deliveries,to ILFC/Canada 3000, in April 1998.

The A330-200 is based on the A330-300 and shares near identical systems, airframe, flightdeck and wings, the only major difference being the fuselage length. Compared with the 300 the A330-200 is 10 frames shorter, and so has an overall length of 5.00m (193ft 7in), compared with 63.70m (209ft 0in) for the standard length aircraft. This allows the A330-200 to seat 256 passengers in a three class configuration, or alternatively 293 in two classes.

Because of its decreased length the A330-200 features enlarged horizontal and vertical tail surfaces (to compensate for the loss of moment arm with the shorter fuselage). Another important change is the addition of a centre fuel tank, which increases the A330-200''s fuel capacity over the 300''s, and results in the 200''s 11,850km (6400nm) range.

Like the A330, engine options are the GE CF6-80, Pratt & Whitney 4000 series and the RollsRoyce Trent 700.

The A330-200 has sold quite strongly since its launch. Among the initial A330-200 customers are, apart from ILFC, Canada 3000, Korean Air, Austrian, Air Transat, Emirates, Swissair, Sabena, Monarch, Asiana, TAM, and Air Lanka.

 ',' European consortium ');

INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Airbus A340-200/300',67393321.0,'img/0224578-v40-6.jpg',' The A340-200 and 300 are the initial variants of the successful quad engined A340 family of long haul widebodies.

The A340 and closely related A330 were launched in June 1987, with the A340''s first flight occurring on October 25 1991 (an A340-300). The A340 entered service with Lufthansa and Air France in March 1993, following JAA certification the previous December.

The A340 shares the same flightdeck including side stick controllers and EFIS, plus flybywire, basic airframe, systems, fuselage and wing with the A330 (the flightdeck is also common to the A320 series). Power is from four CFM56s, the four engine configuration being more efficient for long range flights (as twins need more power for a given weight for engine out on takeoff performance) and free from ETOPS restrictions.

The A340-300 has the same fuselage length as the A330-300, while the shortened A340-200 trades seating capacity for greater range (first flight April 1 1992).

The heavier A340-300E is available in 271,000kg (597,450lb) and 275,000kg (606,275lb) max takeoff weights, their typical ranges with 295 passengers are 13,155km (7100nm) and 13,525km (7300nm) respectively. Power for these models is from 152.3kN (34,000lb) CFM56-5C4s (the most powerful CFM56s built). The first A340-300Es were delivered to Singapore Airlines in April 1996.

The 275,000kg (606,275lb) max takeoff weight A340-8000 is based on the 200 but has extra fuel in three additional rear cargo hold tanks and offers a 15,000km (8100nm) range with 232 three class passengers (hence the A340-8000 designation). It too is powered by CFM56-5C4s. One has been built for the Sultan of Brunei.

All versions are offered with underfloor passenger sleepers.

 ',' European consortium ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Airbus A380',21414971.0,'img/0969902-v40-6.jpg',' The 555 seat, double deck Airbus A380 is the world''s largest airliner, easily eclipsing Boeing''s 747. The A380 base model is the 555 seat A380-800 (launch customer Emirates). Potential future models include the 590 ton MTOW 10,410km (5620nm) A380-800F freighter, able to carry a 150 tonne payload, and the stretched, 656 seat, A380-900.

Airbus first began studies on a very large 500 seat airliner in the early 1990s. The European manufacturer saw developing a competitor and successor to the Boeing 747 as a strategic play to end Boeing''s dominance of the very large airliner market and round out Airbus'' product line-up.

Airbus began engineering development work on such an aircraft, then designated the A3XX, in June 1994. Airbus studied numerous design configurations for the A3XX and gave serious consideration to a single deck aircraft which would have seated 12 abreast and twin vertical tails. However Airbus settled upon a twin deck configuration, largely because of the significantly lighter structure required.

Key design aims include the ability to use existing airport infrastructure with little modifications to the airports, and direct operating costs per seat 15-20% less than those for the 747-400. With 49% more floor space and only 35% more seating than the previous largest aircraft, Airbus is ensuring wider seats and aisles for more passenger comfort. Using the most advanced technologies, the A380 is also designed to have 10-15% more range, lower fuel burn and emissions, and produce less noise.

The A380 features an advanced version of the Airbus common two crew cockpit, with pull-out keyboards for the pilots, extensive use of composite materials such as GLARE (an aluminium/glass fibre composite), and four 302 to 374kN (68,000 to 84,000lb) class Rolls-Royce Trent 900 or Engine Alliance (General Electric/Pratt & Whitney) GP7200 turbofans now under development.
On July 24, 2000, Emirates became the first customer making a firm order commitment, followed by Air France, International Lease Finance Corporation (ILFC), Singapore Airlines, Qantas and Virgin Atlantic. Together these companies completed the 50 orders needed to launch the programme.

On receipt of the required 50th launch order commitment, the Airbus A3XX was renamed A380 and officially launched on December 19, 2000. The out of sequence A380 designation was chosen as the "8" represents the cross-section of the twin decks. In early 2001 the general configuration design was frozen, and metal cutting for the first A380 component occurred on January 23, 2002, at Nantes in France. In 2002 more than 6000 people were working on A380 development.

Apart from the prime contractors in France, Germany, the United Kingdom and Spain, components for the A380 airframe are also manufactured by industrial partners in Australia, Austria, Belgium, Canada, Finland, Italy, Japan, South Korea, Malaysia, Netherlands, Sweden, Switzerland and the United States. A380 final assembly is taking place in Toulouse, France, with interior fitment in Hamburg, Germany. Major A380 assemblies are transported to Toulouse by ship, barge and road.

On January 18, 2005, the first Airbus A380 was officially revealed in a lavish ceremony, attended by 5000 invited guests including the French, German, British and Spanish president and prime ministers, representing the countries that invested heavily in the 10-year, â�¬10 billion+ ($13 billion+) aircraft program, and the CEOs of the 14 A380 customers, who had placed firm orders for 149 aircraft by then.

Later, the following companies also ordered the A380: FedEx (the launch customer for the A380-800F freighter), Qatar Airways, Lufthansa, Korean Air, Malaysia Airlines, Etihad Airways, Thai Airways and UPS.

However, in 2007, amid production delays, Airbus announced that it was halting design work on the A380 freighter to concentrate on the passenger version of the aircraft.  FedEx and UPS canceled their orders for the aircraft.

Five prototypes were used in the flight test programme, which was heavily delayed due to problems with configuration management and wiring issues. The first flight occurred in August 2006, and entry into commercial service, with Singapore Airlines, took place in October 2007. ',' France, Germany, Spain, and United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Airbus A340-500/600',67693351.0,'img/0281999-v40-6.jpg',' The 15,740km (8500nm) ultra long range A340-500 and stretched 372 seat A340-600 are new variants of the Airbus A340 family, and are currently the world''s longest range airliners.

Compared with the A340-300, the A340-600 features a .07m (35ft 1in) stretch (5.87m/19ft 3in ahead of the wing and 3.20m/10ft 6in behind), allowing it to seat 372 passengers in a typical three class arrangement. This gives Airbus a true early model 747 replacement and near direct competitor to the 747-400, with similar range, but, Airbus claims, better operating economics (per seat).

The A340-500 meanwhile is stretched by only 3.19m (10ft 6in) compared with the A340-300, and so seats 313 in three classes, but it has a massive range of 15,740km (8500nm), which makes it the longest ranging airliner in the world, capable for example of operating Los Angeles-Singapore nonstop.

The two new A340 models share a common wing. The wing is based on the A330/A340''s but is 1.6m (5.2ft) longer and has a tapered wingbox insert, increasing wing area and fuel capacity. Both models feature three fuselage plugs. The other change to the A340 airframe is the use of the A330-200 twin''s larger fin and enlarged horizontal area stabilisers. To cope with the increased weights the centre undercarriage main gear is a four wheel bogie, rather than a two wheel unit.

Both new A340s have a high degree of commonality with the A330 and other A340 models. They feature Airbus'' common two crew flightdeck, but with some improvements such as LCD rather than CRT displays and modernised systems.

The A340-500 is powered by four 236kN (53,000lb) thrust Rolls-Royce Trent 556 turbofans, and the A340-600 by the 249kN (56,000lb) thrust Trent 556.

The commercial launch for the A340-500/600 was at the 1997 Paris Airshow, the program''s industrial launch was in December that year when Virgin Atlantic ordered eight A340-600s and optioned eight. First flight of the A340-600 was made on April 23, 2001. After a 1600 hour flight test program, certification was received on May 29, 2002. Virgin Atlantic took delivery of its first A340-600 at the 2002 Farnborough International Airshow, and began commercial services in August.

The A340-500 made its first flight on February 11, 2002, and was certificated on December 3 after 400 hours of flight test.



 ',' European consortium ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Airbus A330-300',73454874.0,'img/0170629-v40-6.jpg',' The A330-300 is the biggest member of Airbus'' twinjet family and is closely related to the four engined long range A340 with which it shares near identical systems, airframe, flightdeck and wings, the only major difference being the twin (versus four) engine configuration.

The A340 and A330 were launched simultaneously in June 1987. Although developed in parallel the A330-300 made its first flight after the A340, on November 2 1992. It was the first aircraft to achieve simultaneous European Joint Airworthiness Authorities (JAA) and US FAA certification, on October 21 1993. Entry into service took place by the end of that year.

Differences from the A340 aside from the number of engines are slight changes to the wing and internal systems, including fuel tankage. The A330 (like the A340) takes advantage of a number of technologies first pioneered on the A320, including the common advanced EFIS flightdeck with side stick controllers and flybywire computerised flight control system.

While the standard A330-300 shares the same fuselage length as the A340-300, Airbus has studied various stretched (A330-400) and shortened (A330-100 and 200) versions. The shortened A330-200 was formally launched in 1996 as a long range 767-300ER competitor, and is described separately. One stretched, high capacity concept studied for a time featured lower deck seating in place of the forward freight hold.

 ',' European consortium ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Antonov An-12 & Shaanxi Y-8',32488942.0,'img/0247509-v40-6.jpg',' The An-12 (NATO reporting name "Cub") was developed to fulfil a Soviet air force requirement for a turboprop freighter. Based on the twin turboprop An-8 which was developed for Aeroflot service, the four engine An-12 was developed in parallel with the commercial passenger An-10.

The prototype An-12 flew in 1958, powered by Kuznetsov NK-4 turboprops, and was essentially a militarised An-10 with a rear loading cargo ramp. Approximately 100 An-10s were built, the type seeing service between 1959 and 1973.

Series production of the An-12 in a number of mainly military variants continued until 1973, from which time it was replaced in Soviet service by the Ilyushin Il-76 (described elsewhere). The An-12BP is the basic military transport version of the Cub. Other military versions are in use as Elint and ECM platforms.

The defensive rear gunner''s turret is faired over on civil An-12s. Operators have included Aeroflot, Cubana, LOT Polish Airlines and Bulair for civil and quasi military work.

China''s Xian began redesign work of the An-12 in 1969, but after the first prototype the program was transferred to Shaanxi. A number of Chinese versions were developed, including the civil variants Y-8B and Y-8C, the latter developed with cooperation from Lockheed, similar Y-8F-200, Y-8F livestock carrier and Y-8H aerial survey model.

 ',' Ukraine and China ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Airbus A319CJ',78348143.0,'img/0848195-v40-6.jpg',' The Airbus Corporate Jetliner, or A319CJ, is a long range corporate jet development of the A319 airliner which competes directly with the Boeing Business Jet and dedicated long range corporate jets such as the Bombardier Global Express and Gulfstream V.

Airbus launched the A319CJ at the 1997 Paris Airshow and the first A319CJ rolled out of Dasa''s Hamburg A319/A321 assembly hall in October 1998. The airframe was then due to be fitted with belly auxiliary fuel tanks and flight test instrumentation prior to making a first flight in May 1999. Certification is planned for mid 1999 with the first customer delivery due in November that year.

Unlike the Boeing Business Jet, which combines the 737-700''s airframe with the 737-800''s strengthened wing and undercarriage, the A319CJ is designed to be a minimum change development of the A319. This means, according to Airbus, that the A319CJ can be easily converted to an airliner, thus increasing the aircraft''s potential resale value.

The first A319CJ is powered by IAE V2500s but CFM56s are also available, while the A319''s containerised cargo hold means that the CJ''s auxiliary fuel tanks can be easily loaded and unloaded, giving operators flexibility to reconfigure the aircraft for varying payload/range requirements. Like the rest of the A320 single aisle family (plus the A330 and A340), the A319CJ shares Airbus'' common advanced six screen EFIS flightdeck with sidestick controllers, plus fly-by-wire flight controls.

At mid 2002 Airbus had selected five cabin outfitters for the aircraft - among which Lufthansa Technik in Germany, Jet Aviation of Switzerland, and Air France Industries. Airbus will supply green A319CJ airframes to the outfitters for interior fitment. Interiors weigh around 3.8 tonnes (8500lb) and cost $US4-10m. Outfitting will typically take four to six months.

The first A319CJ order, announced in December 1997, was placed by a Kuwaiti individual. Among the later customers are the Italian, French, and Venezuelan Air Forces, Taiwan''s Eva Air, and Qatar Airways.

 ',' European consortium ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Airbus A321',21414965.0,'img/0220261-v40-6.jpg',' Like the shortened A319, the A321 is a minimum change, in this case stretched, development of the successful A320.

The A321 program was launched in November 1989 and the first development aircraft first flew on March 11 1993. European certification was awarded in December that year.

Compared with the A320 the A321''s major change is the stretched fuselage, with forward and rear fuselage plugs totalling 6.93m (22ft 9in) (front plug immediately forward of wing 4.27m/14ft, rear plug directly behind the wing 2.67m/8ft 9in).

Other changes include strengthening of the undercarriage to cope with the higher weights, more powerful engines, a simplified and refined fuel system and larger tyres for better braking. A slightly modified wing with double slotted flaps and modifications to the flight controls allows the A321''s handling characteristics to closely resemble the A320''s. The A321 features an identical flightdeck to that on the A319 and A320, and shares the same type rating as the smaller two aircraft.

The basic A321-100 features a reduction in range compared to the A320 as extra fuel tankage was not added to the initial design to compensate for the extra weight. To overcome this Airbus launched the longer range, heavier A321-200 development in 1995 which has a full pax transcontinental US range. This is achieved through higher thrust V2533-A5 or CFM56-5B3 engines and minor structural strengthening and 2900 litres (766US gal/638Imp gal) greater fuel capacity with the installation of an ACT (additional centre tank).

The A321-200 first flew from Daimler Benz (now DaimlerChrysler) Aerospace''s Hamburg facilities in December 1996.

 ',' European consortium ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Airbus A320',21414965.0,'img/0222979-v40-6.jpg',' Perhaps the most important contributor to Airbus Industrie''s success as an airliner manufacturer, the four member A320 family is a significant sales success and a technological trailblazer. The 150 seat A320 is the foundation and best selling member of the family.

The A320 is perhaps best known as the first airliner to introduce a fly-by-wire flight control system - where control inputs from the pilot are transmitted to the flying surfaces by electronic signals rather than mechanical means. Apart from a small weight saving, the advantage of Airbus'' fly-by-wire is that as it is computer controlled, an inbuilt flight envelope protection makes it virtually impossible to exceed certain flight parameters such as G limits and the aircraft''s maximum and minimum operating speeds and angle of attack limits.

Also integral to the A320 is the advanced electronic flightdeck, with six fully integrated EFIS colour displays and innovative sidestick controllers rather than conventional control columns. The A320 also employs a relatively high percentage of composite materials compared to earlier designs. Two engines are offered, the CFM56 and IAE V2500.

The A320 program was launched in March 1982, first flight occurred on February 22 1987, while certification was awarded on February 26 1988. Launch customer Air France took delivery of its first A320 in March that year. The first V2500 engined A320 was delivered to Adria Airways in May 1989.

The initial production version was the A320-100, which was built in only small numbers before being replaced by the definitive A320-200 (certificated in November 1988) with increased max takeoff weight, greater range and winglets. The stretched A321 and shortened A319 and A318 are described separately. All four share a common pilot type rating. Mid 2000 A320 family production was at a monthly rate of 22, to be increased to 30 units a month by the end of 2002.



 ',' European consortium ');

INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Airbus A319',21414965.0,'img/0222841-v40-6.jpg',' The A319 is one of the smaller members of Airbus'' highly successful single aisle airliner family currently in service, and competes with Boeing''s 737-300 and 737-700.

The A319 program was launched at the Paris Airshow in June 1993 on the basis of just six orders placed by ILFC late in 1992 and the predicted better prospects of the commercial airliner market, which were certainly realised. The first A319 airline order came from French carrier Air Inter (since merged into Air France), whose order for six was announced in February 1994. Since then Swissair, Air Canada, Lufthansa, Northwest, United, US Airways and British Airways are among the major customers that have ordered more than 500 A319s (all also operate or have on order A320s).

The A319 flew for the first time on August 25 1995 from Hamburg in Germany. European JAA certification and service entry, with Swissair, took place in April 1996.

The A319 is a minimum change, shortened derivative of the highly successful A320. The major difference between the A320 and A319 is that the latter is shorter by seven fuselage frames, while in almost all other respects the A319 and A320 are identical.

Like the A321, A330 and A340, the A319 features Airbus'' common two crew glass cockpit with sidestick controllers first introduced on the A320. There are significant crew training cost benefits and operational savings from this arrangement as the A319, A320 and A321 can all be flown by pilots with the same type rating, meaning that the same flightcrew pool can fly any of the three types. Further, the identical cockpit means reduced training times for crews converting to the larger A330 and A340. The A319 is said to have the longest range in this category of airliner.

Like the A321, A319 final assembly takes place in Hamburg with DaimlerChrysler Aerospace Airbus. Final assembly of all other Airbus airliners, including the A320, takes place at Toulouse.

The A319 forms the basis for the new baby of the Airbus family, the A318 100 seater (described separately), and the Airbus A319 Corporate Jetliner (also described separately).

 ',' European consortium ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Airbus A318',21414965.0,'img/0571781-v40-6.jpg',' The A318 will be Airbus'' smallest airliner and is the European manufacturer''s first foray into the 100 seat market.

Airbus'' initial efforts at developing a 100 seat airliner were focused on the all new AE31X program (covering the baseline 95 seat AE316 and 115-125 seat AE317) which Airbus and Alenia, as Airbus Industrie Asia, were developing in conjunction with AVIC of China and Singapore Technologies. The AE31X program arose out of earlier Chinese and South Korean studies for a 100 seater and a framework agreement covering its development was signed in May 1997. However on September 3 1998 Airbus announced termination of the project saying it was not economically viable.

The AE31X would have flown in mid 2002 and entered service in mid 2003. Final assembly would have been undertaken at Xian in China by Xian Aircraft Company.

Even before the cancellation of the AE31X program Airbus had been independently studying a minimum change 100 seat derivative of the A319 covered by the A319M5 designation (M5 = minus five fuselage frames). Following the AE31X''s cancellation Airbus announced the commercial launch of the A319M5 as the A318 at the 1998 Farnborough Airshow.

Airbus announced the A318''s industrial launch in April 1999, allowing full scale development to get underway, permitting service entry in late 2002. Program development cost is estimated at $US300m, and the list unit price $US36m.

Compared with the A319, the A318 is 4.5 frames shorter, reducing standard two class seating from 124 to 107. The A318''s other significant new feature will be its powerplant, the newly developed Pratt & Whitney PW-6000 (being developed in the 67-102kN/15-23,000lb thrust class), but the CFM International CFM56-5 is also available. Other changes will include a small dorsal fin added to the tail, modified wing camber, and a reduced size cargo door.

Otherwise the A318 will retain much commonality with the rest of the A320 family, including the advanced flightdeck with side stick controllers and fly-by-wire flight controls allowing a common type rating, and the same six abreast fuselage cross section.

The first flight was made on January 15, 2002 from Hamburg-Finkenwerder.

 ',' European consortium ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Agusta A-109',56781364.0,'img/0472879-v40-6.jpg',' The A-109 is a high performance twin helicopter, one of the most successful in its class during the course of its 25 year history.

The first of four A-109 prototypes flew on August 4 1971. VFR certification was awarded on June 1 1975 although series production had already begun in 1974. First production deliveries took place in late 1976. The helicopter was originally named Hirundo, but this name was later dropped. Single pilot IFR certification was granted in January 1977.

The base A-109A was superseded by the upgraded A-109A Mk.II from September 1981. Improvements incorporated in the Mk.II included a greater transmission rating, redesigned tailboom and a new tail rotor driveshaft, improved rotor blade life and modern avionics. The Mk.II is also available in widebody configuration with increased internal volume courtesy of bulged fuselage side panels and reshaped fuel tanks under the cabin floor. The Mk.II Plus has the more powerful 250-C20R1 engines, as does the A-109C. The 109C also has composite rotor blades.

The A-109K first flew in April 1983 and is powered by two 470kW (640shp) max continuous operation rated Turboméca Arriel 1K1 turboshafts. The latest A-109 model is the PW-206C powered (477kW/640shp takeoff rated) A-109E Power, which first flew on February 8 1995 and was certificated in August 1996. Based on the A-109K-2 it also features a strengthened landing gear and improved main rotor. The engines feature FADEC.

The A-109 has been developed into a number of mission specific configurations. Aside from executive transport it is used widely in medevac, police and patrol roles worldwide. Previously medevac configured A-109As were based on the standard airframe, but modifications engineered by the US firm Custom Aircraft Completions resulted in the A-109 Max, with transverse stretcher stowage and bulged side door transparencies.


 ',' Italy ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Air Tractor series',68556937.0,'img/0584597-v40-6.jpg',' The Air Tractor was designed by company founder Leyland Snow who earlier designed the Snow S-2 (built by Rockwell and Ayres).

The initial Air Tractor model was the Pratt & Whitney R-1340 radial powered AT-301 which established the Air Tractor series'' basic configuration. First flight was in 1973, and 600 were built. The PT6 turbine powered AT-302 introduced in 1977 was replaced by the AT-402. The R-1340 powered AT-401 introduced a greater span wing and increased chemical hopper capacity and first flew in 1986. The AT-402 is similar other than its 505kW (680shp) PT6A turboprop engine, the AT-402B has increased span wings.

The AT-502A (first flight Feb 1992) is based in the 402B but has a far more powerful 820kW (1100shp) PT6A-45R turbine driving a slow turning five blade prop. Its excess power reserves allow high speed or high altitude operations. The AT-502B has Hoerner wingtips and optional equipment including GPS.

The 5.4 tonne MTOW PT6 powered AT-602 first flew on December 1 1995 and became available for delivery in the second half of 1996.

The larger and heavier two seat AT-802 and single seat AT-802A are the largest purpose designed single engine ag aircraft in production. First flight was in October 1990. The AT-802F is a dedicated firefighting version.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Airbus A300-600',73424904.0,'img/0218546-v40-6.jpg',' The A300-600 development of the earlier A300B4 incorporated a number of significant improvements and refinements, foremost being a two crew flightdeck and increased range.

Apart from the two crew EFIS cockpit, with digital avionics based on that developed for the A310, changes included the A310''s tail empennage which increased freight and passenger payloads, small winglets (an option from 1989, standard from 1991), simplified systems, greater use of composites, Fowler flaps and increased camber on the wings, new brakes and APU, and improved payload/range through an extensive drag reducing airframe clean up and new engines. First flight for the A300-600 was on July 8 1983, the first airline delivery was in March 1984.

The A300-600 was further developed into the longer range A300-600R, its extended range courtesy of a fuel trim tank in the tailplane and higher maximum takeoff weights. First flight was on December 9 1987, first delivery was April 20 1988 (to American Airlines).

Convertible freight/passenger versions of all variants of the A300 have been offered, as has the all freight A300F4-600. The first new build pure freighter A300, one of 36 ordered for Federal Express, flew in December 1993. UPS is another major A300-600F customer, following its September 1998 order for 30. Airbus also offers conversion packages of existing passenger A300s into freighters with a left side forward freight door and strengthened floor.

 ',' France, Germany, Spain and United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Agusta A-119 Koala',81796226.0,'img/0221121-v40-6.jpg',' Agusta''s newest helicopter, the widebody A-119 Koala is a relatively large single turbine powered helicopter designed for a range of utility transport missions where it makes economic sense to operate a single when the redundancy of a twin is not required.

Agusta began development work on the Koala in 1994, leading to the first prototype''s maiden flight in early 1995. A second prototype flew later in that same year. Agusta originally aimed to gain certification for the A-119 in late 1996 but this was delayed until late 1998. One cause for the delay has been strong sales demand for the A-109E Power, another to enhance the A-119''s performance in response to customer feedback. Production deliveries are planned for 1999.

The Koala''s big selling feature is its large ''widebody'' fuselage. Agusta says the cabin is 30% larger than the cabins of any other current production single engine helicopter. A measure of the cabin size is that it can accommodate two stretcher patients in an EMS role, along with two medical attendants. Most other single engine helicopters typically are only equipped for a single stretcher because of a lack of space (Agusta sees medical retrieval operators as prime potential Koala customers).

Access to the main cabin is via two large sliding doors, one either side of the fuselage. A baggage compartment in the rear of the fuselage is also accessible in flight.

The first prototype Koala was powered by a Turboméca Arriel 1 turboshaft but it was subsequently reengined with a 747kW (1002shp) takeoff rated Pratt & Whitney Canada PT6B-37, which powered the second prototype and will feature in production aircraft. Another design feature is the Koala''s composite four blade main rotor which features a titanium fully articulated maintenance free hub with elastomeric bearings and composite grips.

 ',' Italy ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Aerospatiale-British Aerospace Concorde',96044915.0,'img/1148181-v40-6.jpg',' The Concorde first flew over 25 years ago, and yet it remains the pinnacle of civil aviation development for one reason - speed. The Concorde is the only aircraft in the world operating scheduled passenger flights at supersonic speed.

An engineering masterpiece, the Concorde was the result of a collaborative venture between the aviation industries of Britain and France. It dates back to design work for a supersonic airliner carried out by Sud Aviation and Bristol, their respective Super Caravelle and Bristol 233 designs being remarkably similar in configuration to each other. The forecast high costs of any SST program and the similarities in the designs led to a 1962 government agreement between France and Britain which resulted in the British Aircraft Corporation (into which Bristol had been merged) and SudAviation (which became a part of Aerospatiale in 1970) joining to design and develop such an aircraft.

Talks with airlines in the 1960s resulted in a relatively long range aircraft design capable of flying trans Atlantic sectors (although for a time Sud offered a short haul version). Design of the airframe was refined to feature a highly complex delta wing featuring cambering and ogival leading edges with pairs of engines mounted in pods under the wing undersurface. The slender fuselage features a high fineness ratio to keep supersonic drag to a minimum, while the fuel system was designed to trim the aircraft longitudinally by transferring fuel between tanks to combat the change in the centre of pressure as the aircraft accelerates. Another feature is the variable geometry nose which is lowered while taxying, on takeoff and landing to improve the flightcrew''s visibility.

A lengthy development program following the Concorde''s first flight on March 2 1969 meant that it did not enter into airline service until January 1976.

On May 30 2003 the last commercial Air France flight landed back at Paris Charles de Gaulle from New York. The very last flight for Air France was made on June 27 2003 when F-BVFC flew from Paris to its place of construction in Toulouse for preservation.

British Airways hoped to operate Concorde services well into the first decade of the new century, but will now terminate its supersonic services in October 2003.  ',' France and United Kingdom ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Aerospatiale SN-601 Corvette',54920406.0,'img/0355844-v40-6.jpg',' Although primarily a small corporate transport, Aerospatiale designed the Corvette to fulfil a variety or roles, including commuter airliner, aerial photography, airline pilot training, air ambulance, air taxi, express freight and navigation aid calibration work.

The Corvette was a commercial failure, and was Aerospatiale''s only venture into the executive jet market. The first prototype SN-600 first flew on July 16 1970, but only completed 270 hours of test and development flying before it crashed on March 23 the following year. This aircraft was powered by 9.8kN (2200lb) JT15D-1s.

The subsequent production version, the SN-601, had more powerful JT15D-4 turbofans and a stretched fuselage compared to the prototype. The first SN-601, or Corvette 100, made its maiden flight on December 20 1972. The second SN-601 Corvette (the first to full production standard) flew on March 7 1973, and a third on January 12 1974.

French civil certification for the Corvette was granted on May 28 1974. Customer deliveries, delayed by strikes at engine manufacturer Pratt & Whitney Canada (then UACL) began the following September.

Production of the Corvette continued until 1977. The initial production schedule called for 20 aircraft to be delivered in 1974 and production of six a month for 1975 and thereafter. However this proved an overly optimistic assessment of potential sales and only 40 were built (including development aircraft). Plans for a .08m (6ft 7in) stretched 18 seat Corvette 200 were also dropped.

Many early Corvette customers were French regional airlines (such as Air Alpes and Air Alsace), with others sold to corporate operators in Europe. Outside Europe however the type generated little sales interest in the face of very strong competition. Many of the Corvettes built remain in service today.

 ',' France ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Beech 60 Duke',6172672.0,'img/0803707-v40-6.jpg',' Between the Beech Baron and Queen Air in size, performance and general capabilities, the Duke was a pioneer in the pressurised high performance light business twin class.

Beechcraft began design work on its new Model 60 in early 1965, with the first flight of the prototype occurring the following year on December 29. US FAA Certification was awarded on February 1 1968.

Design features of the Duke include turbocharged Lycoming TIO541 engines driving three blade propellers and a 0.32 bars (4.6psi) cabin pressure differential. The airframe was based loosely on the Baron''s wing and undercarriage, plus a new fuselage employing bonded honeycomb construction. Optional fuel tanks in the wings were offered, increasing range.

Deliveries of the initial 60 model began in July 1968. Further development led to the improved A60. Appearing in 1970 it introduced an enhanced pressurisation system and longer life yet lighter turbochargers which increased the maximum altitude at which the engine could deliver maximum power, thus improving performance.

The definitive model of the Duke family is the B60. New interior arrangements and more improvements to the turbochargers were the main changes to this model, which first appeared in 1974. Production ceased in 1982.

Since its appearance the Duke has been regarded as something of a hot ship, with its high performance in a relatively small package the main attraction. However, this image did not translate into anything other than modest sales because of the Duke''s relatively complex systems (turbochargers and pressurisation among them) and high operating costs.

 ',' United States of America ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Aerospatiale SA-330 Puma',56229483.0,'img/0212952-v40-6.jpg',' The Aerospatiale (originally Sud) Puma is perhaps the most successful European built medium lift helicopter, and while most Pumas have been sold to military customers (largely for use as troop transports), a significant number are in commercial use.

The Puma was first designed to meet a French army requirement for a medium lift helicopter capable of operating in all weather conditions. The first of two Sud SA-330 prototypes flew for the first time on April 15 1965, with the first production aircraft flying in September 1968. In January 1970 Sud was merged into Aerospatiale. A 1967 decision by Britain''s Royal Air Force to order the Puma as its new tactical helicopter transport resulted in substantial Westland participation in the helicopter''s design and construction.

Early versions of the Puma were for military customers, including the SA-330B, C, E and H. The initial civil models were the Turmo IIIC powered SA-330F passenger and SA-330G freight versions, which became the first helicopters certificated for single pilot IFR operations in A and B conditions.

The SA-330J is the definitive civil Puma, and compared to the earlier F and G has composite main rotors and an increased maximum takeoff weight. The weather radar equipped J also became the first helicopter certificated for all weather operations including flight in icing conditions, awarded in April 1978.

IPTN of Indonesia assembled a small number of SA-330s before switching to the Super Puma. After Aerospatiale ceased production in 1987, the sole production source for the Puma became IAR (originally ICA) of Romania.

The AS-332 Super Puma is a stretched development, and is described separately under Eurocopter.

 ',' France ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Aerospatiale SA-341/342 Gazelle',45214267.0,'img/0604844-v40-6.jpg',' The Gazelle will be long remembered for being the first helicopter to introduce Aerospatiale''s (and now Eurocopter''s) trademark Fenestron shrouded tail rotor system.

While civil Gazelle use is not common, many are in service as personal or corporate transports. The Gazelle however is in widespread military service throughout the world, and a large number of military variants have been developed.

The Gazelle was designed by Sud as a replacement for the popular Alouette II series. Design features included the Alouette II Astazou''s powerplant and transmission system and enclosing the tail rotor within the tail for safety on the ground.

First flight of the original Sud SA-340 Gazelle prototype occurred on April 7 1967. This aircraft was powered by the Astazou III, which became the standard powerplant on the subsequent SA-341 production model, which flew for the first time on August 16 1971, when Sud had been merged into Aerospatiale.

Like the larger Puma the Gazelle was the subject of a 1967 agreement that has seen it jointly built by Westland in the UK and Aerospatiale in France.

Civil production Gazelles were designated SA-341G and powered by the Astazou IIIA. The SA-341G was the first helicopter to be certificated to be flown by one pilot under Cat I weather conditions, achieving this in January 1975. This was since upgraded to Cat II operations. Gazelles with their rear fuselage modified to allow an extra 20cm of rear legroom were known as Stretched Gazelles

Further development led to the SA-342 with the more powerful Astazou XIV and refined Fenestron design, giving the civil SA-342J a 100kg (220lb) increase in payload. The SA-342 became available from 1977.

Apart from Westland, the Gazelle was also produced by Soko (SA-341H and SA-342L Partizan) in the former Yugoslavia, and 30 SA-342L were assembled by ABHCo in Egypt.

 ',' France ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Aerospatiale SA-360/361/365C Dauphin',47579462.0,'img/0566912-v40-6.jpg',' The single engine SA-360 Dauphin and twin engine SA-365C Dauphin 2 were developed as replacements for the Alouette III.

The prototype SA-360 first flew on June 2 1972 and was powered by a 730kW (980shp) Turboméca Astazou XVI turboshaft. After 180 development flights a more powerful 785kW (1050shp) Astazou XVIIIA was substituted, and weights were fitted to the rotor tips to reduce vibration and to eliminate ground resonance. The first prototype flew in this new configuration on May 4 1973, following a second prototype built to the new standard which had flown for the first time that January. The first production aircraft, designated the SA-360C, flew in April 1975.

The SA-361 is a more powerful variant with improved hot and high performance and a greater payload capability. Although prototypes were built, the SA-361 was not taken into production. A military variant of the SA-361, the SA-361H, was offered fitted with up to eight HOT anti tank missiles, but was also not ordered into production.

The twin engine SA-365C Dauphin 2 meanwhile was announced in early 1973. First flight was on January 24 1975. It features twin Arriel turboshafts and a new engine fairing, a Starflex main rotor hub and a higher max takeoff weight. Production deliveries began in December 1978.

SA-360 and SA-365C production ceased in 1981 in preference for the much improved SA-365N (later AS-365N), described under Eurocopter.

 ',' France ');

INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Aerospatiale Alouette II & Lama',16661610.0,'img/0108610-v40-6.jpg',' Among the first turbine powered helicopters in the world, the Alouette II and Lama remain in service in fairly large numbers worldwide.

For a time the most successful western European helicopter in terms of numbers built, the Alouette II was based on the original Sud-Est SE-3120 Alouette which first flew on March 12 1955. Two prototypes were built and these were powered by Salmson 9 piston engines. Production deliveries of the turbine powered SE-3130 (around 1967 redesignated SE-313B) Alouette II occurred from 1957, the first machines bound for the French military. Civil certification was awarded on January 14 1958, although most Alouette II production was for military customers.

During production, Sud-Est became part of Sud in March 1957, and Sud was incorporated into Aerospatiale in January 1970. The Alouette II was soon followed by a more powerful Turboméca Astazou powered development. This aircraft was the SA-3180 (around 1967 renamed SA-318C) Alouette II Astazou, and flew for the first time on January 31 1961. Power was supplied by a 395kW (530shp) Astazou IIA derated to 270kW (360shp), which increased the type''s maximum speed and max takeoff weight, but otherwise the Alouette II and Alouette II Astazou were similar.

The SA-315B Lama was initially developed for the Indian Army as a utility helicopter with improved hot and high performance. Called Cheetah in Indian service, the Lama mated the Alouette''s airframe with the larger Alouette III''s dynamic components including Artouste IIIB engine. The Lama''s first flight was on March 17 1969. Aerospatiale built 407 through to 1989, while Hindustan (HAL) in India continues limited licence production as the SA-315B Cheetah, and seven were produced in Brazil as the Helibras HB-315B Gaviao.

 ',' France ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Aerospatiale Alouette III',74491318.0,'img/0324102-v40-6.jpg',' The Alouette III is an enlarged development of the Alouette II series, and was Aerospatiale''s most successful helicopter in terms of numbers built until the mid 1980s when surpassed by the Ecureuil.

Like the Alouette II, the Alouette III traces its development back to the Sud-Est SE-3120 Alouette piston powered prototypes, the first of which flew for the first time on July 31 1951. The largest member of the Alouette series, the III flew as the SE-3160 on February 28 1959. Compared with the Alouette II, the Alouette III is larger and seats seven, but in its initial form was also powered by the Turboméca Artouste turboshaft.

This initial SE-3160 Alouette III remained in production for almost a decade until 1969, when it was replaced by the improved SA-316B with strengthened transmission and a greater max takeoff weight, but the same Artouste III turboshaft.

Further development led to the SA-319 Alouette III Astazou, which as its name suggests is powered by a 450kW (600shp) Turboméca Astazou XIV turboshaft. The more powerful Astazou engine conferred better hot and high performance and improved fuel economy. The SA-319 entered production in 1968 as the SA-319B.

The SA-319B and SA-316B remained in production side by side through the 1970s and into the early 1980s. Hindustan (HAL) of India continues to licence build Alouette IIIs as the Chetak (first as SE-3160, later as SA-316B), mainly for that country''s military, but also for government and civil customers. ICA of Brasov in Romania licence built SA-316Bs as IAR-316Bs, and 60 SE-3160 were built in Switzerland by F+W Emmen. Other SE-3160 were assembled by Fokker and Lichtwerk in the Netherlands.

Like the Alouette II, the III has been used in a wide range of utility roles, and many armed military variants have been built.

 ',' France ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Aeronca 11 Chief',37373559.0,'img/0103944-v40-6.jpg',' The Aeronca 11 Chief, designed by Ray Hermes, was developed at the same time as the tandem seat Model 7 Champion, but it featured a wider cabin for side by side seating. The first flight was made in 1945, but the type was only shown publicly for the first time at the National Air Show in Cleveland in November 1946.

The Chief has a welded steel tube fuselage with fabric covering. A door on each side gives entry to the side by side cabin, and a baggage compartment is located behind the seats. Streamlined wheelpants were available as an option. Except for the fuselage, 80% of the parts are interchangeable with the Model 7 Champion.

The first version of the Chief was the 11AC, powered by a 48kW (65hp) Continental A-65-8F engine, and the Type Certificate was issued September 28 1945. A floatplane version on Edo Floats was certificated on July 22 1947 as the S11AC. The Chief was available in a "Standard" version, or as a fully-equipped "Deluxe" version. In 1947 a "Scout" version was added, which was a bare pilot trainer.

The 11BC had a more powerful 63kW (85hp) Continental C-85-8F engine and a large dorsal fin, and was also available as the float-equipped S11BC. These models were certificated respectively in August 1947 and September 1948.

The third version was the 11CC Super Chief with the same Continental C-85 engine, but with a little more room, improved styling, luxury equipment now included as standard, and some other improvements. The 11CC was certificated in May 1948, and its float-equipped equivalent, the S11CC, in October 1948.

In 1951 Aeronca stopped production of light aircraft, as the market for light aircraft was not profitable anymore and as they had large orders for Korean War equipment to fulfill.

E.J.Trytek acquired the rights for the Model 11, but did not build the Chief themselves. The 11CC was however licence-built in India as the Hindustan HUL-26 Pushpak with a 67kW (90hp) Continental C-90 engine. The first flight was made on September 28 1958, and the type was produced until 1968. A total of 154 were received by Indian flying clubs.

Eventually, Bellanca bought the Model 11 type certificate, and they used the model for developing a new trainer. They rebuilt a standard 11AC to the new model, but after a lengthy test period did not proceed further with the design.
 ',' United States of America ');


INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Aermacchi F-260',32981967.0,'img/0613687-v40-6.jpg',' The nimble SIAI-Marchetti SF-260 has sold in modest numbers to civil operators worldwide but is one of the most successful postwar two seat piston military trainers.

The SF-260 was designed by famed Italian aircraft designer Stelio Frati (who was responsible for a number of renowned light aircraft designs) in the early 1960s. It was originally flown in 185kW (250hp) Lycoming O-540 powered form by the Aviamilano company as the F-250. However until its takeover by Aermacchi in 1997 SIAI-Marchetti undertook all production (initially under licence, before later assuming full responsibility for the program) of the aircraft as the 195kW (260hp) O-540 powered SF-260. The second aircraft to fly was the first built by SIAI-Marchetti and the first powered by the more powerful version of the O-540. This second prototype first flew in 1966.

The initial civil production models were the SF-260 and SF-260A, and a number were sold in the USA as the Waco Meteor. In 1974 production switched to the SF-260B with improvements first developed for the military SF-260M, including a stronger undercarriage, a redesigned wing leading edge and a taller fin. The B was soon followed by the further improved SF-260C, with increased span wing.

While the SF-260 has been further developed into E and F forms these have been sold to military operators only. The 260kW (350shp) Allison (now Rolls-Royce) 250-B17D turboprop powered SF-260TP meanwhile has been built since the early 1980s, but it too has been sold only to military customers. Nevertheless Italian civil certification was awarded in October 1993, opening the door for possible civil sales.

In civil use the SF-260 is now regarded as something of a classic thoroughbred. Its clean aerodynamic lines, retractable undercarriage and relatively powerful engine guarantee spirited performance.

In 1997 Aermacchi took over SIAI-Marchetti and continues to market the aircraft as the F-260, with low rate production continuing against military orders.

 ',' Italy ');
INSERT INTO product(productName, productPrice, productDesc, productOrigin) VALUES ('AEA Explorer',66959116.0,' The AEA Explorer 350R is a nine-place Australian utility aircraft developed by Aeronautical Engineers Australia Research Pty Ltd (AEA). It is designed to fill a market gap between the Cessna 206 Stationair and the much larger Cessna 208 Caravan utility singles.

AEA''s managing director Graham Swannell first began looking at a new utility aircraft in the late 1980s, and initially considered developing a stretched and more powerful Cessna 206 conversion which would have been covered by a supplemental type certificate. But by 1993 Swannell had started design work on an all new aircraft, a 10 seater powered by an eight cylinder 300kW (400hp) Textron Lycoming IO-720. This design then evolved to become the Explorer 350R, a nine-seater powered by a Teledyne Continental TSIO-550 flat-six.

The 350R flew for the first time on January 23 1998. Apart from its TSIO-550 engine driving a three blade prop, design features include a metal frame fuselage with a carbonfibre shell, conventional all metal wings and tail surfaces and retractable undercarriage. The main undercarriage retraction system is uncommon - the legs, which are made from fibreglass, extend further downwards before crossing each other below the fuselage with the wheels coming to rest in pods on the opposite side of the fuselage - thus not intruding into the main cabin.

The aircraft''s basic configuration is optimised for its intended utility roles, with a high mounted, braced wing, rectangular and constant section, flat floor cabin, and large cabin windows.

The Explorer 350R will not be built in series, but is the proof-of-concept (POC) prototype for a family of utility aircraft. The 350R prototype was  converted to the 500T prototype, powered by a 600shp Pratt & Whitney PT6A-135B turboprop, and the first flight as such was made on June 9 2000. The 500T has seating for eleven (including the pilot) in a passenger configuration, and will be the entry level aircraft for the Explorer. A second production version will be the 500R, a 600hp Orenda OE-600A piston engine powered version of the 500T. A 2.21m (7ft 3in) stretched version is planned, the Explorer 750T, which will seat 17 (including the pilot), and will be powered by a 750shp Pratt & Whitney PT6A-60A turboprop.

On May 20 1999 the 350R left Australia for a promotional tour of the USA, and will now be further developed and taken into production in the United States by Explorer Aircraft Inc, located in Jasper, Texas.

 ',' Australia ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Airbus A300-600ST Super Transporter',35452008.0,'img/0163222-v40-6.jpg',' The A300-600ST Super Transporter was designed to replace Airbus Industrie''s Super Guppy transports, used by the consortium to ferry oversize components such as wings and fuselage sections between Airbus'' partners'' plants throughout western Europe.

Development of the A300-600ST, nicknamed Beluga and also Super Flipper, began in August 1991. The A300-600ST''s tight development program - for what in many ways is effectively a new aircraft - saw the transport rolled out in June 1994, with first flight on September 13 that year. The A300-600ST then entered a 400 hour flight test program which culminated in mid 1995, with certification awarded that September and with delivery and entry into service with Airbus in January 1996. All of the first four on order had been delivered by mid 1998 (allowing the Super Guppy''s retirement in October 1997). The fifth Super Transporter is scheduled to be delivered in 2001.

The A300-600ST is based on the A300-600 airliner, with which it shares the wing, lower fuselage, main undercarriage and cockpit. The main differences are obvious - a bulged main deck, new forward lower fuselage, new enlarged tail with winglets and an upwards hinging main cargo door. A design study of a similarly configured A340, the A340ST Mega Transporter, to carry A3XX components is underway.

Program management of the A300-600ST is the responsibility of the Special Aircraft Transport Company, or SATIC, an economic interest grouping formed on a 50/50 basis by Aerospatiale and DASA operating on behalf of Airbus Industrie. While much of the work on the aircraft is performed by the Airbus partners, other European companies are also involved in the program.

 ',' European consortium ');
INSERT INTO product(productName, productPrice, productImageURL, productDesc, productOrigin) VALUES ('Airbus A310',21414964.0,'img/0218549-v40-6.jpg',' The A310 first began life as the A300B10, one of a number of projected developments and derivatives of Airbus'' original A300B airliner.

While based on the larger A300, the A310 introduced a number of major changes. The fuselage was shortened by 13 frames compared to the A300B, reducing seating to around 200 to 230 passengers and a new higher aspect ratio wing of smaller span and area was developed. New and smaller horizontal tail surfaces, fly-by-wire outboard spoilers and a two crew EFIS flightdeck were incorporated, while the engine pylons were common to suit both engine options.

The first flight of the A310 occurred on April 3 1982, after the program was launched in July 1978. Service entry was with Lufthansa in April 1983. Early production A310s did not have the small winglets that became a feature of later build A310-200s and the A310-300. The A310-300 is a longer range development of the base A310-200, and has been in production since 1985. This version can carry a further 7000kg (15,430lb) of fuel in the tailplane.

The A310-200F freighter is available new build or as a conversion of existing aircraft (13 A310s were converted to freighters for Federal Express by Airbus partner Daimler Benz [now DaimlerChrysler] Aerospace Airbus). The A310-200C convertible passenger/freighter first entered service with Dutch operator Martinair in 1984.

 ',' European consortium ');


INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 1));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 2));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 3));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 4));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 5));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 6));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 7));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 8));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 9));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 10));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (11, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 11));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (12, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 12));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (13, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 13));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (14, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 14));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (15, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 15));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (16, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 16));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (17, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 17));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (18, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 18));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (19, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 19));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (20, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 20));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (21, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 21));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (22, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 22));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (23, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 23));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (24, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 24));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (25, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 25));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (26, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 26));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (27, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 27));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (28, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 28));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (29, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 29));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (30, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 30));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (31, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 31));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (32, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 32));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (33, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 33));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (34, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 34));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (35, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 35));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (36, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 36));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (37, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 37));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (38, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 38));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (39, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 39));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (40, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 40));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (41, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 41));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (42, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 42));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (43, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 43));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (44, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 44));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (45, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 45));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (46, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 46));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (47, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 47));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (48, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 48));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (49, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 49));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (50, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 50));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (51, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 51));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (52, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 52));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (53, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 53));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (54, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 54));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (55, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 55));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (56, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 56));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (57, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 57));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (58, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 58));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (59, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 59));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (60, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 60));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (61, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 61));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (62, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 62));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (63, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 63));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (64, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 64));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (65, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 65));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (66, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 66));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (67, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 67));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (68, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 68));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (69, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 69));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (70, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 70));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (71, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 71));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (72, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 72));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (73, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 73));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (74, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 74));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (75, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 75));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (76, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 76));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (77, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 77));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (78, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 78));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (79, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 79));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (80, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 80));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (81, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 81));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (82, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 82));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (83, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 83));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (84, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 84));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (85, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 85));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (86, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 86));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (87, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 87));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (88, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 88));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (89, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 89));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (90, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 90));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (91, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 91));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (92, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 92));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (93, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 93));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (94, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 94));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (95, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 95));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (96, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 96));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (97, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 97));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (98, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 98));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (99, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 99));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (100, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 100));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (101, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 101));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (102, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 102));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (103, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 103));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (104, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 104));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (105, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 105));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (106, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 106));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (107, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 107));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (108, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 108));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (109, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 109));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (110, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 110));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (111, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 111));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (112, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 112));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (113, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 113));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (114, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 114));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (115, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 115));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (116, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 116));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (117, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 117));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (118, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 118));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (119, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 119));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (120, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 120));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (121, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 121));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (122, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 122));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (123, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 123));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (124, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 124));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (125, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 125));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (126, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 126));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (127, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 127));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (128, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 128));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (129, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 129));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (130, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 130));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (131, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 131));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (132, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 132));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (133, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 133));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (134, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 134));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (135, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 135));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (136, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 136));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (137, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 137));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (138, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 138));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (139, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 139));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (140, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 140));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (141, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 141));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (142, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 142));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (143, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 143));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (144, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 144));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (145, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 145));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (146, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 146));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (147, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 147));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (148, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 148));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (149, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 149));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (150, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 150));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (151, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 151));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (152, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 152));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (153, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 153));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (154, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 154));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (155, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 155));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (156, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 156));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (157, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 157));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (158, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 158));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (159, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 159));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (160, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 160));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (161, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 161));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (162, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 162));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (163, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 163));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (164, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 164));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (165, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 165));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (166, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 166));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (167, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 167));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (168, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 168));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (169, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 169));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (170, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 170));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (171, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 171));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (172, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 172));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (173, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 173));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (174, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 174));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (175, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 175));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (176, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 176));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (177, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 177));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (178, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 178));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (179, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 179));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (180, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 180));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (181, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 181));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (182, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 182));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (183, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 183));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (184, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 184));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (185, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 185));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (186, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 186));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (187, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 187));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (188, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 188));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (189, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 189));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (190, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 190));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (191, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 191));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (192, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 192));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (193, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 193));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (194, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 194));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (195, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 195));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (196, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 196));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (197, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 197));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (198, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 198));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (199, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 199));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (200, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 200));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (201, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 201));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (202, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 202));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (203, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 203));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (204, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 204));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (205, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 205));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (206, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 206));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (207, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 207));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (208, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 208));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (209, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 209));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (210, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 210));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (211, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 211));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (212, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 212));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (213, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 213));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (214, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 214));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (215, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 215));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (216, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 216));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (217, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 217));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (218, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 218));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (219, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 219));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (220, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 220));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (221, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 221));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (222, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 222));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (223, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 223));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (224, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 224));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (225, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 225));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (226, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 226));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (227, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 227));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (228, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 228));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (229, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 229));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (230, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 230));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (231, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 231));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (232, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 232));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (233, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 233));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (234, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 234));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (235, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 235));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (236, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 236));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (237, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 237));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (238, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 238));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (239, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 239));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (240, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 240));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (241, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 241));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (242, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 242));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (243, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 243));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (244, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 244));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (245, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 245));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (246, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 246));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (247, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 247));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (248, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 248));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (249, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 249));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (250, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 250));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (251, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 251));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (252, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 252));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (253, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 253));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (254, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 254));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (255, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 255));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (256, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 256));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (257, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 257));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (258, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 258));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (259, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 259));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (260, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 260));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (261, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 261));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (262, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 262));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (263, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 263));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (264, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 264));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (265, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 265));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (266, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 266));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (267, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 267));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (268, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 268));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (269, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 269));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (270, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 270));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (271, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 271));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (272, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 272));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (273, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 273));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (274, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 274));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (275, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 275));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (276, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 276));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (277, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 277));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (278, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 278));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (279, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 279));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (280, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 280));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (281, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 281));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (282, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 282));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (283, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 283));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (284, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 284));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (285, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 285));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (286, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 286));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (287, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 287));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (288, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 288));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (289, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 289));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (290, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 290));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (291, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 291));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (292, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 292));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (293, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 293));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (294, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 294));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (295, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 295));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (296, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 296));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (297, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 297));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (298, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 298));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (299, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 299));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (300, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 300));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (301, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 301));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (302, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 302));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (303, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 303));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (304, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 304));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (305, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 305));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (306, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 306));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (307, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 307));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (308, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 308));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (309, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 309));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (310, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 310));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (311, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 311));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (312, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 312));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (313, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 313));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (314, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 314));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (315, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 315));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (316, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 316));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (317, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 317));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (318, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 318));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (319, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 319));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (320, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 320));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (321, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 321));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (322, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 322));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (323, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 323));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (324, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 324));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (325, 1, 5, 5*(SELECT productPrice FROM product WHERE productId = 325));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (326, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 326));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (327, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 327));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (328, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 328));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (329, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 329));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (330, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 330));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (331, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 331));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (332, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 332));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (333, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 333));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (334, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 334));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (335, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 335));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (336, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 336));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (337, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 337));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (338, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 338));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (339, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 339));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (340, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 340));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (341, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 341));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (342, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 342));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (343, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 343));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (344, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 344));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (345, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 345));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (346, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 346));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (347, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 347));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (348, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 348));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (349, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 349));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (350, 1, 3, 3*(SELECT productPrice FROM product WHERE productId = 350));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (351, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 351));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (352, 1, 9, 9*(SELECT productPrice FROM product WHERE productId = 352));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (353, 1, 8, 8*(SELECT productPrice FROM product WHERE productId = 353));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (354, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 354));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (355, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 355));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (356, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 356));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (357, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 357));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (358, 1, 10, 10*(SELECT productPrice FROM product WHERE productId = 358));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (359, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 359));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (360, 1, 2, 2*(SELECT productPrice FROM product WHERE productId = 360));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (361, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 361));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (362, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 362));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (363, 1, 4, 4*(SELECT productPrice FROM product WHERE productId = 363));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (364, 1, 1, 1*(SELECT productPrice FROM product WHERE productId = 364));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (365, 1, 6, 6*(SELECT productPrice FROM product WHERE productId = 365));
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (366, 1, 7, 7*(SELECT productPrice FROM product WHERE productId = 366));



INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2019-3-11', 6, 'My family can finally go on vacation!', 272);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2019-4-18', 2, 'My family can finally go on vacation!', 181);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2016-4-10', 7, 'Love taking this thing out on Sunday afternoons for a cruise.', 31);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2015-9-14', 1, 'Very economical', 219);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2015-5-15', 5, 'Melhor aviao do mundo, gostei da cor!', 42);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2015-4-3', 3, 'Love taking this thing out on Sunday afternoons for a cruise.', 90);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2017-7-24', 7, 'Spent all day flying my aircraft', 111);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2017-9-22', 10, 'Decently sized', 44);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2015-6-13', 8, 'Most reliable aircraft on the market', 320);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2017-4-19', 4, 'Decently sized', 360);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2018-8-15', 7, 'Love taking this thing out on Sunday afternoons for a cruise.', 237);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2019-11-26', 2, 'Love taking this thing out on Sunday afternoons for a cruise.', 186);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2016-4-4', 4, 'Now I never have to get stuck in traffic ever again', 97);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2017-9-30', 5, 'Worst company ever, they took away my dream plane just because my credit card got declined', 9);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2017-1-20', 4, 'My family can finally go on vacation!', 152);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2016-2-11', 5, 'Most reliable aircraft on the market', 104);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2016-3-7', 5, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 296);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2020-4-5', 3, 'Spent all day flying my aircraft', 181);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2020-1-22', 4, 'Decently sized', 113);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2019-4-21', 8, 'Melhor aviao do mundo, gostei da cor!', 174);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2019-7-22', 7, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 327);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2015-9-1', 10, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 333);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2015-7-9', 7, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 116);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2015-9-10', 5, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 210);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2020-9-15', 3, 'Very economical', 143);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2018-4-5', 3, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 235);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2015-11-23', 9, 'Best purchase EVER.', 89);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2019-9-12', 5, 'Decently sized', 194);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2016-2-6', 4, 'Worst company ever, they took away my dream plane just because my credit card got declined', 164);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2020-10-4', 6, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 49);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2020-3-9', 7, 'My family can finally go on vacation!', 242);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2016-3-28', 10, 'Melhor aviao do mundo, gostei da cor!', 257);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2020-11-12', 10, 'Really nice looking', 196);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2015-2-14', 7, 'Melhor aviao do mundo, gostei da cor!', 1);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2018-10-1', 7, 'Worst company ever, they took away my dream plane just because my credit card got declined', 170);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2015-1-30', 4, 'Now I never have to get stuck in traffic ever again', 62);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2016-9-26', 7, 'Worst company ever, they took away my dream plane just because my credit card got declined', 26);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2020-7-12', 2, 'Worst company ever, they took away my dream plane just because my credit card got declined', 302);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2018-11-14', 10, 'Really nice looking', 39);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2016-6-3', 6, 'I''m in love with my new aircraft!', 112);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2019-8-19', 2, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 25);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2018-5-8', 9, 'Best purchase EVER.', 81);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2019-8-7', 6, 'Spent all day flying my aircraft', 184);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2019-1-18', 6, 'Most reliable aircraft on the market', 125);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2018-3-21', 3, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 237);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2015-8-5', 2, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 212);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2018-2-4', 4, 'Spent all day flying my aircraft', 231);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2017-11-5', 3, 'Worst company ever, they took away my dream plane just because my credit card got declined', 74);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2018-5-15', 4, 'Spent all day flying my aircraft', 2);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2019-9-15', 5, 'Really nice looking', 145);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2020-7-17', 8, 'I''m in love with my new aircraft!', 216);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2018-10-1', 9, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 117);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2020-5-6', 5, 'Spent all day flying my aircraft', 85);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2016-7-17', 3, 'I''m in love with my new aircraft!', 236);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2018-9-8', 4, 'Decently sized', 349);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2016-11-30', 9, 'Melhor aviao do mundo, gostei da cor!', 153);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2020-11-20', 3, 'Worst company ever, they took away my dream plane just because my credit card got declined', 128);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2017-5-20', 2, 'Decently sized', 300);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2017-10-23', 1, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 58);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2015-11-28', 9, 'Now I never have to get stuck in traffic ever again', 352);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2020-4-4', 2, 'Now I never have to get stuck in traffic ever again', 222);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2018-3-15', 8, 'Best purchase EVER.', 186);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2018-8-28', 10, 'Love taking this thing out on Sunday afternoons for a cruise.', 77);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2019-6-13', 1, 'Decently sized', 109);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2020-4-28', 10, 'Melhor aviao do mundo, gostei da cor!', 174);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2019-4-23', 8, 'Decently sized', 161);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2016-6-25', 6, 'Very economical', 76);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2016-3-27', 8, 'Very economical', 360);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2015-2-8', 6, 'Love taking this thing out on Sunday afternoons for a cruise.', 359);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2020-11-14', 4, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 341);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2015-8-13', 3, 'I''m in love with my new aircraft!', 278);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2019-9-8', 10, 'Best purchase EVER.', 14);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2018-3-14', 8, 'Decently sized', 263);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2017-2-14', 2, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 193);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2018-7-25', 5, 'Really nice looking', 247);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2019-4-21', 3, 'Now I never have to get stuck in traffic ever again', 124);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2016-4-11', 4, 'Melhor aviao do mundo, gostei da cor!', 200);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2018-2-27', 1, 'Love taking this thing out on Sunday afternoons for a cruise.', 360);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2016-10-8', 1, 'Spent all day flying my aircraft', 154);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2020-1-17', 10, 'Very economical', 326);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2015-10-27', 2, 'Love taking this thing out on Sunday afternoons for a cruise.', 36);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2017-5-11', 8, 'Spent all day flying my aircraft', 217);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2016-7-20', 5, 'Really nice looking', 250);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2020-1-7', 4, 'I''m in love with my new aircraft!', 355);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2017-7-6', 2, 'Best purchase EVER.', 30);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2017-5-17', 10, 'Really nice looking', 32);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2016-10-25', 4, 'Really nice looking', 229);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2019-6-3', 3, 'Very economical', 99);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2015-4-8', 5, 'Most reliable aircraft on the market', 336);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2016-4-11', 6, 'Worst company ever, they took away my dream plane just because my credit card got declined', 29);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2016-5-13', 10, 'Spent all day flying my aircraft', 123);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2016-4-26', 3, 'Really nice looking', 38);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2019-8-27', 10, 'I''m in love with my new aircraft!', 111);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2017-6-15', 8, 'Melhor aviao do mundo, gostei da cor!', 344);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2018-3-25', 4, 'I''m in love with my new aircraft!', 236);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2015-7-4', 8, 'Spent all day flying my aircraft', 318);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2017-2-13', 3, 'Melhor aviao do mundo, gostei da cor!', 220);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2015-9-27', 6, 'My family can finally go on vacation!', 130);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2015-7-1', 2, 'Very economical', 183);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2017-4-16', 1, 'They have the best aircrafts!', 186);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2020-4-7', 6, 'Worst company ever, they took away my dream plane just because my credit card got declined', 55);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2018-2-4', 4, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 292);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2015-4-11', 9, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 318);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2019-7-11', 9, 'Now I never have to get stuck in traffic ever again', 282);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2020-6-19', 2, 'I''m in love with my new aircraft!', 219);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2015-8-25', 6, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 146);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2020-11-8', 3, 'My family can finally go on vacation!', 334);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2016-2-2', 5, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 237);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2020-10-22', 3, 'Worst company ever, they took away my dream plane just because my credit card got declined', 41);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2018-6-1', 9, 'Decently sized', 224);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2018-6-8', 2, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 260);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2015-3-29', 2, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 351);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2018-7-19', 9, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 329);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2017-8-15', 6, 'Now I never have to get stuck in traffic ever again', 77);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2015-3-4', 5, 'They have the best aircrafts!', 77);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2020-5-26', 3, 'Now I never have to get stuck in traffic ever again', 141);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2016-10-11', 5, 'Spent all day flying my aircraft', 260);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2019-9-26', 7, 'Best purchase EVER.', 355);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2016-4-22', 7, 'Now I never have to get stuck in traffic ever again', 111);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2019-1-22', 3, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 329);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2019-7-21', 2, 'Melhor aviao do mundo, gostei da cor!', 195);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2015-6-15', 6, 'Melhor aviao do mundo, gostei da cor!', 143);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2017-6-26', 3, 'They have the best aircrafts!', 7);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2020-4-8', 8, 'Very economical', 56);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2017-8-28', 7, 'My family can finally go on vacation!', 342);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2019-10-23', 2, 'Worst company ever, they took away my dream plane just because my credit card got declined', 306);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2018-3-17', 2, 'Very economical', 179);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2018-8-13', 2, 'Very economical', 246);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2015-8-14', 9, 'Most reliable aircraft on the market', 193);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2015-6-19', 9, 'Really nice looking', 152);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2016-8-10', 3, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 349);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2017-10-3', 10, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 128);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2016-10-21', 10, 'Very economical', 12);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2018-2-14', 5, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 3);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2016-2-25', 5, 'I''m in love with my new aircraft!', 238);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2016-8-2', 8, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 304);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2016-1-28', 6, 'Decently sized', 103);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2020-10-30', 9, 'I''m in love with my new aircraft!', 40);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2019-5-30', 1, 'They have the best aircrafts!', 162);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2019-3-7', 2, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 172);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2016-10-17', 1, 'Very economical', 339);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2017-6-24', 8, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 133);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2019-1-16', 9, 'Best purchase EVER.', 350);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2019-7-13', 3, 'Melhor aviao do mundo, gostei da cor!', 273);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2019-1-1', 4, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 191);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2018-7-4', 2, 'They have the best aircrafts!', 82);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2018-4-14', 9, 'Melhor aviao do mundo, gostei da cor!', 105);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2015-6-23', 6, 'Worst company ever, they took away my dream plane just because my credit card got declined', 226);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2019-4-23', 7, 'Really nice looking', 34);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2020-2-7', 2, 'My family can finally go on vacation!', 27);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2020-9-9', 4, 'Very economical', 16);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2019-10-24', 7, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 65);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2019-10-13', 2, 'Spent all day flying my aircraft', 100);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2018-2-9', 6, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 136);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2018-8-22', 8, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 130);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2015-4-1', 3, 'Melhor aviao do mundo, gostei da cor!', 67);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2015-7-8', 9, 'Worst company ever, they took away my dream plane just because my credit card got declined', 202);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2018-9-27', 1, 'My family can finally go on vacation!', 343);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2015-3-22', 9, 'Spent all day flying my aircraft', 216);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2018-5-8', 8, 'I''m in love with my new aircraft!', 97);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2016-1-28', 5, 'Melhor aviao do mundo, gostei da cor!', 129);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2018-7-26', 8, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 82);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2018-10-14', 9, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 271);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2019-11-11', 2, 'Now I never have to get stuck in traffic ever again', 285);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2016-3-30', 3, 'Decently sized', 43);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2019-6-18', 6, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 343);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2019-2-22', 9, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 263);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2016-1-22', 1, 'Very economical', 41);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2016-11-20', 3, 'Really nice looking', 205);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2018-9-20', 1, 'Love taking this thing out on Sunday afternoons for a cruise.', 321);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2020-4-12', 6, 'I''m in love with my new aircraft!', 291);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2018-9-14', 10, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 32);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2017-9-30', 3, 'Worst company ever, they took away my dream plane just because my credit card got declined', 153);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2020-1-15', 9, 'They have the best aircrafts!', 51);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2017-6-22', 6, 'Most reliable aircraft on the market', 68);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2015-8-13', 7, 'Decently sized', 353);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2018-3-2', 1, 'Decently sized', 114);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2016-4-8', 5, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 85);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2018-5-18', 7, 'Love taking this thing out on Sunday afternoons for a cruise.', 187);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2016-3-28', 1, 'Love taking this thing out on Sunday afternoons for a cruise.', 301);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2019-8-1', 7, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 318);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2015-5-24', 6, 'Worst company ever, they took away my dream plane just because my credit card got declined', 230);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2017-6-9', 8, 'Best purchase EVER.', 45);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2019-2-26', 4, 'Worst company ever, they took away my dream plane just because my credit card got declined', 325);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2019-10-19', 3, 'Most reliable aircraft on the market', 340);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2017-8-29', 8, 'Really nice looking', 289);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2015-1-28', 7, 'Most reliable aircraft on the market', 86);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2015-2-9', 1, 'Now I never have to get stuck in traffic ever again', 18);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2017-3-23', 1, 'Very economical', 311);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2018-1-24', 5, 'My family can finally go on vacation!', 55);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2017-6-12', 4, 'Really nice looking', 153);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2019-11-9', 1, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 327);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2019-10-19', 2, 'They have the best aircrafts!', 107);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2020-11-30', 5, 'Best purchase EVER.', 365);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2015-9-15', 10, 'Melhor aviao do mundo, gostei da cor!', 242);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2017-4-23', 10, 'Very economical', 219);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2015-9-25', 9, 'Now I never have to get stuck in traffic ever again', 296);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2017-3-24', 2, 'I''m in love with my new aircraft!', 194);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2016-7-10', 2, 'My family can finally go on vacation!', 184);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2017-3-24', 4, 'Very economical', 153);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2017-9-3', 5, 'Most reliable aircraft on the market', 255);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2015-1-13', 3, 'Love taking this thing out on Sunday afternoons for a cruise.', 4);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2019-2-19', 5, 'Decently sized', 183);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2015-3-17', 7, 'Really nice looking', 265);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2018-11-5', 1, 'Love taking this thing out on Sunday afternoons for a cruise.', 78);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2019-8-27', 6, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 281);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2016-9-24', 2, 'I''m in love with my new aircraft!', 32);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2019-9-24', 6, 'Now I never have to get stuck in traffic ever again', 313);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2017-9-17', 3, 'Most reliable aircraft on the market', 103);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2020-1-9', 3, 'Decently sized', 323);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2018-8-23', 2, 'Best purchase EVER.', 98);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2018-3-4', 2, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 75);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2016-11-27', 2, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 176);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2020-3-6', 4, 'They have the best aircrafts!', 158);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2018-1-25', 6, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 188);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2017-1-24', 9, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 195);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2018-10-15', 2, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 6);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2019-3-2', 7, 'Love taking this thing out on Sunday afternoons for a cruise.', 208);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2018-11-19', 4, 'Spent all day flying my aircraft', 136);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2016-4-26', 4, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 61);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2017-8-12', 6, 'Decently sized', 83);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2015-6-20', 9, 'Melhor aviao do mundo, gostei da cor!', 55);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2017-4-24', 3, 'My family can finally go on vacation!', 250);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2020-7-28', 5, 'My family can finally go on vacation!', 283);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2015-2-1', 3, 'Very economical', 213);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2018-1-21', 10, 'They have the best aircrafts!', 53);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2017-7-7', 7, 'Really nice looking', 226);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2020-6-25', 10, 'Really nice looking', 152);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2019-5-23', 7, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 22);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2018-11-19', 5, 'Really nice looking', 60);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2020-1-28', 10, 'They have the best aircrafts!', 326);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2019-9-11', 10, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 5);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2015-3-8', 4, 'Spent all day flying my aircraft', 62);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2019-8-24', 5, 'Best purchase EVER.', 158);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2020-9-24', 6, 'Really nice looking', 1);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2020-10-22', 3, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 4);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2018-9-13', 8, 'Worst company ever, they took away my dream plane just because my credit card got declined', 298);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2015-2-9', 9, 'Love taking this thing out on Sunday afternoons for a cruise.', 231);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2015-6-13', 10, 'Worst company ever, they took away my dream plane just because my credit card got declined', 323);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2017-1-30', 8, 'Decently sized', 109);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2018-3-25', 4, 'I''m in love with my new aircraft!', 282);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2020-4-26', 6, 'Very economical', 334);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2015-3-9', 5, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 76);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2019-7-30', 4, 'Most reliable aircraft on the market', 30);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2015-1-1', 3, 'Really nice looking', 92);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2018-6-15', 7, 'Really nice looking', 364);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2016-5-8', 5, 'Now I never have to get stuck in traffic ever again', 68);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2018-11-18', 1, 'Worst company ever, they took away my dream plane just because my credit card got declined', 68);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2018-11-16', 6, 'Love taking this thing out on Sunday afternoons for a cruise.', 25);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2018-7-20', 7, 'Very economical', 362);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2017-6-15', 6, 'Very economical', 337);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2019-1-13', 2, 'My family can finally go on vacation!', 252);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2019-6-30', 7, 'Spent all day flying my aircraft', 355);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2017-6-18', 8, 'Decently sized', 104);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2018-6-8', 4, 'I''m in love with my new aircraft!', 52);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2019-1-12', 9, 'Melhor aviao do mundo, gostei da cor!', 314);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2018-8-13', 7, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 278);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2018-1-4', 7, 'Very economical', 85);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2015-8-30', 7, 'Worst company ever, they took away my dream plane just because my credit card got declined', 315);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2016-1-17', 2, 'Decently sized', 99);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2020-7-24', 5, 'Worst company ever, they took away my dream plane just because my credit card got declined', 125);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2019-2-20', 5, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 1);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2015-9-25', 8, 'Now I never have to get stuck in traffic ever again', 20);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2017-7-8', 4, 'Melhor aviao do mundo, gostei da cor!', 311);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2016-4-24', 8, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 293);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2020-3-23', 2, 'Love taking this thing out on Sunday afternoons for a cruise.', 108);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2015-5-15', 9, 'Very economical', 37);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2019-9-28', 1, 'Very economical', 97);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2019-11-5', 1, 'Spent all day flying my aircraft', 73);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2016-7-8', 9, 'Melhor aviao do mundo, gostei da cor!', 352);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2016-4-9', 9, 'Really nice looking', 272);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2020-4-8', 5, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 358);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2016-1-29', 4, 'Very economical', 6);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2020-9-19', 9, 'Most reliable aircraft on the market', 269);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2019-7-22', 6, 'My family can finally go on vacation!', 45);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2015-9-19', 7, 'Really nice looking', 115);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2015-11-25', 1, 'Decently sized', 61);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2020-8-11', 8, 'Now I never have to get stuck in traffic ever again', 115);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2016-3-19', 8, 'They have the best aircrafts!', 289);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2015-4-2', 9, 'Very economical', 311);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2020-5-24', 7, 'Melhor aviao do mundo, gostei da cor!', 297);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2016-9-30', 10, 'Love taking this thing out on Sunday afternoons for a cruise.', 11);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2018-2-28', 2, 'Spent all day flying my aircraft', 221);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2018-11-3', 8, 'Really nice looking', 335);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2019-8-6', 1, 'My family can finally go on vacation!', 282);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2019-9-27', 10, 'Worst company ever, they took away my dream plane just because my credit card got declined', 174);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2020-5-5', 5, 'Best purchase EVER.', 350);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2015-4-1', 7, 'Most reliable aircraft on the market', 265);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2020-2-6', 9, 'Most reliable aircraft on the market', 356);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2016-3-17', 1, 'Spent all day flying my aircraft', 177);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2017-6-6', 6, 'They have the best aircrafts!', 216);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2016-10-21', 6, 'Spent all day flying my aircraft', 296);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2015-5-18', 6, 'Now I never have to get stuck in traffic ever again', 181);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2019-9-26', 2, 'My family can finally go on vacation!', 319);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2018-7-25', 10, 'Now I never have to get stuck in traffic ever again', 341);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2016-10-8', 4, 'Worst company ever, they took away my dream plane just because my credit card got declined', 176);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2015-4-10', 1, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 361);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2017-6-2', 6, 'Love taking this thing out on Sunday afternoons for a cruise.', 117);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2020-10-19', 3, 'Love taking this thing out on Sunday afternoons for a cruise.', 66);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2020-1-28', 7, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 58);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2015-2-28', 8, 'Very economical', 270);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2015-3-5', 10, 'Really nice looking', 308);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2015-7-19', 8, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 360);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2020-2-22', 1, 'I''m in love with my new aircraft!', 291);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2016-11-23', 2, 'Best purchase EVER.', 334);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2020-3-1', 10, 'Spent all day flying my aircraft', 272);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2016-2-4', 8, 'Worst company ever, they took away my dream plane just because my credit card got declined', 115);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2019-2-8', 5, 'Love taking this thing out on Sunday afternoons for a cruise.', 157);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2019-7-13', 2, 'Very economical', 274);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2015-11-20', 2, 'My family can finally go on vacation!', 42);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2016-10-29', 4, 'Best purchase EVER.', 72);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2019-9-30', 7, 'Spent all day flying my aircraft', 186);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2019-10-17', 7, 'Worst company ever, they took away my dream plane just because my credit card got declined', 333);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2018-3-16', 10, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 51);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2016-7-7', 10, 'Spent all day flying my aircraft', 39);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2016-6-15', 6, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 329);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2018-11-13', 2, 'Decently sized', 354);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2016-4-1', 6, 'Melhor aviao do mundo, gostei da cor!', 80);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2015-6-10', 6, 'Decently sized', 353);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2016-9-14', 6, 'Decently sized', 240);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2017-5-1', 4, 'Decently sized', 230);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2016-1-11', 1, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 103);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2018-10-7', 10, 'Very economical', 216);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2016-11-7', 7, 'Decently sized', 191);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2020-3-28', 10, 'They have the best aircrafts!', 170);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2016-8-16', 5, 'My family can finally go on vacation!', 98);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2018-7-30', 4, 'Most reliable aircraft on the market', 172);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2017-7-26', 2, 'I''m in love with my new aircraft!', 210);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2019-4-10', 6, 'Decently sized', 200);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2016-11-12', 1, 'Now I never have to get stuck in traffic ever again', 308);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2015-8-18', 2, 'Decently sized', 20);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2017-2-16', 1, 'I''m in love with my new aircraft!', 299);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2020-8-12', 7, 'I''m in love with my new aircraft!', 106);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2015-2-1', 4, 'Melhor aviao do mundo, gostei da cor!', 128);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2019-7-3', 2, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 353);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2016-3-8', 2, 'Decently sized', 218);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2020-4-18', 5, 'Really nice looking', 310);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2015-8-30', 10, 'Decently sized', 260);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2017-11-19', 5, 'They flew the plane straight to my city, so I didn''t have to pay for shipping!', 85);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2017-11-28', 4, 'My family can finally go on vacation!', 268);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2016-11-3', 5, 'Melhor aviao do mundo, gostei da cor!', 193);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2019-3-26', 8, 'Most reliable aircraft on the market', 71);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2018-10-17', 8, 'Very economical', 125);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2017-10-15', 6, 'Very economical', 52);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2015-10-9', 10, 'Spent all day flying my aircraft', 327);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2016-2-22', 8, 'Worst company ever, they took away my dream plane just because my credit card got declined', 69);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2017-4-25', 8, 'Melhor aviao do mundo, gostei da cor!', 67);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2019-7-15', 2, 'Worst company ever, they took away my dream plane just because my credit card got declined', 46);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2016-2-29', 8, 'Melhor aviao do mundo, gostei da cor!', 87);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2016-7-5', 9, 'Very economical', 99);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2015-1-3', 3, 'Spent all day flying my aircraft', 92);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2017-5-11', 5, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 232);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2018-6-19', 3, 'They have the best aircrafts!', 254);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2017-4-1', 10, 'They have the best aircrafts!', 227);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2017-8-15', 8, 'Most reliable aircraft on the market', 218);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2020-6-23', 8, 'I''m in love with my new aircraft!', 261);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2019-3-24', 10, 'Mon nouvel avion est si rapide. Je peux désormais voler à travers le monde et mener mes affaires plus facilement!', 122);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2016-7-24', 9, 'Very economical', 355);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (4, '2018-8-21', 5, 'Decently sized', 289);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (1, '2020-8-8', 1, 'Decently sized', 247);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2017-1-30', 2, 'Worst company ever, they took away my dream plane just because my credit card got declined', 104);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2017-2-15', 8, 'Really nice looking', 201);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (2, '2016-7-9', 9, 'My family can finally go on vacation!', 333);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (3, '2017-6-11', 4, 'Love taking this thing out on Sunday afternoons for a cruise.', 317);
INSERT INTO review (reviewRating, reviewDate, customerId, reviewComment, productId) VALUES (5, '2017-1-9', 9, 'Most reliable aircraft on the market', 226);