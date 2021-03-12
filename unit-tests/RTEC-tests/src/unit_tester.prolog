/****************************************************
*                    		                    *
* Authors: Manolis Pitsikalis and Alexander Artikis *
*                                       	    *
*****************************************************/


:-use_module(library(system)).
:-['../../../src/RTEC.prolog'].


:- multifile updateSDE/1, updateSDE/2, updateSDE/3, testcase/9, testcaseE/9, testcaseSE/9, check/3.
:- discontiguous updateSDE/1, updateSDE/2, updateSDE/3, testcase/9, testcaseE/9, testcaseSE/9, check/3.

%runtests:-findall((Scen,C,N,E,R),(test(Scen,C,N,E,R)),TestResults),prettyPrint(TestResults).

% `runtests_prolog/0' runs all the loaded unit test cases with the use of the `runtestCL_prolog/1' predicate.
% It finds all the declared cases and calls prolog for each one separately.
% When calling this predicate, it is required to call prolog with the name of the
% test cases definitions file as a command line argument. For example:
%
% ~$ yap -l tests_file.prolog -- tests_file.prolog
%

runtests_swi:-current_prolog_flag(argv,[FileName]),runtests(FileName,swi),halt.
runtests_yap:-unix(argv([FileName])),runtests(FileName,yap),halt.

runtests(FileName,Prolog):-
           findall(Status,
            (   
                testDeclaration(Scen,C,N),
		(
                     Prolog = swi,
                     string_concat("echo 'runtestCL_swi,halt.' |swipl -q -l ",FileName,S1),                  
                     string_concat(S1," -- ",S2),
                     string_concat(S2,Scen,S3),                    
                     string_concat(S3," ",S4),
                     string_concat(S4,C,S5),
                     string_concat(S5," ",S6),                   
                     string_concat(S6,N,Call)
                ;
                     Prolog = yap,
                     atom_codes(FileName,FNA),
                     atom_codes(Scen,ScenA),
                     atom_codes(C,CA),
                     number_codes(N,NA),
                     append("echo 'runtestCL_yap,halt.' |yap -q -l ",FNA,S1),
                     append(S1," -- ",S2),
                     append(S2,ScenA,S3),
                     append(S3," ",S4),
                     append(S4,CA,S5),
                     append(S5," ",S6),
                     append(S6,NA,S7),
                     atom_chars(Call,S7)
                ),
                shell(Call,Status256),
                StatusF is Status256/256.0,
                Status is ceiling(StatusF)
            ),TestResults),
            sumlist(TestResults,Sum),
            length(TestResults,TestN),
            (
                Sum = 0,
                write('[92mPassed ('),
                write(TestN),
                writeln(' tests)[0m')
            ;
                Sum \=0,
                write('[92mPassed ('),
                TestsPassed is TestN-Sum,
                write(TestsPassed),
                writeln(' tests)[0m'),
                write('[91mFailed ('),
                write(Sum),
                writeln(' tests)[0m')
            ).

% runtestCL_prolog calls the appropriate runtestCL with the appropriate prolog type and then runs the unit test case with ScenarioID `Scen', Case `C' and Case number `Na'.
% Scen, C and Na are given as command line arguments in the yap call. After the unit test
% is completed prolog closes and returns 1 in case of unit test failure or 0 in case of success.
runtestCL_swi:-runtestCL(swi).
runtestCL_yap:-runtestCL(yap).

runtestCL(Prolog):-
    (
        Prolog = swi,
        current_prolog_flag(argv,[Scen,C,Na]),
        atom_number(Na,N)
        ;    
        Prolog = yap,
        unix(argv([Scen,C,Na])),
        number_atom(N,Na)
    ),
    testNR(Scen,C,N,E,R),
    prettyPrintT((Scen,C,N,E,R),Status),
    (
        Status = failed,
        halt(1)
    ;
        Status = passed,
        halt
    ).


% testDeclaration is defined like testNR (see comments below), without calling the case predicate.
% Essentially, testDeclaration is used to build the command for executing the unit test
% while testNR is used to actually execute the unit test
% -- A -- one for narratives of type updateSDE(ScenarioID)
% -- B -- one for narratives of type updateSDE(ScenarioID,CurrentTime)
% -- C -- one for narratives of type updateSDE(ScenarioID,StartTime,CurrentTime)
%  A 
testDeclaration(Scenario,CaseName,CaseNumber) :-
    testcase(Scenario,CaseName,CaseNumber,_,_,_,_,_,_).
