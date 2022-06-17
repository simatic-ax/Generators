USING AxUnit.Assert;
USING Simatic.Ax.Generators;

NAMESPACE Simatic.Ax.Library
    {TestFixture}
    CLASS MyTestFixture
        VAR
            o : PulseGenerator;
        END_VAR

        {Test}
        METHOD PUBLIC MyTestMethod
            o.Execute();
            ; // AxUnit.Assert.Equal(expected := y, actual := x);
        END_METHOD
    END_CLASS
END_NAMESPACE