-- Enunciado 3


SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE load_initial_data AS
    v_user_name VARCHAR2(100) := USER;
    v_error_message VARCHAR2(4000);
BEGIN
    -- Inserção de dados em PATIENTS
    BEGIN
        INSERT INTO PATIENTS (full_name, email_address, password_hash, date_birth, cpf) VALUES ('Alice Smith', 'alice@example.com', 'hash1', TO_DATE('1985-04-12', 'YYYY-MM-DD'), '12345678901');
        INSERT INTO PATIENTS (full_name, email_address, password_hash, date_birth, cpf) VALUES ('Bob Johnson', 'bob.johnson@example.com', 'hash2', TO_DATE('1992-07-19', 'YYYY-MM-DD'), '23456789012');
        INSERT INTO PATIENTS (full_name, email_address, password_hash, date_birth, cpf) VALUES ('Carol White', 'carol.white@example.com', 'hash3', TO_DATE('1978-11-03', 'YYYY-MM-DD'), '34567890123');
        INSERT INTO PATIENTS (full_name, email_address, password_hash, date_birth, cpf) VALUES ('David Brown', 'david.brown@example.com', 'hash4', TO_DATE('1988-06-22', 'YYYY-MM-DD'), '45678901234');
        INSERT INTO PATIENTS (full_name, email_address, password_hash, date_birth, cpf) VALUES ('Eva Green', 'eva.green@example.com', 'hash5', TO_DATE('1995-02-15', 'YYYY-MM-DD'), '56789012345');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            v_error_message := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('Erro de duplicidade em PATIENTS: ' || v_error_message);
            INSERT INTO ERROR_LOGS (user_name, error_date, error_code, error_message)
            VALUES (v_user_name, SYSDATE, 'DUP_VAL_ON_INDEX', v_error_message);
            COMMIT;
        WHEN VALUE_ERROR THEN
            v_error_message := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('Erro de valor em PATIENTS: ' || v_error_message);
            INSERT INTO ERROR_LOGS (user_name, error_date, error_code, error_message)
            VALUES (v_user_name, SYSDATE, 'VALUE_ERROR', v_error_message);
            COMMIT;
        WHEN OTHERS THEN
            v_error_message := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('Erro desconhecido em PATIENTS: ' || v_error_message);
            INSERT INTO ERROR_LOGS (user_name, error_date, error_code, error_message)
            VALUES (v_user_name, SYSDATE, 'OTHERS', v_error_message);
            COMMIT;
    END;

    -- Inserção de dados em DOCTORS
    BEGIN
        INSERT INTO DOCTORS (full_name, email_address, password_hash, date_birth, cpf, crm, specialty) VALUES ('Dr. John Doe', 'john.doe@example.com', 'doc1hash', TO_DATE('1975-03-29', 'YYYY-MM-DD'), '67890123456', 'CRM1234', 'Cardiology');
        INSERT INTO DOCTORS (full_name, email_address, password_hash, date_birth, cpf, crm, specialty) VALUES ('Dr. Sarah Connor', 'sarah.connor@example.com', 'doc2hash', TO_DATE('1980-07-14', 'YYYY-MM-DD'), '78901234567', 'CRM5678', 'Neurology');
        INSERT INTO DOCTORS (full_name, email_address, password_hash, date_birth, cpf, crm, specialty) VALUES ('Dr. Mike Ross', 'mike.ross@example.com', 'doc3hash', TO_DATE('1984-09-11', 'YYYY-MM-DD'), '89012345678', 'CRM9012', 'Pediatrics');
        INSERT INTO DOCTORS (full_name, email_address, password_hash, date_birth, cpf, crm, specialty) VALUES ('Dr. Lisa Cuddy', 'lisa.cuddy@example.com', 'doc4hash', TO_DATE('1972-12-18', 'YYYY-MM-DD'), '90123456789', 'CRM3456', 'General Medicine');
        INSERT INTO DOCTORS (full_name, email_address, password_hash, date_birth, cpf, crm, specialty) VALUES ('Dr. Gregory House', 'gregory.house@example.com', 'doc5hash', TO_DATE('1968-05-17', 'YYYY-MM-DD'), '01234567890', 'CRM7890', 'Diagnostic Medicine');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            v_error_message := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('Erro de duplicidade em DOCTORS: ' || v_error_message);
            INSERT INTO ERROR_LOGS (user_name, error_date, error_code, error_message)
            VALUES (v_user_name, SYSDATE, 'DUP_VAL_ON_INDEX', v_error_message);
            COMMIT;
        WHEN VALUE_ERROR THEN
            v_error_message := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('Erro de valor em DOCTORS: ' || v_error_message);
            INSERT INTO ERROR_LOGS (user_name, error_date, error_code, error_message)
            VALUES (v_user_name, SYSDATE, 'VALUE_ERROR', v_error_message);
            COMMIT;
        WHEN OTHERS THEN
            v_error_message := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('Erro desconhecido em DOCTORS: ' || v_error_message);
            INSERT INTO ERROR_LOGS (user_name, error_date, error_code, error_message)
            VALUES (v_user_name, SYSDATE, 'OTHERS', v_error_message);
            COMMIT;
    END;
    -- Inserção de dados em ACCESS_TOKENS
    BEGIN
        INSERT INTO ACCESS_TOKENS (patient_id, expiration_time, status) VALUES (1, SYSTIMESTAMP + INTERVAL '3' HOUR, 'active');
        INSERT INTO ACCESS_TOKENS (patient_id, expiration_time, status) VALUES (2, SYSTIMESTAMP + INTERVAL '3' HOUR, 'active');
        INSERT INTO ACCESS_TOKENS (patient_id, expiration_time, status) VALUES (3, SYSTIMESTAMP + INTERVAL '3' HOUR, 'expired');
        INSERT INTO ACCESS_TOKENS (patient_id, expiration_time, status) VALUES (4, SYSTIMESTAMP + INTERVAL '3' HOUR, 'expired');
        INSERT INTO ACCESS_TOKENS (patient_id, expiration_time, status) VALUES (5, SYSTIMESTAMP + INTERVAL '3' HOUR, 'active');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            v_error_message := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('Erro de duplicidade em ACCESS_TOKENS: ' || v_error_message);
            INSERT INTO ERROR_LOGS (user_name, error_date, error_code, error_message)
            VALUES (v_user_name, SYSDATE, 'DUP_VAL_ON_INDEX', v_error_message);
            COMMIT;
        WHEN VALUE_ERROR THEN
            v_error_message := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('Erro de valor em ACCESS_TOKENS: ' || v_error_message);
            INSERT INTO ERROR_LOGS (user_name, error_date, error_code, error_message)
            VALUES (v_user_name, SYSDATE, 'VALUE_ERROR', v_error_message);
            COMMIT;
        WHEN OTHERS THEN
            v_error_message := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('Erro desconhecido em ACCESS_TOKENS: ' || v_error_message);
            INSERT INTO ERROR_LOGS (user_name, error_date, error_code, error_message)
            VALUES (v_user_name, SYSDATE, 'OTHERS', v_error_message);
            COMMIT;
    END;

    -- Inserção de dados em MEDICAL_RECORDS
    BEGIN
        INSERT INTO MEDICAL_RECORDS (patient_id, document_body) VALUES (1, 'Paciente feminina, 24 anos, diagnosticada com diabetes tipo 1. Apresenta histórico familiar da doença. Relata dificuldade no controle glicêmico, com episódios frequentes de hipoglicemia. Sinais de fadiga e perda de peso observados. Aconselhada a ajustar a dosagem de insulina e seguir rigoroso plano alimentar.');
        INSERT INTO MEDICAL_RECORDS (patient_id, document_body) VALUES (2, 'Paciente masculino, 30 anos, com lesão no ligamento cruzado anterior do joelho direito. Ocorreu durante atividade esportiva. Exibe inchaço e limitação de movimento. Recomendado repouso, fisioterapia e avaliação para possível cirurgia.');
        INSERT INTO MEDICAL_RECORDS (patient_id, document_body) VALUES (3, 'Paciente feminina, 65 anos, com diagnóstico de hipertensão arterial. Apresenta leituras consistentemente elevadas de pressão arterial. Histórico de tabagismo e dieta rica em sódio. Recomendado alterações na dieta, aumento da atividade física e início de terapia medicamentosa.');
        INSERT INTO MEDICAL_RECORDS (patient_id, document_body) VALUES (4, 'Paciente masculino, 58 anos, recentemente diagnosticado com diabetes tipo 2. Sobrepeso e sedentário. Relata aumento da sede e frequência urinária. Exames indicam níveis elevados de glicose no sangue. Recomendado mudança no estilo de vida, incluindo dieta e exercício, além de medicação oral.');
        INSERT INTO MEDICAL_RECORDS (patient_id, document_body) VALUES (5, 'Paciente feminina, 42 anos, sofre de enxaqueca crônica. Episódios frequentes de dor de cabeça intensa, acompanhada de fotofobia e náuseas. Tratamento atual com medicamentos preventivos não está sendo eficaz. Avaliação para ajuste de medicação e terapias alternativas em consideração.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            v_error_message := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('Erro de duplicidade em MEDICAL_RECORDS: ' || v_error_message);
            INSERT INTO ERROR_LOGS (user_name, error_date, error_code, error_message)
            VALUES (v_user_name, SYSDATE, 'DUP_VAL_ON_INDEX', v_error_message);
            COMMIT;
        WHEN VALUE_ERROR THEN
            v_error_message := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('Erro de valor em MEDICAL_RECORDS: ' || v_error_message);
            INSERT INTO ERROR_LOGS (user_name, error_date, error_code, error_message)
            VALUES (v_user_name, SYSDATE, 'VALUE_ERROR', v_error_message);
            COMMIT;
        WHEN OTHERS THEN
            v_error_message := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('Erro desconhecido em MEDICAL_RECORDS: ' || v_error_message);
            INSERT INTO ERROR_LOGS (user_name, error_date, error_code, error_message)
            VALUES (v_user_name, SYSDATE, 'OTHERS', v_error_message);
            COMMIT;
    END;

    -- Inserção de dados em TOKEN_ACCESS_LOGS
    BEGIN
        INSERT INTO TOKEN_ACCESS_LOGS (token_id, doctor_id) VALUES (1, 1);
        INSERT INTO TOKEN_ACCESS_LOGS (token_id, doctor_id) VALUES (2, 2);
        INSERT INTO TOKEN_ACCESS_LOGS (token_id, doctor_id) VALUES (3, 3);
        INSERT INTO TOKEN_ACCESS_LOGS (token_id, doctor_id) VALUES (4, 4);
        INSERT INTO TOKEN_ACCESS_LOGS (token_id, doctor_id) VALUES (5, 5);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            v_error_message := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('Erro de duplicidade em TOKEN_ACCESS_LOGS: ' || v_error_message);
            INSERT INTO ERROR_LOGS (user_name, error_date, error_code, error_message)
            VALUES (v_user_name, SYSDATE, 'DUP_VAL_ON_INDEX', v_error_message);
            COMMIT;
        WHEN VALUE_ERROR THEN
            v_error_message := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('Erro de valor em TOKEN_ACCESS_LOGS: ' || v_error_message);
            INSERT INTO ERROR_LOGS (user_name, error_date, error_code, error_message)
            VALUES (v_user_name, SYSDATE, 'VALUE_ERROR', v_error_message);
            COMMIT;
        WHEN OTHERS THEN
            v_error_message := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('Erro desconhecido em TOKEN_ACCESS_LOGS: ' || v_error_message);
            INSERT INTO ERROR_LOGS (user_name, error_date, error_code, error_message)
            VALUES (v_user_name, SYSDATE, 'OTHERS', v_error_message);
            COMMIT;
    END;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        v_error_message := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('Erro desconhecido na procedure principal: ' || v_error_message);
        INSERT INTO ERROR_LOGS (user_name, error_date, error_code, error_message)
        VALUES (v_user_name, SYSDATE, 'OTHERS', v_error_message);
        COMMIT;
        RAISE;
END;

CALL load_initial_data();
