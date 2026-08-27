 # Compiler unit tests.

 ## Execution instructions

 To run the unit tests of RTEC's compiler, run the runallcompilertests-SWI.sh script (which uses SWI Prolog) or the runallcompilertests-YAP.sh script (uses YAP); eg:
 
 ```
 ./runallcompilertests-SWI.sh
 
 ```
 or

 ```
 ./runallcompilertests-YAP.sh

 ```

 ## Notes

 Each unit test includes:

 - rules.prolog: manually constructed, non-compiled rules.
 - declarations.prolog: manually constructed declarations.
 - rules_compiled_c.prolog: rules compiled by means of RTEC's compiler.
 - rules_compiled_t.prolog: manually compiled rules.

 Unit testing then amounts to:
 - invoking the compiler to compile rules.prolog into rules_compiled_c.prolog using the declarations;
 - comparing rules_compiled_c.prolog and rules_compiled_t.prolog.
