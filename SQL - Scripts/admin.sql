 INSERT INTO persons
(person_id, first_name, last_name, address, email, phone)
VALUES
(1, 'admin', 'admin', '1234 admin drive',
'admin@ris.com', '123-4567');


INSERT INTO users
(user_name, password, class, person_id, date_registered)
VALUES
('admin', 'admin', 'a', 1, sysdate);
