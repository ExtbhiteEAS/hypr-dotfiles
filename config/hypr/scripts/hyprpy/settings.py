import time

from pick import pick
from styles import *

class HyprSettings:
    def __init__(self) -> None:
        self.title = """
Настройки данной конфигурации. Обратите внимание на то, что оно ещё не завершено.
Не все конфигурации, например, стилей цвета будут меняться.
"""
    
    def start(self):
        try:
            d_option, d_index = pick(
                ['Изменить стиль'],
                self.title,
                multiselect = False,
                min_selection_count = 1
            )

            match d_index:
                case 0:
                    s_option, s_index = pick(
                        metadata.style_options,
                        self.title,
                        multiselect = False,
                        min_selection_count = 1
                    )
                    match s_index:
                        case 0:
                            ChangeTo("sparkle")
                        case 1:
                            ChangeTo("firefly")
                        case 2:
                            ChangeTo("russia")
                        case 3:
                            ChangeTo("russia_slav")
                        case 4:
                            ChangeTo("dragon_fight")
                        case 5:
                            ChangeTo("ruins")
        except Exception as e:
            print(e)
            time.sleep(5)

HyprSettings().start()