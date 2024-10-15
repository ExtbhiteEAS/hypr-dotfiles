import os
import random
import string

video_output_name = str(
    input('Введите любой текст, чтобы видео было сохранено под него(или оставьте пустое значение чтобы было случайные буквы): ')
)

if video_output_name == '':
    video_name = ''.join([
        random.choice(string.ascii_letters) for i in range(12)
    ])
else:
    video_name = video_output_name

video_path = '~/Видео/'

print(f'Видео будет сохранено по пути: {video_path}video_{video_name}.mp4')

input_command = f'gpu-screen-recorder -w screen -f 144 -a "$(pactl get-default-sink).monitor" -o {video_path}video_{video_name}.mp4'
os.system(input_command)
