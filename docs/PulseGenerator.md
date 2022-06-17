# PulseGenerator

## Description

PulseGenerator class creates a pulse signal with a configurabel pulse pause duration

## Install this package

```cli
apax add @simatic-ax/generators
```

## Namespace
```
Simatic.Ax.Generators;
```

## Configuration

|||
|-|-|
| PulseTime | Defines the pulse time for the signal |
| PauseTime | Defines the pause time for the signal |

Example configuration in a VAR section
```iec-st
 clock : PulseGenerator := (PulseTime := T#0.5s, PauseTime := T#0.5s);
```


## Methods

|||
|-|-|
| Execute() | Execute the clock signal. Must called cycically |
| Clock() : BOOL | Returns the clock signal |
| ClockRis() : BOOL | Returns the rising edge of the clock signal |
| ClockFal() : BOOL | Returns the falling edge of the clock signal |


## Example
```iec-st
USING Simatic.Ax.Generators;

CONFIGURATION MyConfiguration
    TASK Main(Priority := 1);
    
    PROGRAM P1 WITH Main: MainProgram;
        
    VAR_GLOBAL
        clock : PulseGenerator := (PulseTime := T#0.5s, PauseTime := T#0.5s);
        clk : BOOL;
    END_VAR
END_CONFIGURATION

PROGRAM MainProgram
    
    VAR_EXTERNAL
        clock : PulseGenerator;
        clk : BOOL;
    END_VAR

    clock.Execute();
    clk := clock.Clock();
      
END_PROGRAM
```


