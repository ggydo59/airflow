def get_sftp():
    print('sftp 작업시작')
    
def regist(name, sex, *args):
    print(f"name = {name}")
    print(f"sex = {sex}")
    
    country = args[0] if len(args) >=1 else None
    city = args[1] if len(args) >=1 else None
    print(f"country = {country}")
    print(f"city={city}")
    
    
def regist2(name, sex, *args, **kwargs):
    print(f"name = {name}")
    print(f"sex = {sex}")
    print(f"args = {args}")
    print(f"kwargs = {kwargs.get()}")