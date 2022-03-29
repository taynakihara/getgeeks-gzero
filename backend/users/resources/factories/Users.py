
def factory_new_user():
    
    return {
        'name':'Clint Barton',
        'email':'barton@shield.com',
        'password':'pwd123'
    }


def factory_user_session(target):
    
    name='tayna kihara'
    email='tay@getgeeks.com'
    password='tayna123'
    
    data = {
        'signup': {
            'name': name,
            'email': email,
            'password': password
        },
        'login': {
            'email': email,
            'password': password
        }
    }
    return data[target]