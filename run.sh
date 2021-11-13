robot -l NONE -o NONE -r NONE tasks/Delorean.robot      #aqui executa o comando para limpar o BD
robot -d ./logs tests/Login.robot                      #aqui roda os testes da suíte SIGNUP.ROBOT

# extensão "sh" é de arquivos SHELL. Dentro desses arquivos posso simplificar a execução dos testes através de atalhos.

# PARA EXECUTAR, o comando é: chmod +x run.sh
# Esse comando faz com que esse arquivo (run.sh) se torne um executável. Isso é necessário apenas UMA vez.

# Depois é só executar, no hyper: ./run.sh

# OBS: Caso eu não esteja usando o GITBASH, salvar o arquivo com extensão .bat e inserir os comandos com a última barra invertida.
# EXEMPLO: 
# robot -l NONE -o NONE -r NONE tasks/Delorean.robot
# robot -d ./logs tests\Signup.robot


#-i reqf