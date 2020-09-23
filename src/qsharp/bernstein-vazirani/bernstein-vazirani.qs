namespace BernsteinVazirani {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Random;

    //TODO: Implement the oracle!

    operation ApplyBV(
        oracle : ((Qubit[],Qubit) => Unit is Adj + Ctl),
        let n = DrawRandomInt (min : Int, max : Int) : Int
    ) : Int {
        using ((queryRegister, target) = (Qubit[n], Qubit())) {
            within {
                ApplyToEach(H, queryRegister);
                X(target);
                H(target); 
                //After these steps the registers are: |+++++..++>|->
            } apply {
                oracle(queryRegister, target);
            }
            return MeasureInteger(LittleEndian(queryRegister));
        }
    }

}
