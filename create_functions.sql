{\rtf1\ansi\ansicpg1252\cocoartf2759
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 -- Function to check login credentials\
CREATE OR REPLACE FUNCTION log_in(\
 p_cust_id IN customer.cust_id%TYPE,\
 p_passwd IN customer.passwd%TYPE\
) RETURN NUMBER AS\
 v_count NUMBER;\
BEGIN\
 SELECT COUNT(*)\
 INTO v_count\
 FROM customer\
 WHERE cust_id = p_cust_id AND passwd = p_passwd;\
\
 IF v_count = 1 THEN\
    RETURN 1; -- Login successful\
 ELSE\
    RETURN 0; -- Login failed\
 END IF;\
END;\
\
-- Function to get account balance\
CREATE OR REPLACE FUNCTION get_balance(\
 p_acc_id IN account.acc_id%TYPE\
) RETURN NUMBER AS\
 v_balance NUMBER;\
BEGIN\
 SELECT balance\
 INTO v_balance\
 FROM account\
 WHERE acc_id = p_acc_id;\
\
 RETURN v_balance;\
EXCEPTION\
 WHEN NO_DATA_FOUND THEN\
    RETURN -1;\
END;\
\
-- Function to check authority for account operations\
CREATE OR REPLACE FUNCTION get_authority(\
 p_cust_id IN account_owner.cust_id%TYPE,\
 p_acc_id IN account_owner.acc_id%TYPE\
) RETURN NUMBER AS\
 v_count NUMBER;\
BEGIN\
 SELECT COUNT(*)\
 INTO v_count\
 FROM account_owner\
 WHERE cust_id = p_cust_id AND acc_id = p_acc_id;\
\
 IF v_count > 0 THEN\
    RETURN 1; -- Customer has authority\
 ELSE\
    RETURN 0; -- Customer does not have authority\
 END IF;\
END;\
}