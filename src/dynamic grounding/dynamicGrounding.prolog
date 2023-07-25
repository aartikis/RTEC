% ordered lists and set operations
:-use_module(library(ordsets)).

% dynamicGrounding(+Ts,+Te)
% perform dynamic grounding in (Ts,Te]
dynamicGrounding(_Ts,_Te) :-
	noDynamicGrounding, !.

dynamicGrounding(Ts,Te) :-
    % fetch groundTermOverlapThreshold from db
    groundTermOverlapThreshold(OverlapThreshold),
	% collectGrounds is defined in the declarations 
    forall(collectGrounds(InputEvents,GroundTerm),(
        % all old terms 
        findall(GroundTerm,GroundTerm,AllOldTermsDup),
        % convert to set, ie remove duplicates and order
        list_to_ord_set(AllOldTermsDup,AllOldTerms),

        % old terms that remain
        % find the terms that should remain, ie the ones starting in the previous window and have open intervals
        findRemainingTerms(GroundTerm,RemainingTermsDup),
        list_to_ord_set(RemainingTermsDup,RemainingTerms),

        % terms from input events from current window
        findInputTerms(InputEvents,GroundTerm,Ts,Te,[],InputTermsDup),
        list_to_ord_set(InputTermsDup,InputTerms),

        % All terms required for the next window(AllNewTerms)
        ord_union(RemainingTerms,InputTerms,AllNewTerms,_),
        % CommonTerms is the intersection of AllNewTerms and AllOldTerms
        % TermsToRetract is AllOldTerms - AllNewTerms
        ord_intersection(AllNewTerms, AllOldTerms, CommonTerms, TermsToRetract), % ord_union to find TermsToRetract is redundant now.
        % NewTermsToAdd is AllNewTerms - AllOldTerms
        ord_union(AllOldTerms,AllNewTerms,_,NewTermsToAdd), 

        % Number of CommonTerms and AllOldTerms. 
        length(CommonTerms, CommonTermsNo),
        length(AllOldTerms, OldTermsNo),

        CommonTermsNoThreshold is OverlapThreshold*OldTermsNo,
        (   
            % If number of common terms> number of old terms * threshold ratio, then do not retract-assert the terms in the intersection.
            % retract_grouding retracts the terms of a list one by one.  
            CommonTermsNo>CommonTermsNoThreshold,
            retract_grounding(TermsToRetract),  
            assert_grounding(NewTermsToAdd)
            ;
            % Else, the number of common terms is not greater than the threshold number of terms, then retract all old terms and assert all new terms.
            % This method may decrease computational cost, because retractall is much faster compared it many single retracts. 
            CommonTermsNo=<CommonTermsNoThreshold,
            retractall(GroundTerm), 
            assert_grounding(AllNewTerms)
        )
    )),
    removeOutdated.

% findInputTerms(+InputEvents,+GroundTerm,+Ts,+Te,+OldTerms,-NewTerms).
findInputTerms([],_,_,_,Terms,Terms).
findInputTerms([Event|Other],GroundTerm,Ts,Te,OldTerms,NewTerms):-
    event(Event),
    findall(GroundTerm,(happensAtIE(Event,T),T>Ts,T=<Te),CurrentTerms),
    append(OldTerms,CurrentTerms,TermsSoFar),
    findInputTerms(Other,GroundTerm,Ts,Te,TermsSoFar,NewTerms).
findInputTerms([Event|Other],GroundTerm,Ts,Te,OldTerms,NewTerms):-
    sDFluent(Event),
%    findall(GroundTerm,(index(Event,Index),holdsForProcessedIE(Index,Event,_)),CurrentTerms),
    findall(GroundTerm,(holdsForIESI(Event,_)),CurrentTerms),
    append(OldTerms,CurrentTerms,TermsSoFar),
    findInputTerms(Other,GroundTerm,Ts,Te,TermsSoFar,NewTerms).


% findRemainingTerms(+GroundTerm, -RemainingTerms)
% find terms that should remain
findRemainingTerms(GroundTerm,RemainingTerms):-
    findall((Event,GroundTerm),dgrounded(Event,GroundTerm),Events),
    findRemainingTerms(Events,[],RemainingTerms).

findRemainingTerms([],Terms,Terms).
findRemainingTerms([(Event,GroundTerm)|Other],OldTerms,NewTerms):-
    % check the corresponding lists for open intervals
    % if there are the term must stay
    findall(GroundTerm, (
                            index(Event,I),
                            (
				(sDFluent(Event),
				 outputEntity(Event),
                                 sdFPList(I,Event,L,_))
                                ;
				(simpleFluent(Event),
                                simpleFPList(I,Event,L,_))
				;
				(sDFluent(Event),
				 inputEntity(Event),
                		 iePList(I,Event,L,_))
                            ),
                            L\=[],
                            append(_,[(_,inf)],L)
                        ),
            CurrentTerms),
    append(OldTerms,CurrentTerms,TermsSoFar),
    findRemainingTerms(Other,TermsSoFar,NewTerms).

removeOutdated:-
    % find all fluent value pairs whose arguments are dynamic-grounded in this window, and retract the maximal intervals of all the remaining ones.
    % FVPs who had a open interval are not retracted because they were dynamic-grounded in this window by findRemainingTerms.
    findall((Index, F=V), (simpleFPList(Index, F=V, RestrictedList, Extension), \+cachingOrder2(Index, F=V), 
                           retract(simpleFPList(Index, F=V, RestrictedList, Extension))), _SimpleFluentList),
    %
    findall((Index, F=V), (sdFPList(Index, F=V, RestrictedList, Extension), \+cachingOrder2(Index, F=V), 
                           retract(sdFPList(Index, F=V, RestrictedList, Extension))), _SDFluentList), 
    %
    findall((Index, F=V), (iePList(Index, F=V, RestrictedList, Extension), \+cachingOrder2(Index, F=V), 
                           retract(iePList(Index, F=V, RestrictedList, Extension))), _InputSDFluentList).

% assert_grounding(+Term)
assert_grounding([]).
assert_grounding([Term|Other]):-
    assertz(Term),
    assert_grounding(Other).


% retract_grounding(+Term)
retract_grounding([]).
retract_grounding([Term|Other]):-
    retract(Term),
    retract_grounding(Other).
