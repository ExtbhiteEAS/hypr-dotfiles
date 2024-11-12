import os

urls = {
    'Vencord': 'https://github.com/Vendicated/Vencord.git',
    'Equicord': 'https://github.com/Equicord/Equicord.git'
}

def command_get(url: str, directory: str):
    command = f"""git clone {url} &&
cd {directory} && sudo npm i -g pnpm && pnpm i &&
cd src/ && mkdir userplugins &&
cd userplugins/ && git clone https://github.com/gujarathisampath/fakeProfile.git && pnpm build &&
cd .. & cd .. &&
cd ..
"""
    return command

def install(url: str, directory: str):
    os.system(command_get(url, directory))

def proccess():
    choose_loop = True
    print("[INFO] Модифицированные клиенты Discord:\n1. Vencord\n2. Equicord\n")

    while choose_loop:
        mod_client_choose = int(input('[ACTION] Выберите модифицированный клиент : '))

        match mod_client_choose:
            case 1:
                install(urls['Vencord'], 'Vencord/')
                choose_loop = False; break
            case 2:
                install(urls['Equicord'], 'Equicord/')
                choose_loop = False; break
            case 0:
                print('[WARN] Неверный выбор модифицированного клиента.')

proccess()