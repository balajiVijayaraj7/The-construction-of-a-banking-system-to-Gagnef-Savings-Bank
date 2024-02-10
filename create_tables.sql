{\rtf1\ansi\ansicpg1252\cocoartf2759
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 --Table 1\
CREATE TABLE customer(\
 CUST_ID VARCHAR2(11) NOT NULL,\
 FIRST_NAME VARCHAR2(25) NOT NULL,\
 LAST_NAME VARCHAR2(25) NOT NULL,\
 PASSWD VARCHAR2(6) NOT NULL\
);\
ALTER TABLE customer\
ADD CONSTRAINT customer_CUST_ID_pk PRIMARY KEY (CUST_ID);\
\
--Table 2\
CREATE TABLE account_type(\
 ACCTY_ID NUMBER(6) NOT NULL,\
 ACCTY_NAME VARCHAR2(20) NOT NULL,\
 PRESENT_INTEREST NUMBER(5,2) NOT NULL\
);\
ALTER TABLE account_type\
ADD CONSTRAINT account_type_ACCTY_ID_pk PRIMARY KEY (ACCTY_ID);\
\
--Table 3\
CREATE TABLE interest_change(\
 INTCH_ID NUMBER(6) NOT NULL,\
 ACCTY_ID NUMBER(6) NOT NULL,\
 INTEREST NUMBER(5,2) NOT NULL,\
 DATE_TIME DATE NOT NULL\
);\
ALTER TABLE interest_change\
ADD CONSTRAINT interest_change_INTCH_ID_pk PRIMARY KEY (INTCH_ID)\
ADD CONSTRAINT interest_change_ACCTY_ID_fk FOREIGN KEY (ACCTY_ID) REFERENCES account_type (ACCTY_ID);\
\
--Table 4\
CREATE TABLE account(\
 ACC_ID NUMBER(8) NOT NULL,\
 ACCTY_ID NUMBER(6) NOT NULL,\
 DATE_TIME DATE NOT NULL,\
 BALANCE NUMBER(10,2) NOT NULL\
);\
ALTER TABLE account\
ADD CONSTRAINT account_ACC_ID_pk PRIMARY KEY (ACC_ID)\
ADD CONSTRAINT account_ACCTY_ID_fk FOREIGN KEY (ACCTY_ID) REFERENCES account_type (ACCTY_ID);\
\
--Table 5\
CREATE TABLE account_owner(\
 ACCOW_ID NUMBER(9) NOT NULL,\
 CUST_ID VARCHAR2(11) NOT NULL,\
 ACC_ID NUMBER(8) NOT NULL\
);\
ALTER TABLE account_owner\
ADD CONSTRAINT account_owner_ACCOW_ID_pk PRIMARY KEY (ACCOW_ID)\
ADD CONSTRAINT account_owner_CUST_ID_fk FOREIGN KEY (CUST_ID) REFERENCES customer (CUST_ID)\
ADD CONSTRAINT account_owner_ACC_ID_fk FOREIGN KEY (ACC_ID) REFERENCES account (ACC_ID);\
\
--Table 6\
CREATE TABLE withdrawal(\
 WIT_ID NUMBER(9) NOT NULL,\
 CUST_ID VARCHAR2(11) NOT NULL,\
 ACC_ID NUMBER(8) NOT NULL,\
 AMOUNT NUMBER(10,2) NOT NULL,\
 DATE_TIME DATE NOT NULL\
);\
ALTER TABLE withdrawal\
ADD CONSTRAINT withdrawal_WIT_ID_pk PRIMARY KEY (WIT_ID)\
ADD CONSTRAINT withdrawal_CUST_ID_fk FOREIGN KEY (CUST_ID) REFERENCES customer (CUST_ID)\
ADD CONSTRAINT withdrawal_ACC_ID_fk FOREIGN KEY (ACC_ID) REFERENCES account (ACC_ID);\
\
--Table 7\
CREATE TABLE deposition(\
 DEP_ID NUMBER(9) NOT NULL,\
 CUST_ID VARCHAR2(11) NOT NULL,\
 ACC_ID NUMBER(8) NOT NULL,\
 AMOUNT NUMBER(10,2) NOT NULL,\
 DATE_TIME DATE NOT NULL\
);\
ALTER TABLE deposition\
ADD CONSTRAINT deposition_DEP_ID_pk PRIMARY KEY (DEP_ID)\
ADD CONSTRAINT deposition_CUST_ID_fk FOREIGN KEY (CUST_ID) REFERENCES customer (CUST_ID)\
ADD CONSTRAINT deposition_ACC_ID_fk FOREIGN KEY (ACC_ID) REFERENCES account (ACC_ID);\
\
--Table 8\
CREATE TABLE transfer(\
 TRA_ID NUMBER(9) NOT NULL,\
 CUST_ID VARCHAR2(11) NOT NULL,\
 FROM_ACC_ID NUMBER(8) NOT NULL,\
 TO_ACC_ID NUMBER(8) NOT NULL,\
 AMOUNT NUMBER(10,2) NOT NULL,\
 DATE_TIME DATE NOT NULL\
);\
ALTER TABLE transfer\
ADD CONSTRAINT transfer_TRA_ID_pk PRIMARY KEY (TRA_ID)\
ADD CONSTRAINT transfer_CUST_ID_fk FOREIGN KEY (CUST_ID) REFERENCES customer (CUST_ID)\
ADD CONSTRAINT transfer_FROM_ACC_ID_fk FOREIGN KEY (FROM_ACC_ID) REFERENCES account (ACC_ID) ON DELETE CASCADE\
ADD CONSTRAINT transfer_TO_ACC_ID_fk FOREIGN KEY (TO_ACC_ID) REFERENCES account (ACC_ID) ON DELETE CASCADE;\
}