from faker import Faker
fake = Faker()


import bcrypt

def get_hashed_pass(password):
    hashed = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt(8))
    return hashed

def factory_user (target):
    
    data = {
        
        'faker': {
            'name': fake.first_name(),
            'lastname': fake.last_name(),
            'email': fake.free_email(),
            'password': 'tayna123',
        },
        'wrong_email': {
            'name':'Pedro',
            'lastname': 'De Lara',
            'email': 'pedro_dl*gmail.com',
            'password': 'tayna123'
        },
        'login': {
            'name':'Tayna',
            'lastname':'Kihara',
            'email': 'taynakihara@heroku.com',
            'password': 'tayna123'
        },
        'be_geek': {
            'name': 'Kim',
            'lastname': 'Dotcom',
            'email': 'kim@dotcom.com',
            'password': 'pwd123',            
            'geek_profile': {
                'whatsapp': '18981555555',
                'desc': 'Seu pc está lento? Posso resolver isso pra você. Seja formatando a máquina, reinstalando o sistema operacional Windows ou Linux, realizando a troca de algum hardware ou até mesmo eliminando malwares que estão afetando o desempenho do seu PC!',
                'printer_repair': 'Sim',
                'work': 'Remoto',
                'cost': '100'
            }
        },
        'attempt_be_geek': {
            'name': 'Dio',
            'lastname': 'Linux',
            'email': 'diolinux@gmail.com',
            'password': 'pwd123',            
            'geek_profile': {
                'whatsapp': '21981555555',
                'desc': 'Mojibake pode acontecer mesmo sem transferir informação de um computador para outro pois programas diferentes podem estar configurados para usar sistemas de codificação diferentes. As imagens a seguir mostram um problema comum nos laboratórios: um ambient',
                'printer_repair': 'Não',
                'work': 'Remoto',
                'cost': '350'
            }
        }
    }
    return data[target]