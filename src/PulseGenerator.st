USING System.Timer;
USING Simatic.Ax.IO.Input;

NAMESPACE Simatic.Ax.Generators

    CLASS PulseGenerator

        
        VAR PUBLIC
            PulseTime : LTIME := T#1s;  // Pulse duration
            PauseTime : LTIME := T#1s;  // Pause duration ( PulseTime + PauseTime = Period )
        END_VAR

        VAR PRIVATE
            _timePulse : OnDelay;
            _timePause : OnDelay;
            _timerIsRunning : BOOL;
            _internalTimerStatus : BOOL;
            _signal : BinSignal;
        END_VAR

        
        {axcode:docs-v0:generators:PulseGenerator.md}
        // execute the clock signal. Must called cycically 
        METHOD PUBLIC Execute
            
            _timePulse();
            _timePause();

            // evaluate pulse signal
            IF (_timePause.output OR NOT(_timerIsRunning)) THEN
                _timePulse(signal := TRUE, duration := PulseTime);
                _timePause(signal := FALSE);
                _timerIsRunning := TRUE;
                _internalTimerStatus := TRUE;
            END_IF;

            // evaluate a pause signal
            IF (_timePulse.output ) THEN 
                _timePause(signal := TRUE, duration := PauseTime);
                _timePulse(signal := FALSE);
                _internalTimerStatus := FALSE;
            END_IF;      
            
            _signal.ReadCyclic(signal := _internalTimerStatus);

        END_METHOD
                
        // returns the clock signal
        METHOD PUBLIC Clock : BOOL
            Clock := _signal.Q();         
        END_METHOD

        // returns the rising edge of the clock signal
        METHOD PUBLIC ClockRis : BOOL
            ClockRis := _signal.QRis();
        END_METHOD

        // returns the falling edge of the clock signal
        METHOD PUBLIC ClockFal : BOOL
            ClockFal := _signal.QFal();
        END_METHOD

    END_CLASS
END_NAMESPACE