%  B
testDeclaration(Scenario,CaseName,CaseNumber) :-
    testcaseE(Scenario,CaseName,CaseNumber,_,_,_,_,_,_).
%  C
testDeclaration(Scenario,CaseName,CaseNumber) :-
    testcaseSE(Scenario,CaseName,CaseNumber,_,_,_,_,_,_).



%testNR predicate gets the information of the declared testcase fact,
% then runs the test, there are three versions of this predicate
% -- A -- one for narratives of type updateSDE(ScenarioID)
% -- B -- one for narratives of type updateSDE(ScenarioID,CurrentTime)
% -- C -- one for narratives of type updateSDE(ScenarioID,StartTime,CurrentTime)
%  A 
testNR(Scenario, CaseName, CaseNumber, Expected, Result) :-
    testcase(Scenario, CaseName, CaseNumber, Expected, Ts, InputFlag, DynamicGroundingFlag, PreProcessingFlag, TemporalDistance),
    case(Scenario, CaseName, CaseNumber, Ts, Expected, Result, InputFlag, DynamicGroundingFlag, PreProcessingFlag, TemporalDistance).
%  B
testNR(Scenario, CaseName, CaseNumber, Expected, Result) :-
    testcaseE(Scenario, CaseName, CaseNumber, Expected, Ts, InputFlag, DynamicGroundingFlag, PreProcessingFlag, TemporalDistance),
    caseE(Scenario, CaseName, CaseNumber, Ts, Expected, Result, InputFlag, DynamicGroundingFlag, PreProcessingFlag, TemporalDistance).
%  C
testNR(Scenario, CaseName, CaseNumber, Expected, Result) :-
    testcaseSE(Scenario,CaseName,CaseNumber,Expected,Ts, InputFlag, DynamicGroundingFlag, PreProcessingFlag, TemporalDistance),
    caseSE(Scenario, CaseName, CaseNumber, Ts, Expected, Result, InputFlag, DynamicGroundingFlag, PreProcessingFlag, TemporalDistance).



% recognition part for each testcase, similarly with the
% test predicate, case predicate has a version for each
% type of narrative
case(ScenarioId, CaseName, CaseNumber, Ts, Expected, Result, InputFlag, DynamicGroundingFlag, PreProcessingFlag, TemporalDistance):-
    initialiseRecognition(InputFlag, DynamicGroundingFlag, PreProcessingFlag, TemporalDistance),
    updateSDE(ScenarioId),
    (Step,Window,Start,End) = Ts,
    createErTimes(Step,Window,Start,End,ErTimes),
    performER(CaseName,CaseNumber,ErTimes,Found),!,
    compareResult(Expected,Found,Result).

caseE(ScenarioId, CaseName, CaseNumber, Ts, Expected, Result, InputFlag, DynamicGroundingFlag, PreProcessingFlag, TemporalDistance):-
    initialiseRecognition(InputFlag, DynamicGroundingFlag, PreProcessingFlag, TemporalDistance),
    (Step,Window,Start,End) = Ts,
    createErTimes(Step,Window,Start,End,ErTimes),
    performER(e,CaseName,CaseNumber,ErTimes,Found,ScenarioId),!,
    compareResult(Expected,Found,Result).

caseSE(ScenarioId, CaseName, CaseNumber, Ts, Expected, Result, InputFlag, DynamicGroundingFlag, PreProcessingFlag, TemporalDistance):-
    initialiseRecognition(InputFlag, DynamicGroundingFlag, PreProcessingFlag, TemporalDistance),
    (Step,Window,Start,End) = Ts,
    createErTimes(Step,Window,Start,End,ErTimes),
    performER(se,CaseName,CaseNumber,ErTimes,Found,ScenarioId),!,
    compareResult(Expected,Found,Result).


