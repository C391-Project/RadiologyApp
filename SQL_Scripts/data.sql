INSERT INTO persons
VALUES
(2,'James','Devito', '1234 aroad, Edmonton, AB, A1B-2C3, CA',
'devito@ualberta.ca', '159-5633');

INSERT INTO persons
VALUES
(3,'Cheng','Chen', '8888 Another road, Edmonton, A2D-3D3, CA',
'chengsemail@email.com', '123-9999');

INSERT INTO persons
VALUES
(4,'Commandeur', 'Brett', '1111 something, Edmonton, V3G-9D2, CA',
'brettsemail@email.com', '324-4214');
INSERT INTO persons
VALUES
(5,'Thomas', 'Rigde', '4345 Barnroad, Fort McMurry, BC, F5G-9S1, CA',
'TOM@hotmail.com', '424-5334');

INSERT INTO persons
VALUES
(6, 'Forester', 'Bob', '7656 Forestroad, ForestTown, BC, F2A-1G7, CA',
'bob@forest.com', '424-2222');

INSERT INTO persons
Values
(7, 'Dan', 'DannyBoy', '3145 DannyRoad, DanCity, AB, E1C-5R2, CA',
'DAN@gmail.com', '555-5555');

INSERT INTO persons
values
(8, 'Stan', 'Man', '5435 theroad, WhiteCourt, AB, D5Z-3P1, CA',
'stan@gmail.com', '634-1235');

insert into persons
values
(9, 'ANAME' , 'ANOTHERNAME', '1222 froad, thecity, AB, E1F-5E2, CA',
'aname@gmail.com', '423-5521');

insert into persons
values
(10, 'Pedro','Mang', '6345 mangroad, CoolTown, YT, Y7Z-2E2, CA',
'pedro@gmail.com', '421-9343');

insert into persons
values
(11, 'Alan', 'Major', '8567 Major Street, majorTown, YT, T4Y-0S2, CA',
'alan@gmail.com', '634-2432');

insert into persons
values
(12, 'Alexander','Roma', '5345 MainStreet, Rome, TX, R3Q-2P0, US',
'alex@hotmail.com', '999-0123');

insert into persons
values
(13, 'Snake', 'Plisken', '5211 BigStreet, NewYork, NY, N2N-5N5, US',
'snake@gmail.com','222-0019');

insert into persons
values
(14, 'Mad','Max', '0012 MadRoad, MaxTown, AB, P1I-1I0, CA',
'thunderdome@gmail.com','034-1233');

insert into persons
values
(15, 'Ray', 'Sipe', '9434 tubeblvrd, SomeTown, AB, L4D-3M3, CA',
'raysipe@gmail.com', '424-0230');

insert into persons
values
(16, 'Bat', 'Man', '9348 WayneManor, Gotham, NJ, U8I-2Q1, US',
'wayne@batmail.com', '978-5341');

insert into persons
values
(17, 'Wally', 'West', '4819 fastroad, BigCity, NJ, P3P-0D5, US',
'flash@fastmail.com','654-8234');

insert into persons
values
(18,'random','name', '6425 road1, randomtown, AB, O4K-9A1, US',
'random@gmail.com', '412-0121');

insert into persons
values
(19,'name2','2nd','9090 road1, randomtown, AB, O1W-9W2, US',
'random2@gmail.com', '410-0111');

insert into persons
values
(20,'name3','3rd','9191 road2, randomtown, AB, O2A-9D4, US',
'RANDOM3@gmail.com','400-5783');

insert into persons
values
(21,'name4','4th','9292 road3, randomtown, AB, O3A-9F3, US',
'random4@gmail.com','401-2342');

insert into persons
values
(22,'name5','5th','9019 road4, randomtown, AB, O4A-9T4, US',
'random5@gmail.com','492-9231');

insert into persons
values
(23, 'name6','6h','9023 road6, randomtown, AB, O1M-6R9, US',
'random6@gmail.com','823-1023');

/* Load Users */

insert into users
values
('devito','pass','a',2,sysdate);

