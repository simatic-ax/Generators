USING Simatic.Ax.Generators;

NAMESPACE Simatic.Ax.Generators.Test
    {TestFixture}
    CLASS TestActiveWait
        VAR
                _state : OnDelayMockState;
                testInstance : PulseGenerator;
        END_VAR
    
        {Test}
        METHOD PUBLIC Test_One_Clock_Cycle_Expect_True_False_True
            VAR_TEMP
                res : BOOL;
            END_VAR
            testInstance.PulseTime := T#1s; // give the mocked timer an value to distiguish in the mock
            testInstance.PauseTime := T#2s;

            // Initial state --> Clock returns true, no timer is running
            _state.Timer1 := FALSE;
            _state.Timer2 := FALSE;

            AxUnit.Mocking.Mock('System.Timer.OnDelay', NAME_OF(OnDelayMock), THIS._state); 
            testInstance.Execute();
            res := testInstance.Clock();
            AxUnit.Assert.Equal(TRUE, res);
            
            // second cycle --> Clock returns still true
            testInstance.Execute();
            res := testInstance.Clock();
            AxUnit.Assert.Equal(TRUE, res);

            // third cycle --> PulseTime has elapsed --> Clock returns false
            _state.Timer1 := TRUE;
            _state.Timer2 := FALSE;
            testInstance.Execute();
            res := testInstance.Clock();
            AxUnit.Assert.Equal(FALSE, res);
            
            // 4th Cycle  --> Clock returns still false. PauseTimer is running but is not elapsed
            _state.Timer1 := FALSE;
            _state.Timer2 := FALSE; 
            testInstance.Execute();
            res := testInstance.Clock();
            AxUnit.Assert.Equal(FALSE, res);

            // 5th cycle --> PauseTime has elapsed --> Clock returns false
            _state.Timer1 := FALSE;
            _state.Timer2 := TRUE;
            testInstance.Execute();
            res := testInstance.Clock();
            AxUnit.Assert.Equal(TRUE, res);
        END_METHOD
    
    END_CLASS

    FUNCTION_BLOCK OnDelayMock
        VAR
            iecTimer : ARRAY[0..27] of BYTE;
        END_VAR
        VAR_INPUT
            duration : LTIME;
            signal : BOOL;
        END_VAR
        VAR_OUTPUT
            output : BOOL;
            elapsedTime : LTIME;
        END_VAR
        VAR_TEMP
            state : REF_TO OnDelayMockState;
        END_VAR

        state ?= AxUnit.Mocking.GetPayload();
        
        IF (signal = FALSE) THEN
            output := FALSE;
        ELSE
            IF duration = T#1s THEN
                output := state^.Timer1;
            END_IF;
            IF duration = T#2s THEN
                output := state^.Timer2;
            END_IF;
        END_IF;           
            

    END_FUNCTION_BLOCK 
        
    CLASS OnDelayMockState IMPLEMENTS AxUnit.Mocking.IPayload
        VAR PUBLIC
            Timer1 : BOOL;
            Timer2 : BOOL;
        END_VAR
    END_CLASS
    


END_NAMESPACE




