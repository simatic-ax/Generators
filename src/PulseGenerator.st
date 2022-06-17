USING System.Timer;
USING Simatic.Ax.IO.Input;

NAMESPACE Simatix.Ax.Generators
    CLASS PulseGenerator

        VAR PRIVATE
            _timePulse : OnDelay;
            _timePause : OnDelay;
            _timerIsRunning : BOOL;
            _internalTimerStatus : BOOL;
            _signal : BinSignal;
        END_VAR

        METHOD PUBLIC Execute
            VAR_INPUT
                pulse : LTIME;
                pause : LTIME;
            END_VAR

            _timePulse();
            _timePause();
            _signal.ReadCyclic(signal := _internalTimerStatus);

            IF (_timePause.output OR not(_timerIsRunning)) THEN
    
                _timePulse(signal := TRUE, duration := pulse);
                _timePause(signal := FALSE);
                _timerIsRunning := TRUE;
                _internalTimerStatus := TRUE;
            END_IF;

            if (_timePulse.output ) then 
                _timePause(signal := TRUE, duration := pause);
                _timePulse(signal := FALSE);
                _internalTimerStatus := FALSE;
            End_if;            
        END_METHOD
        
        METHOD PUBLIC Q : BOOL
            Q := _signal.Q();         
        END_METHOD

        METHOD PUBLIC QRis : BOOL
            QRis := _signal.QRis();
        END_METHOD

        METHOD PUBLIC QFal : BOOL
            QFal := _signal.QFal();
        END_METHOD

    END_CLASS
END_NAMESPACE
