declare
    v_empid number:=100;
    v_empname varchar2(20);
begin
    v_empname:='��Ƽ��';
    dbms_output.put_line('Hello');
    dbms_output.put_line('���̵�: '||v_empid);
    dbms_output.put_line('�̸�: '||v_empname);
end;
/