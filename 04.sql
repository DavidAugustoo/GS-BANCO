-- Enunciado 4


-- 1. Procedure para verificar a existência de pacientes com certas condições de saúde

CREATE OR REPLACE PROCEDURE check_health_condition(p_condition VARCHAR2) AS
    CURSOR c_patients IS
        SELECT patient_id FROM MEDICAL_RECORDS WHERE document_body LIKE '%' || p_condition || '%';
    v_patient_id PATIENTS.patient_id%TYPE;
    found BOOLEAN := FALSE;
BEGIN
    OPEN c_patients;
    FETCH c_patients INTO v_patient_id;
    WHILE c_patients%FOUND LOOP
        found := TRUE;
        DBMS_OUTPUT.PUT_LINE('Paciente com ID ' || v_patient_id || ' tem a condição: ' || p_condition);
        FETCH c_patients INTO v_patient_id;
    END LOOP;
    CLOSE c_patients;

    IF NOT found THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum paciente encontrado com a condição: ' || p_condition);
    END IF;
END;

-- Verifica se tem algum paciente com relátorio de diabetes
CALL check_health_condition('lkdasld')

-- 2. Procedure para verificar a atualização de registros médicos

CREATE OR REPLACE PROCEDURE check_medical_records_update(p_patient_id IN PATIENTS.patient_id%TYPE, p_days_limit IN NUMBER) AS
    v_latest_record_date TIMESTAMP;
    v_current_date DATE := TRUNC(SYSDATE);
    v_days_since_last_record NUMBER;
    CURSOR patient_records_cursor IS
        SELECT MAX(creation_date) AS last_record_date
        FROM MEDICAL_RECORDS
        WHERE patient_id = p_patient_id;
BEGIN
    OPEN patient_records_cursor;
    FETCH patient_records_cursor INTO v_latest_record_date;
    CLOSE patient_records_cursor;

    IF v_latest_record_date IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum registro médico encontrado para o paciente com ID ' || p_patient_id);
        RETURN;
    END IF;

    -- Calculando a diferença em dias
    v_days_since_last_record := v_current_date - TRUNC(v_latest_record_date);

    IF v_days_since_last_record > p_days_limit THEN
        DBMS_OUTPUT.PUT_LINE('Paciente com ID ' || p_patient_id || ' não tem registros médicos atualizados nos últimos ' || p_days_limit || ' dias. Última atualização há ' || v_days_since_last_record || ' dias.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Paciente com ID ' || p_patient_id || ' tem registros médicos atualizados.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum registro encontrado para o paciente com ID ' || p_patient_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
        RAISE;
END;

-- Verifica se o paciente de ID 1, possui documentos registrados nos ultimos 30 dias
CALL check_medical_records_update(1, 30);