create or replace FUNCTION createApplication (
    p_fullName IN VARCHAR2, 
    p_address IN VARCHAR2, 
    p_meteoSvcName IN VARCHAR2 
) 

RETURN INT IS 
    v_fullName Users.fullName%TYPE := TRIM(p_fullName); 
    v_address Users.address%TYPE := TRIM(p_address); 
    v_meteoSvcName MeteoService.meteoSvcName%TYPE := TRIM(p_meteoSvcName); 
    v_meteoSvcId MeteoService.meteoSvcId%TYPE;
BEGIN 
    -- Умова №1: Повне ім'я користувача не повинно бути порожнім і не повинно перевищувати 120 символів. 
    IF LENGTH(v_fullName) = 0 OR LENGTH(v_fullName) > 120 OR NOT REGEXP_LIKE(v_fullName, '^[A-Za-z ]+$') THEN 
        RETURN -1; -- Помилка: ПІБ користувача не відповідає умовам. 
    END IF; 
 
    -- Умова №2: Адреса користувача не повинна бути порожньою і не повинна перевищувати 200 символів. 
    IF LENGTH(v_address) = 0 OR LENGTH(v_address) > 200 OR NOT REGEXP_LIKE(v_address, '^[A-Za-z0-9,.\- ]+$') THEN 
        RETURN -2; -- Помилка: Адреса користувача не відповідає умовам. 
    END IF; 
 
    -- Умова №3: Назва метеорологічної послуги не повинна бути порожньою і не повинна перевищувати 100 символів. 
    IF LENGTH(v_meteoSvcName) = 0 OR LENGTH(v_meteoSvcName) > 100 THEN 
        RETURN -3; -- Помилка: Назва метеорологічної послуги не відповідає умовам. 
    END IF; 

    -- Insert into MeteoService and get the ID of the created row.
    INSERT INTO MeteoService (meteoSvcName, cost, dateTime, payId)
    VALUES (v_meteoSvcName, 0, CURRENT_DATE, 0)
    RETURNING meteoSvcId INTO v_meteoSvcId;

    -- Всі умови виконані, можна вставляти дані в таблицю. 
    INSERT INTO Users (fullName, address, meteoSvcId)
    VALUES (v_fullName, v_address, v_meteoSvcId); 
    COMMIT; 
 
    RETURN 1; -- Користувач успішно ввів всі дані. 
END;
/