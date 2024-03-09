% Rules defining output entities
initiatedAt(disease(Patient,ICD10)=true, T) :-
    happensAt(has_diag(Patient,ICD10), T).

holdsFor(lungC_disease(Patient)=true, I) :-
    holdsFor(disease(Patient,c34)=true, I).

% Grounding of input entities 
grounding(has_diag(Patient,ICD10)) :- patient(Patient), diagnosis(ICD10).

% Grounding of output entities
grounding(disease(Patient,ICD10)=true) :- patient(Patient), diagnosis(ICD10).
grounding(lungC_disease(Patient)=true) :- patient(Patient).
