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
        d_option, d_index = pick(
            [
                'Изменить стиль',
                'Закрыть'
            ],
            self.title,
            multiselect = False,
            min_selection_count = 1
        )

        try:
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
                            ThemeChanger('sparkle').change()
                        case 1:
                            ThemeChanger('firefly').change()
                        case 2:
                            ThemeChanger('russia').change()
                        case 3:
                            ThemeChanger('russia_slav').change()
                        case 4:
                            ThemeChanger('dragon_fight').change()
                        case 5:
                            ThemeChanger('ruins').change()
                case 1:
                    exit(0)
        except Exception as e:
            print(e)
            time.sleep(7)

HyprSettings().start()