% given then values of step, WM, a start time and an end time, createErTimes creates
% a list containing the pairs of window size and current time
createErTimes(Step,Window,Start,End,ErTimes):-crErTimes(Step,Window,Start,End,ErTimes).
crErTimes(Step,Window,Current,End,[(Cu,Window)|Other]):-
    Cu is Current+Step,
    Cu < End,
    crErTimes(Step,Window,Cu,End,Other).
crErTimes(Step,Window,Current,End,[(End,Window)]):-
    Cu is Current+Step,
    Cu >= End.

%performER performs event recognition, similarly there are three versions
%  A
performER(_CaseName,_CaseNumber,[],[]).
performER(CaseName,CaseNumber,[(CT,PT)|OtherT],[Found|OtherFoundInt]) :-
    eventRecognition(CT, PT),
    check(CaseName,CaseNumber,Found),
    performER(CaseName,CaseNumber,OtherT,OtherFoundInt).

%  B
performER(e,_CaseName,_CaseNumber,[],[],_).
performER(e,CaseName,CaseNumber,[(CT,PT)|OtherT],[Found|OtherFoundInt],ScenarioId) :-
    updateSDE(ScenarioId,CT),
    eventRecognition(CT, PT),
    check(CaseName,CaseNumber,Found),
    performER(e,CaseName,CaseNumber,OtherT,OtherFoundInt,ScenarioId).

%  C
performER(se,_CaseName,_CaseNumber,[],[],_).
performER(se,CaseName,CaseNumber,[(CT,PT)|OtherT],[Found|OtherFoundInt],ScenarioId) :-
    InitTime is CT-PT,
    updateSDE(ScenarioId,InitTime,CT),
    eventRecognition(CT, PT),
    check(CaseName,CaseNumber,Found),
    performER(se,CaseName,CaseNumber,OtherT,OtherFoundInt,ScenarioId).


% compareResult returns the differences between the expected
% result and the test result in a list of lists, where each 
% list corresponds to a query
compareResult([],[],[]).
compareResult([Ex|OtherEx],[Found|OtherFound],[(Status,Common,FP,FN)|OtherComps]):-
    %write(compareResult),nl,
    (
        intersect_all([Ex,Found],Common),
        union_all([Ex,Found],Common),
        Status=passed,
        FP=[],
        FN=[],
        compareResult(OtherEx,OtherFound,OtherComps)
    );
    (
        intersect_all([Ex,Found],Common),
        union_all([Ex,Found],Union),
        Union\=Common,
        Status=failed,
        relative_complement_all(Ex,[Found],FN),
        relative_complement_all(Found,[Ex],FP),
        compareResult(OtherEx,OtherFound,OtherComps)
    ).


%prints the results of all tests in a human readable form
prettyPrint(Results):-prettyPrint(Results,0,0).

prettyPrint([],Passed,Failed) :-
    write('Tests passed: '),write(Passed),nl,
    write('Tests failed: '),write(Failed),nl.

prettyPrint([A|Other],Passed,Failed):-
    prettyPrintT(A,Status),
    ((
    	Status = failed,
        FailedPlus1 is Failed+1,
        prettyPrint(Other,Passed,FailedPlus1)
    );
    (
        Status = passed,
    %    write('Status: '),write('passed'),nl,nl,
        PassedPlus1 is Passed+1,
        prettyPrint(Other,PassedPlus1,Failed)
    )).

prettyPrintT((_Scen,C,N,_E,Result),Status):-
    (
        member((failed,_,_,_),Result),
        write('Case name: '),write(C),write('\t'),
        write('Case number: '),write(N),write('\t'),
        %write(Result),nl,
        write('Status: '),write('failed'),nl,
        explainFailure(Result),nl,
        Status=failed
    );
    (
    %    write('Status: '),write('passed'),nl,nl,
        Status=passed
    ).

% In case of a failure, prints true positives,
% false positives and false negatives.
explainFailure(Res):-explainFailure(Res,0).
explainFailure([],_).
explainFailure([(passed,_,_,_)|Other],N):-Np1 is N+1,explainFailure(Other,Np1).
explainFailure([(failed,TP,FP,FN)|Other],N):-
    Np1 is N+1,
    write('-ER number: '),write(N),nl,
    write('--TP: '),write(TP),nl,
    write('--FP: '),write(FP),nl,
    write('--FN: '),write(FN),nl,
    explainFailure(Other,Np1).

