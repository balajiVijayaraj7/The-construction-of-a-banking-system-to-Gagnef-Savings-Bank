{\rtf1\ansi\ansicpg1252\cocoartf2759
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 -- Procedure for creating a new customer\
CREATE OR REPLACE PROCEDURE do_new_customer(\
 p_cust_id IN customer.cust_id%TYPE,\
 p_first_name IN customer.first_name%TYPE,\
 p_last_name IN customer.last_name%TYPE,\
 p_passwd IN customer.passwd%TYPE\
) AS\
BEGIN\
 INSERT INTO customer(cust_id, first_name, last_name, passwd)\
 VALUES (p_cust_id, p_first_name, p_last_name, p_passwd);\
 COMMIT;\
END;\
/\
\
-- Procedure for making a deposit and showing the balance after the deposit\
CREATE OR REPLACE PROCEDURE do_deposition(\
 p_dep_id IN deposition.dep_id%TYPE,\
 p_cust_id IN deposition.cust_id%TYPE,\
 p_acc_id IN deposition.acc_id%TYPE,\
 p_amount IN deposition.amount%TYPE,\
 p_date_time IN deposition.date_time%TYPE\
) AS\
 v_balance NUMBER;\
BEGIN\
 INSERT INTO deposition (dep_id, cust_id, acc_id, amount, date_time)\
 VALUES (p_dep_id, p_cust_id, p_acc_id, p_amount, p_date_time);\
\
 COMMIT;\
\
 v_balance := get_balance(p_acc_id);\
 DBMS_OUTPUT.PUT_LINE('Account balance after deposit: ' || v_balance);\
END;\
/\
\
-- Procedure for making a withdrawal and showing the balance after the withdrawal\
CREATE OR REPLACE PROCEDURE do_withdrawal(\
 p_wit_id IN withdrawal.wit_id%TYPE,\
 p_cust_id IN withdrawal.cust_id%TYPE,\
 p_acc_id IN withdrawal.acc_id%TYPE,\
 p_amount IN withdrawal.amount%TYPE,\
 p_date_time IN withdrawal.date_time%TYPE\
) AS\
 unauthorized EXCEPTION;\
 v_authority NUMBER;\
 v_balance NUMBER;\
BEGIN\
 v_authority := get_authority(p_cust_id, p_acc_id);\
\
 IF v_authority = 0 THEN\
    RAISE unauthorized;\
 ELSE\
    INSERT INTO withdrawal (wit_id, cust_id, acc_id, amount, date_time)\
    VALUES (p_wit_id, p_cust_id, p_acc_id, p_amount, p_date_time);\
\
    COMMIT;\
\
    v_balance := get_balance(p_acc_id);\
    DBMS_OUTPUT.PUT_LINE('Account balance after withdrawal: ' || v_balance);\
 END IF;\
EXCEPTION\
 WHEN unauthorized THEN\
    DBMS_OUTPUT.PUT_LINE('Unauthorized user!');\
    ROLLBACK;\
END;\
/\
\
-- Procedure for transferring funds between accounts\
CREATE OR REPLACE PROCEDURE do_transfer(\
 p_tra_id IN transfer.tra_id%TYPE,\
 p_cust_id IN transfer.cust_id%TYPE,\
 p_from_acc_id IN transfer.from_acc_id%TYPE,\
 p_to_acc_id IN transfer.to_acc_id%TYPE,\
 p_amount IN transfer.amount%TYPE,\
 p_date_time IN transfer.date_time%TYPE\
) AS\
 unauthorized EXCEPTION;\
 v_authority NUMBER;\
 v_balance_from NUMBER;\
 v_balance_to NUMBER;\
BEGIN\
 v_authority := get_authority(p_cust_id, p_from_acc_id);\
\
 IF v_authority = 0 THEN\
    RAISE unauthorized;\
 ELSE\
    INSERT INTO transfer (tra_id, cust_id, from_acc_id, to_acc_id, amount, date_time)\
    VALUES (p_tra_id, p_cust_id, p_from_acc_id, p_to_acc_id, p_amount, p_date_time);\
\
    COMMIT;\
\
    v_balance_from := get_balance(p_from_acc_id);\
    v_balance_to := get_balance(p_to_acc_id);\
    DBMS_OUTPUT.PUT_LINE('Balance in source account after transfer: ' || v_balance_from);\
    DBMS_OUTPUT.PUT_LINE('Balance in destination account after transfer: ' || v_balance_to);\
 END IF;\
EXCEPTION\
 WHEN unauthorized THEN\
    DBMS_OUTPUT.PUT_LINE('Unauthorized user!');\
    ROLLBACK;\
END;\
/\
}