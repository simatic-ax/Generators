// USING Simatic.Ax.Generators;
// USING Simatic.Ax.Mocks;

// NAMESPACE Simatic.Ax.Generators.Test
//     {TestFixture}
//     CLASS TestActiveWait
//         VAR
//                 _state : OnDelayMockState;
//                 testInstance : PulseGenerator;
//         END_VAR
    
//         {Test}
//         METHOD PUBLIC Test_One_Clock_Cycle_Expect_True_False_True
//             VAR_TEMP
//                 res : BOOL;
//             END_VAR
//             testInstance.PulseTime := T#1s; // give the mocked timer an value to distiguish in the mock
//             testInstance.PauseTime := T#2s;

//             // Initial state --> Clock returns true, no timer is running
//             _state.StatusTimer1 := FALSE;
//             _state.StatusTimer2 := FALSE;

//             AxUnit.Mocking.Mock('System.Timer.OnDelay', NAME_OF(OnDelayMock2Timer), THIS._state); 
//             testInstance.Execute();
//             res := testInstance.Clock();
//             AxUnit.Assert.Equal(TRUE, res);
            
//             // second cycle --> Clock returns still true
//             testInstance.Execute();

//             res := testInstance.Clock();
//             AxUnit.Assert.Equal(TRUE, res);

//             // third cycle --> PulseTime has elapsed --> Clock returns false
//             _state.StatusTimer1 := TRUE;
//             _state.StatusTimer2 := FALSE;
//             testInstance.Execute();
//             res := testInstance.Clock();
//             AxUnit.Assert.Equal(FALSE, res);
            
//             // 4th Cycle  --> Clock returns still false. PauseTimer is running but is not elapsed
//             _state.StatusTimer1 := FALSE;
//             _state.StatusTimer2 := FALSE; 
//             testInstance.Execute();
//             res := testInstance.Clock();
//             AxUnit.Assert.Equal(FALSE, res);

//             // 5th cycle --> PauseTime has elapsed --> Clock returns false
//             _state.StatusTimer1 := FALSE;
//             _state.StatusTimer2 := TRUE;
//             testInstance.Execute();
//             res := testInstance.Clock();
//             AxUnit.Assert.Equal(TRUE, res);
//         END_METHOD
    
//     END_CLASS

// END_NAMESPACE




