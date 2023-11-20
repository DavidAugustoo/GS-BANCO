-- Tarefa 5

SET SERVEROUTPUT ON;


CREATE OR REPLACE PROCEDURE count_doctor_appointments_by_id(
    p_doctor_id IN DOCTORS.doctor_id%TYPE,
    p_start_date IN DATE,
    p_end_date IN DATE
) AS
    v_count NUMBER;
    v_doctor_name DOCTORS.full_name%TYPE;
BEGIN
    -- Primeiro, obtemos o nome do médico pelo ID
    SELECT full_name INTO v_doctor_name FROM DOCTORS WHERE doctor_id = p_doctor_id;

    -- Depois, contamos os acessos
    SELECT COUNT(*)
    INTO v_count
    FROM TOKEN_ACCESS_LOGS
    WHERE doctor_id = p_doctor_id
    AND access_time BETWEEN p_start_date AND p_end_date;

    DBMS_OUTPUT.PUT_LINE('Total de consultas do ' || v_doctor_name || ' entre ' || p_start_date || ' e ' || p_end_date || ': ' || v_count);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nenhuma consulta encontrada para o Doutor de ID: ' || p_doctor_id);
END;


CALL count_doctor_appointments_by_id(1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));
