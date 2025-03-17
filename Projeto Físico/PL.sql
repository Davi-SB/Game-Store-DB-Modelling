-- cadastrar um novo usuario
CREAT OR REPLACE PROCEDURE CADASTRAR_USUARIO(ID NUMBER, USERNAME VARCHAR) IS

BEGIN
    INSERT INTO USUARIO (ID, USERNAME)
        VALUES (ID, USERNAME)
    DBMS_OUTPUT.PUT_LINE('USUARIO ' || USERNAME || ' CADASTRADO COM SUCESSO');
END;

-- Contrata dev e retorna a quantidade de devs na empresa
CREATE OR REPLACE FUNCTION CONTRATAR_DEV (codDEV NUMBER, idJOGO NUMBER, idEMPRESA NUMBER, func VARCHAR2) RETURN NUMBER IS
    new_dev NUMBER;
    cod_empresa NUMBER;
    cod_jogo NUMBER;
    qtd_dev NUMBER;
BEGIN
    SELECT USUARIO_ID INTO new_dev
    FROM DEV
    WHERE USUARIO_ID = codDEV;

    SELECT ID INTO cod_empresa
    FROM EMPRESA
    WHERE ID = idEMPRESA;

    SELECT ID INTO cod_jogo
    FROM JOGO
    WHERE ID = idJOGO;

    INSERT INTO DESENVOLVE VALUES (new_dev,idJogo,idEmpresa,func);
    DBMS_OUTPUT.PUT_LINE('DESENVOLVEDOR CONTRATADO');
    
    SELECT COUNT(*) INTO qtd_dev
    FROM DESENVOLVE
    WHERE EMPRESA_ID = cod_empresa;

    RETURN qtd_dev;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('UM DOS CAMPOS INFORMADOS NÃO EXISTE');
        RETURN NULL;
END;


-- Abaixa os preços dos jogos antigos
CREATE OR REPLACE PROCEDURE ABAIXAR_PRECO IS
    CURSOR cur_jogo IS
        SELECT ID, PRECO, EXTRACT(YEAR FROM DT_LANCAMENTO) - EXTRACT(YEAR FROM (SELECT SYSDATE FROM DUAL)) AS IDADE 
        FROM JOGO;
    reg_jogo cur_jogo%ROWTYPE;
BEGIN
    OPEN cur_jogo;
    
    LOOP
        FETCH cur_jogo INTO reg_jogo;
        EXIT WHEN cur_jogo%NOTFOUND;
        IF (reg_jogo.PRECO > 250 AND reg_jogo.IDADE >= 1) THEN
            UPDATE JOGO
            SET PRECO = 250
            WHERE ID = reg_jogo.id;
        ELSIF (reg_jogo.PRECO > 200 AND reg_jogo.IDADE >= 2) THEN
            UPDATE JOGO
            SET PRECO = 200
            WHERE ID = reg_jogo.id;
        ELSIF (reg_jogo.PRECO > 150 AND reg_jogo.IDADE >= 3) THEN
            UPDATE JOGO
            SET PRECO = 150
            WHERE ID = reg_jogo.id;
        ELSIF (reg_jogo.PRECO > 100 AND reg_jogo.IDADE >= 4) THEN
            UPDATE JOGO
            SET PRECO = 100
            WHERE ID = reg_jogo.id;
        END IF;
    END LOOP;

    CLOSE cur_jogo;
END;
    

--TRIGGER: verifica se o email já está vinculado a uma conta
CREATE OR REPLACE TRIGGER VERIFICA_EMAIL
BEFORE INSERT ON CONTA
FOR EACH ROW
DECLARE 
    EMAIL_COUNT INT;

BEGIN
    SELECT COUNT(*) INTO EMAIL_COUNT 
    FROM CONTA
    WHERE EMAIL = :OLD.EMAIL;

    IF EMAIL_COUNT > 1 THEN
        RAISE_APPLICATION_ERROR(-20001, 'ESSE EMAIL JÁ ESTÁ VINCULADO A UMA CONTA.');
    END IF;
END;
