# BioSemi-Wrappers

Python wrappers for BioSemi ActiveTwo Mk2 triggers execution via [DIO-24] and [LabJack U3].

Scripts were written by **Krzysztof Kutt** specifically for Experimental Neuropsychology Lab at Jagiellonian University / [Institute of Psychology]. __Check the scripts for detailed technical description about physical connections before using them!__

### LabJack U3 (USB interface)

Wrapper uses [official LabJack U3 Library]. Specifically it uses version available in PsychoPy at 01.01.2016 (LabJack library version annotated with [tag 10-22-2012] with small PsychoPy modifications).

If you want to send triggers that will be automatically added to EEG data by BioSemi device:
 1. Copy [labjackU3.py] file to your procedure directory. If you are not using the PsychoPy, copy also the [labjack directory].
 2. In your Python procedure:
    - Import labjackU3 wrapper (once at the top of the file):
      ``` 
      import labjackU3
      ```
    - Configure your U3 card (once at the begin of the procedure):
      ``` 
      labjackU3.configure()
      ```
    - When you want to send trigger simply put a line:
      ``` 
      labjackU3.trigger(VALUE)
      ```
      where `VALUE` is a number of a Trigger (1-255). You can see this number in BioSemi after setting triggers view to Decimal.
 3. For more information see comments in [labjackU3.py] file.

### DIO-24 (serial interface)

Wrapper uses [cbw32.dll] library, provided with the official drivers attached to the [DIO-24] card. Triggers are sent using the cable with connections depicted in the [DIO-BioSemi cable scheme].

If you want to send triggers that will be automatically added to EEG data by BioSemi device:
 1. Copy [cbw32.dll] and [dio24.py] files to your procedure directory.
 2. In your Python procedure:
    - Import PCI-DIO-24 wrapper (once at the top of the file):
      ``` 
      import dio24
      ```
    - Configure your PCI-DIO-24 card (once at the begin of the procedure):
      ``` 
      dio24.configure()
      ```
    - When you want to send trigger simply put a line:
      ``` 
      dio24.trigger(VALUE)
      ```
      where `VALUE` is a number of a Trigger (1-255). You can see this number in BioSemi after setting triggers view to Decimal.
 3. For more information see comments in [dio24.py] file.


[DIO-24]: <http://www.mccdaq.com/pci-data-acquisition/PCI-DIO24-Series.aspx>
[LabJack U3]: <https://labjack.com/products/u3>
[Institute of Psychology]: <http://www.psychologia.uj.edu.pl/index.php/eng/>
[official LabJack U3 Library]: <https://github.com/labjack/LabJackPython>
[tag 10-22-2012]: <https://github.com/labjack/LabJackPython/tree/10-22-2012>
[labjack directory]: <labjack/>
[labjackU3.py]: <labjackU3.py>
[cbw32.dll]: <cbw32.dll>
[dio24.py]: <dio24.py>
[DIO-BioSemi cable scheme]: <DIO-BioSemi%20cable.pdf>
