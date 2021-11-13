from faker import Faker
fake = Faker()


import bcrypt   #importando o bcrypt

def get_hashed_pass(password):      #criando um novo método que recebe o argumento PASSWORD (senha que quero criptografar). Aqui ele recebe a senha não criptogrfada
    hashed = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt(8))
    return hashed
#crio uma variável para armazenar todo esse código. Variável "hashed";
#na sequencia, chamo o módulo bcrypt junto do método hashpw, que é o método que criptografa uma senha;
#em seguida passo a senho que quero criptografar "(password)" e acrescento o .encode('utf-8) para não dar ruim no código;
#depois informo o modelo de criptografia "bcrypt.gensalt(8)", onde o 8 é o padrão de criptografia que o dev usou no bcrypt para o nodejs javascript
#por último, no return, retornamos a senha criptografada

def factory_user():
    return {
        'name': fake.first_name(),
        'lastname': fake.last_name(),
        'email': fake.free_email(),
        'password': 'tayna123',
    }

def factory_wrong_email():

    first_name = fake.first_name()

    return {
        'name':first_name,
        'lastname': fake.last_name(),
        'email': first_name.lower() + '&gmail.com',
        'password': 'tayna123'
    }

def factory_user_login():
    return {
        'name':'Tayna',
        'lastname':'Kihara',
        'email': 'taynakihara@heroku.com',
        'password': 'tayna123'
    }