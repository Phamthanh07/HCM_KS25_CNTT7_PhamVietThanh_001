create database hackathon_db;

use hackathon_db;

create table creator (
creator_id varchar(5) primary key,
creator_name varchar(100) not null,
creator_email varchar(100) not null unique,
creator_phone varchar(15) not null unique,
creator_platform varchar(50) not null
);

create table studio (
studio_id varchar(10) primary key,
studio_name varchar(100) not null,
studio_location varchar(100) not null,
hourly_price decimal(10,2) not null,
studio_status varchar(20) not null
);

create table livesession (
session_id int primary key auto_increment,
session_date date not null,
duration_hours int not null,
creator_id varchar(5) not null,
studio_id varchar(5) not null,
foreign key (creator_id) references creator(creator_id),
foreign key (studio_id) references studio(studio_id)
);

create table payment (
payment_id int primary key auto_increment,
session_id int not null,
payment_method varchar(50) not null,
payment_amount decimal(10,2) not null,
payment_date date not null,
foreign key (session_id) references livesession(session_id)
);

insert into creator(creator_id,creator_name,creator_email,creator_phone,creator_platform)
values 
('CR01','NGUYEN VAN A','a@live.com','0901111111','tiktok'),
('CR02','TRAN THI B','b@live.com','0902222222','yotube'),
('CR03','LE MINH C','c@live.com','09033333333','facebook'),
('CR04','PHAM THI D	','d@live.com','0904444444','tiktok'),
('CR05','VU HOANG E','e@live.com','0903333333','shoppe live');

insert into livesession(creator_id,studio_id,session_date,duration_hours)
values 
('C01','2025-05-01','1'),
('C02','2025-05-02','2'),
('C03','2025-05-03','3'),
('C04','2025-05-04','4'),
('C05','2025-05-05','5');

insert into studio(studio_id,studio_location,hourly_price,studio_status)
values 
('ST01','Studio A','Ha noi','20:00','Available'),
('ST02','Studio B','HCM','20:00','Available'),
('ST03','Studio C','DA NANG','20:00','Booked'),
('ST04','Studio D','Ha noi','20:00','Available'),
('ST05','Studio E','Can tho','20:00','Maintenance');

insert into payment(payment_method,payment_amount,payment_date)
values
('cash','60:00','2025-05-01'),
('credit card','100:00','2025-05-02'),
('banktransfer','60:00','2025-05-03'),
('credit card','110:00','2025-05-04'),
('cash','25:00','2025-05-05');

update creator
set creator_platform = 'Youtube'
where creator_id = 'CR03';

update studio
set studio_status = 'Available' and hourly_price = hourly_price*0.1
where studio_id = 'ST05';

delete from payment
where payment_method = 'cash' and payment_date < '2025-05-03';

select * from studio 
where studio_status = 'Available' and hourly_price > 20;

select creator_name,creator_phone from creator 
where creator_platform = 'tiktok';

select * from payment 
where payment_method = 'credit card'
limit 3;

select creator_id,creator_name from creator
where creator_id = 'CR03' and creator_id = 'CR04' and creator_id = 'CR05';

select
l.session_id,
c.creator_name,
s.studio_name,
d.duration_hours,
p.payment_amount
from livesession l
inner join creator c
on l.creator_id = c.creator_id 
inner join studio s
on l.studio_id = s.studio_id
inner join payment p
on l.session_id = p.session_id;

select sum(payment_method) from payment where payment_method = (select payment_method from payment);

select * from studio where hourly_price > (
select avg(hourly_price) from studio
);

select 
l.session_id,
c.creator_name,
s.studio_name,
p.payment,
p.amount
from livesession l
inner join creator c
on l.creator_id = c.creator_id
inner join studio s
on l.studio_id = s.studio_id
inner join payment p
on l.session_id = p.session_id;
