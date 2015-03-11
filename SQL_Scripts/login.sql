--just insert 4 users with different class for the purpose of tesing the login moduel

insert into persons values('99999','admin',null,null,null,null);
insert into persons values('99998','radiologist',null,null,null,null);
insert into persons values('99997','patient',null,null,null,null);
insert into persons values('99996','doctor',null,null,null,null);

insert into users values('admin', 'pass', 'a', '99999',null);
insert into users values('radiologist', 'pass', 'r', '99998',null);
insert into users values('patient','pass','p','99997',null);
insert into users values('doctor','pass','d','99996',null);

insert into family_doctor values('99997','99996');

insert into RADIOLOGY_RECORD values('9999','99996','99997','99998',null,null,null,null,null);

insert into PACS_IMAGES values('9999','8888',null,null,null);

