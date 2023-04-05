drop table admins;

create table admins (
    email varchar2(20) primary key,
    manager_name varchar2(50),
    pass varchar2(20)
);

insert into admins values('user1@email.com', '±èÃ¶¼ö', '1234');
insert into admins values('user2@email.com', '±è¿µÈñ', '1234');
commit;

select * from admins;
