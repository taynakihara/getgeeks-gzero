*** Settings ***
Documentation                        Database Helpers

Library            DatabaseLibrary
Library            factories/Users.py

*** Keywords ***
Connect To Postgres
    Connect To Database        psycopg2
    ...                        kwnxsbsr
    ...                        kwnxsbsr
    ...                        HNf0zinAGu56jDwxFutIsyF2Y3PMTYOy
    ...                        fanny.db.elephantsql.com
    ...                        5432

Reset Database
    Execute SQL String        DELETE from public.geeks;
    Execute SQL String        DELETE from public.users;

Insert User
    [Arguments]        ${u}

    ${hashed_pass}            Get Hashed Pass    ${u}[password]
    ${q}        Set Variable        INSERT INTO public.users (name, email, password_hash, is_geek) values ('${u}[name] ${u}[lastname]', '${u}[email]', '${hashed_pass}', false)

    Execute SQL String      ${q}

Users Seed
    ${user}        Factory User Login
    Insert User    ${user}