
-- PROCEDURE: cadastrar um novo usuario
CREATE OR REPLACE PROCEDURE CADASTRAR_USUARIO(idPlayer NUMBER, name VARCHAR, isDev NUMBER) IS

BEGIN
    INSERT INTO USUARIO (ID, USERNAME)
        VALUES (idPlayer, name);
    
    IF (isDev = 1) THEN
        INSERT INTO DEV (USUARIO_ID)
        VALUES (idPlayer);
    ELSE
        INSERT INTO PLAYER (USUARIO_ID)
        VALUES (idPlayer);
    END IF;

    DBMS_OUTPUT.PUT_LINE('USUARIO ' || name || ' CADASTRADO COM SUCESSO');
END;

    
-- PROCEDURE: Abaixa os preços dos jogos antigos
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



-- FUNCTION: Contrata dev e retorna a quantidade de devs na empresa
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


-- FUNCTION: Analisa a qualidade do jogo pela media de estrelas dos cometários
CREATE OR REPLACE FUNCTION MEDIA_ESTRELAS(ID_JOGO INT) RETURN VARCHAR2 IS 
    MEDIA NUMBER;

BEGIN
    SELECT AVG(ESTRELAS) INTO MEDIA
    FROM COMENTARIO
    GROUP BY JOGO_ID
    HAVING ID_JOGO = JOGO_ID;

    IF (MEDIA > 4.5) THEN RETURN 'MUITO BOM';
    ELSIF (MEDIA > 4) THEN RETURN 'BOM';
    ELSIF (MEDIA > 3) THEN RETURN 'MÉDIO';
    ELSE RETURN 'RUIM';
    END IF;
END;



--TRIGGER: verifica se o cartao está vencido antes de inserir na tabela
CREATE OR REPLACE TRIGGER VERIFICA_CARTAO
BEFORE INSERT ON CARTAO
FOR EACH ROW
DECLARE 
    VALIDADE DATE;

BEGIN
    SELECT DT_EXP INTO VALIDADE 
    FROM CARTAO;

    IF VALIDADE < SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20003, 'ESSE CARTAO ESTÁ VENCIDO.');
    END IF;
END;

--TRIGGER: Limita o número de 5 compartilhamentos por jogo
CREATE OR REPLACE TRIGGER LIMITE_COMPARTILHAMENTO
BEFORE INSERT ON COMPARTILHA
FOR EACH ROW
DECLARE
    qtdComp NUMBER;
BEGIN
    SELECT COUNT(*) INTO qtdComp
    FROM COMPARTILHA
    WHERE DONO_ID = :OLD.DONO_ID AND JOGO_ID = :OLD.JOGO_ID;

    IF (qtdComp >= 5) THEN
        RAISE_APPLICATION_ERROR(-20001, 'LIMITE MÁXIMO DE COMPARTILHAMENTOS ATINGIDO');
    END IF;
END;