insert into users
values
('cheng','pass','a',3,sysdate);

insert into users
values
('comm','pass','a',4,sysdate);

insert into users
values
('tom','pass','d',5,sysdate);

insert into users
values
('bob','pass','d',6,sysdate);

insert into users
values
('dan','pass','r',7,sysdate);

insert into users
values
('stan','pass','r',8,sysdate);

insert into users
values
('auser','pass','d',9,sysdate);

insert into users
values
('pedro','pass','d',10,sysdate);

insert into users
values
('alan','pass','d',11,sysdate);

insert into users
values
('alex','pass','p',12,sysdate);

insert into users
values
('snake','pass','p',13,sysdate);

insert into users
values
('max','pass','p',14,sysdate);

insert into users
values
('ray','pass','p',15,sysdate);

insert into users
values
('bat','pass','p',16,sysdate);

insert into users
values
('wally','pass','p',17,sysdate);

insert into users
values
('random','pass','p',18,sysdate);

insert into users
values
('2','pass','p',19,sysdate);

insert into users
values
('3','pass','p',20,sysdate);

insert into users
values
('4','pass','p',21,sysdate);

insert into users
values
('5','pass','p',22,sysdate);

insert into users
values
('6','pass','p',23,sysdate);

/* Load Doctors */

insert into family_doctor
values
(8,12);

INSERT INTO family_doctor
VALUES
(5,13);

INSERT INTO family_doctor
VALUES
(9,14);

INSERT INTO family_doctor
VALUES
(10,15);

INSERT INTO family_doctor
VALUES
(9,16);

INSERT INTO family_doctor
VALUES
(9,17);

INSERT INTO family_doctor
VALUES
(10,18);

INSERT INTO family_doctor
VALUES
(5,19);

INSERT INTO family_doctor
VALUES
(5,20);

INSERT INTO family_doctor
VALUES
(5,21);

INSERT INTO family_doctor
VALUES
(9,22);

INSERT INTO family_doctor
VALUES
(8,23);

INSERT INTO family_doctor
VALUES
(8,2);

/* 
Types of radiology tests as found on 
http://www.cancer.org/treatment/understandingyourdiagnosis/examsandtestdescriptions/imagingradiologytests/imaging-radiology-tests-types
Computed tomography scan
Magnetic resonance imaging scan
Radiographic studies
Mammography
Nuclear scans
Ultrasound
*/

INSERT INTO radiology_record
(record_id, patient_id, doctor_id, radiologist_id, test_type, prescribing_date
, test_date, diagnosis, description)
VALUES
(1,12, 8, 4, 'Computed tomography scan', sysdate, sysdate, 'Bi Polar',
'OK');

INSERT INTO radiology_record
VALUES
(2,13, 5, 19, 'MRI', sysdate, sysdate, 'Large Brain Tumor',
'It looks alright I guess. Its kind oflike a little head pet');

INSERT INTO radiology_record
VALUES
(3,14, 9, 6, 'Radiographic studies', sysdate, sysdate, 'Lung cancer',
'Lungs confirmed for cancer');

INSERT INTO radiology_record
VALUES
(4,15, 10, 7, 'Mammography', sysdate, sysdate, 'Breast cancer',
'Not looking good');

INSERT INTO radiology_record
VALUES
(5,16, 8, 7, 'Nuclear scans', sysdate, sysdate, 'Some cancer',
'Probably wont see this guy again wont make it to thursday and thats if hes lucky');

INSERT INTO radiology_record
VALUES
(6,17, 9, 5, 'Ultrasound', sysdate, sysdate, 'Pregnant',
'Oh my god what is that thing');

INSERT INTO radiology_record
VALUES
(7,12, 8, 4, 'Computed tomography scan', sysdate, sysdate, 'Bi Polar',
'I do not know what I am doing');

INSERT INTO radiology_record
VALUES
(8,17, 9, 5, 'Ultrasound', sysdate, sysdate, 'Bi Polar',
'Probably not the greatest');