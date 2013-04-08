set echo on;

create user chengjk identified by chengjk default tablespace system temporary tablespace temp;
grant connect to chengjk;
grant resource to chengjk;

drop user chengjk;
