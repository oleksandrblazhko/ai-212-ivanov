CREATE OR REPLACE TYPE Payment_type AS OBJECT (
    payId NUMBER,
    paymentMethod VARCHAR2(50)
);
/
CREATE OR REPLACE TYPE MeteoService_type AS OBJECT (
    meteoSvcId NUMBER,
    meteoSvcName VARCHAR2(100),
    cost INT,
    dateTime DATE,
    payId INT
);
/
CREATE OR REPLACE TYPE OnlineApplication_type AS OBJECT (
    appId NUMBER,
    userData VARCHAR2(1000)
);
/
CREATE OR REPLACE TYPE Users_type AS OBJECT (
    userId NUMBER,
    fullName VARCHAR2(120),
    address VARCHAR2(200),
    accountNumber INT,
    appId INT,
    meteoSvcId INT
);