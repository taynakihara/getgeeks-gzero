*** Settings ***
Documentation                Preparação inicial do AMBIENTE para execução dos TESTES
#nesta task eu faço uma população de dados iniciais necessários para executar meus testes

Resource        ${EXECDIR}/resources/Database.robot

*Tasks*
Back To The Past

    Connect To Postgres           #conecto no BD
    Reset Database                #reseto a base para iniciar os testes, sem lixo
    Users Seed                    #executo essa tarefa que faz o insert no BD (Database.robot)
    Disconnect From Database      #desconecto do BD;

# para executar essa tarefa no hyper, dentro da pasta "project", o comando é: robot -l NONE tasks/Delorean.robot
# assim não é gerado o relatório quando executamos essa task.