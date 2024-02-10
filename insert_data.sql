{\rtf1\ansi\ansicpg1252\cocoartf2759
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 -- Insert data into account_type table\
INSERT INTO account_type(accty_id, accty_name, present_interest)\
VALUES(1, 'farmer account', 2.4);\
INSERT INTO account_type(accty_id, accty_name, present_interest)\
VALUES(2, 'potato account', 3.4);\
INSERT INTO account_type(accty_id, accty_name, present_interest)\
VALUES(3, 'hog account', 4.4);\
COMMIT;\
\
-- Insert data into account table\
INSERT INTO account(acc_id, accty_id, date_time, balance)\
VALUES(123, 1, SYSDATE - 321, 0);\
INSERT INTO account(acc_id, accty_id, date_time, balance)\
VALUES(5899, 2, SYSDATE - 2546, 0);\
INSERT INTO account(acc_id, accty_id, date_time, balance)\
VALUES(5587, 3, SYSDATE - 10, 0);\
INSERT INTO account(acc_id, accty_id, date_time, balance)\
VALUES(8896, 1, SYSDATE - 45, 0);\
COMMIT;\
\
-- Insert data into account_owner table using the sequence\
INSERT INTO account_owner(accow_id, cust_id, acc_id)\
VALUES(pk_seq.NEXTVAL, '650707-1111', 123);\
INSERT INTO account_owner(accow_id, cust_id, acc_id)\
VALUES(pk_seq.NEXTVAL, '560126-1148', 123);\
INSERT INTO account_owner(accow_id, cust_id, acc_id)\
VALUES(pk_seq.NEXTVAL, '650707-1111', 5899);\
INSERT INTO account_owner(accow_id, cust_id, acc_id)\
VALUES(pk_seq.NEXTVAL, '861124-4478', 8896);\
COMMIT;\
}