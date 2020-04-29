n_Symb = 98304;
OSF = 4;
%for OSF = 2.^(0:)
    for TAP = 11:10:31
        status = [OSF,TAP]
        fun_test_ber(TAP,OSF,98304)
    end
%end
