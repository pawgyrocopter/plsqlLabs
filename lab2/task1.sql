CREATE TABLE Groups (
    id NUMBER NOT NULL,
    name VARCHAR2(20) NOT NULL,
    c_val NUMBER DEFAULT 0 NOT NULL 
);

CREATE TABLE Students (
    id NUMBER NOT NULL,
    name VARCHAR2(20) NOT NULL,
    group_id NUMBER NOT NULL
);