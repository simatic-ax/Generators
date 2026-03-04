NAMESPACE Simatic.Ax.Mocks
    /// This Mock can be used in Classes/FunctionBlocks where are two OnDelay instances are used
    {axcode:docs-v0:@simatic-ax/generators:OnDelayMockWithTwoTimers.md}
    FUNCTION_BLOCK OnDelayMock2Timer
        VAR_INPUT
            /// Signal to be monitored.
            signal: BOOL;
            /// Duration of the delay.
            duration: LTIME;
        END_VAR

        VAR_OUTPUT
            /// Operand that is set after the delay.
            output: BOOL;
            /// Current elapsed time.
            elapsedTime: LTIME;
        END_VAR

        VAR PRIVATE
            risingEdge: BOOL;
            previousSignal: BOOL;
            startTime: LTIME;
            currentDuration: LTIME;
        END_VAR

        VAR INTERNAL
            reset: BOOL := FALSE;
            preset: BOOL := FALSE;
            presetDuration: LTIME := LT#0ns;
        END_VAR
        VAR_TEMP
            state : REF_TO OnDelayMockState;
        END_VAR

        state ?= AxUnit.Mocking.GetPayload();
        output := TRUE;

        IF (signal = FALSE) THEN
            output := FALSE;
        ELSE
            IF duration = T#1s THEN
                output := state^.StatusTimer1;
            END_IF;
            IF duration = T#2s THEN
                output := state^.StatusTimer2 ;
            END_IF;
        END_IF;           

    END_FUNCTION_BLOCK 

    /// The returned states for the Timer1 and Timer2
    {axcode:docs-v0:@simatic-ax/generators:OnDelayMockWithTwoTimers.md}
    CLASS OnDelayMockState IMPLEMENTS AxUnit.Mocking.IPayload
        VAR PUBLIC
            StatusTimer1 : BOOL;
            StatusTimer2 : BOOL;
        END_VAR
    END_CLASS
END_NAMESPACE




