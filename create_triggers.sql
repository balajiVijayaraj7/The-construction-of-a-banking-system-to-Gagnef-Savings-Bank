{\rtf1\ansi\ansicpg1252\cocoartf2759
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 -- Trigger to ensure password length\
CREATE OR REPLACE TRIGGER biufer_customer\
BEFORE INSERT OR UPDATE OF passwd ON customer\
FOR EACH ROW\
WHEN (LENGTH(NEW.passwd) <> 6)\
BEGIN\
 RAISE_APPLICATION_ERROR(-20001, 'Check the password length');\
END;\
\
-- Trigger for deposition balance update\
CREATE OR REPLACE TRIGGER aifer_deposition\
AFTER INSERT ON deposition\
FOR EACH ROW\
BEGIN\
 UPDATE account SET balance = balance + :NEW.amount\
 WHERE acc_id = :NEW.acc_id;\
END;\
\
-- Trigger to prevent over-withdrawal\
CREATE OR REPLACE TRIGGER bifer_withdrawal\
BEFORE INSERT ON withdrawal\
FOR EACH ROW\
DECLARE\
 v_balance NUMBER;\
BEGIN\
 v_balance := get_balance(:NEW.acc_id);\
 IF :NEW.amount > v_balance THEN\
    RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds for withdrawal');\
END IF;\
END;\
\
-- Trigger for withdrawal balance update\
CREATE OR REPLACE TRIGGER aifer_withdrawal\
AFTER INSERT ON withdrawal\
FOR EACH ROW\
BEGIN\
    IF get_balance(:NEW.acc_id) >= :NEW.amount THEN\
        UPDATE account SET balance = balance - :NEW.amount\
        WHERE acc_id = :NEW.acc_id;\
    ELSE\
        RAISE_APPLICATION_ERROR(-20002, 'Insufficient funds for withdrawal');\
    END IF;\
END;\
\
-- Trigger to ensure transfer from an account with sufficient funds\
CREATE OR REPLACE TRIGGER bifer_transfer\
BEFORE INSERT ON transfer\
FOR EACH ROW\
BEGIN\
    IF get_balance(:NEW.from_acc_id) < :NEW.amount THEN\
        RAISE_APPLICATION_ERROR(-20003, 'Insufficient funds for transfer');\
    END IF;\
END;\
\
-- Trigger for transfer balance update\
CREATE OR REPLACE TRIGGER aifer_transfer\
AFTER INSERT ON transfer\
FOR EACH ROW\
BEGIN\
    UPDATE account SET balance = balance - :NEW.amount\
    WHERE acc_id = :NEW.from_acc_id;\
\
    UPDATE account SET balance = balance + :NEW.amount\
    WHERE acc_id = :NEW.to_acc_id;\
END;\
\
}