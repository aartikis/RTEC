
:-['toy_event_stream.prolog'].
:-['../../src/RTEC.prolog'].
:-['toy_var_domain.prolog'].
:-['toy_declarations.prolog'].
:-['toy_rules_compiled.prolog'].


performER :-
          initialiseRecognition(unordered, nopreprocessing, 1),
          updateSDE(story, 9, 21),
          eventRecognition(21, 21).
