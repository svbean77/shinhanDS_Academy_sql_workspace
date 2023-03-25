declare
    v_empid number:=100;
    v_empname varchar2(20);
begin
    v_empname:='스티븐';
    dbms_output.put_line('Hello');
    dbms_output.put_line('아이디: '||v_empid);
    dbms_output.put_line('이름: '||v_empname);
end;
/