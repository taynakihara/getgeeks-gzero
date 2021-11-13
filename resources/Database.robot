*** Settings ***
Documentation                        Database Helpers

Library            DatabaseLibrary
Library            factories/Users.py

*** Keywords ***
Connect To Postgres
    Connect To Database        psycopg2
    ...                        kwnxsbsr    #usuario do BD
    ...                        kwnxsbsr    #Database
    ...                        HNf0zinAGu56jDwxFutIsyF2Y3PMTYOy    #senha do BD
    ...                        fanny.db.elephantsql.com        #endereço do servidor do BD
    ...                        5432        #porta padrão do postgresql

Reset Database
    Execute SQL String        DELETE from public.geeks;    #deleta a tabela de geeks
    Execute SQL String        DELETE from public.users;    #deleta a tabela de usuários criados durante os testes

Insert User
    [Arguments]        ${u}

    ${hashed_pass}            Get Hashed Pass    ${u}[password]    #guardamos a senha sem criptografia na variável hashed_pass, que é a senha criptografada
#dessa forma, antes de montar a query para inserir o usuário no BD, tenho um método que criptografa essa senha;
#em seguida insiro essa variável (${hashed_pass}) no insert após o email, conforme query abaixo:
    ${q}        Set Variable        INSERT INTO public.users (name, email, password_hash, is_geek) values ('${u}[name] ${u}[lastname]', '${u}[email]', '${hashed_pass}', false)

    Execute SQL String      ${q}
#para cadastrar um usuário direto no BD, é preciso que a senha seja criptografada;

Users Seed    #semear uma massa de teste
    ${user}        Factory User Login
    Insert User    ${user}