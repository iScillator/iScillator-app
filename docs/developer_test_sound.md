#Интерфейс отладки воспроизведения

* Button Play
* Button Stop

* Combobox (Моно/Стерео)

* Frame Канал 1
  * Textbox Frequency (default=422)  * Label "Hz"
  * Textbox Amplitude (default=100) * Label "%"
  * Dropdown "Wave type" (Sinus/default=Square/Damped wave/Hoyland wave)
  * Dropdown "Gating payload" (100%/Default=80%/75%/50%/25%)
  * Textbox "Gating frequency" (Default=1333) * Label "Hz" 

* Frame Канал 2 [enabled только если режим стерео, состав фрэйма такой же как Канал 1]


* Frame служебная информация
 * Label "Bitrate" отображает поддерживаемый bitrate например 32bit
 * Label "type" отображает поддерживаемый type например int16/int32/floating point
 * Label "discretisation frequency" отображает поддерживаемую частоту дискретизации например 44000 / 192000 Hz

