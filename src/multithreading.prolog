% Author: Manolis Pitsikalis
%
% - Dependency aware parallelisation -
%
% Create workers, and then assign 
% definitions for them to process
% based on their met/unmet dependencies
%

% if cpu count is 1 then run it sequentially
dependency_aware_parallel_execution(List, _) :-
    current_prolog_flag(cpu_count, 1), !,
    maplist(run_goal, List).

% if cpu count > 1 apply parallel execution where possible
dependency_aware_parallel_execution(List, Options) :-
    current_prolog_flag(cpu_count, N), !,
    must_be(list(callable), List),
    length(List, JobCount),
    message_queue_create(Done),
    message_queue_create(Queue),
    WorkerCount is min(N, JobCount),
    create_query_workers(WorkerCount, Queue, Done, Workers, Options),
    feed_goals_with_dependencies(WorkerCount, List, [], JobCount, Queue, Done, cleanup(Workers, Queue)),
    join_all(Workers),
    message_queue_destroy(Queue),
    message_queue_destroy(Done).

run_goal(goal(_OE,Goal)) :-
    call(Goal), !.

% assign goals to workers
% if available goals is empty and the phenomena are all processed
% then terminate the worker threads. If the available goals are empty
% but the phenomena are not all processed then wait until processing is finished
feed_goals_with_dependencies(WorkerCount, [], FinishedGoals, TotalJobCount, Queue, Done, Cleanup):-
    !,length(FinishedGoals, FinishedGoalsCount),
    (
        (
         FinishedGoalsCount<TotalJobCount,!,
         thread_get_message(Done, done(_Id, OE)),
         feed_goals_with_dependencies(WorkerCount, [], [OE|FinishedGoals], TotalJobCount, Queue, Done, Cleanup)
        )
        ;
        (
         FinishedGoalsCount=TotalJobCount,
         forall(between(1, WorkerCount, _),
            thread_send_message(Queue, done))
        )
    ).

% find goals with all dependencies met and assign them to workers
feed_goals_with_dependencies(WorkerCount, AvailableGoals, FinishedGoals, TotalJobCount,  Queue, Done, Cleanup):-
    get_ready_to_start_goals(AvailableGoals, FinishedGoals, ReadyGoals, RemainingGoals),
    submit_query_goals(ReadyGoals, 1, Queue),
    thread_get_message(Done, done(_Id, OE)),
    feed_goals_with_dependencies(WorkerCount, RemainingGoals, [OE|FinishedGoals], TotalJobCount, Queue, Done, Cleanup),!.

% worker code
query_worker(Queue, Done) :-
    thread_get_message(Queue, Message),
    debug(concurrent, 'Worker: received ~p', [Message]),
    (   Message = job(Id, Goal)
    ->  (   Goal = goal(OE,GoalToRun),
            catch(GoalToRun, Caught,format("Caught: ~q~n",[Caught]))
        ->  thread_send_message(Done, done(Id, OE)),
            query_worker(Queue, Done)
        )
    ;   true
    ).

% workers creation
create_query_workers(N, Queue, Done, [Id|Ids], Options) :-
    N > 0,
    !,
    thread_create(query_worker(Queue, Done), Id,Options),
    N2 is N - 1,
    create_query_workers(N2, Queue, Done, Ids, Options).

create_query_workers(_, _, _, [], _).

% assign goals to workers
submit_query_goals([], _,  _):-!.
submit_query_goals([H|T], I, Queue) :-
    thread_send_message(Queue, job(I, H)),
    I2 is I + 1,
    submit_query_goals(T, I2, Queue).

% find goals that don't have unmet dependencies
get_ready_to_start_goals([], _, [], []):-!.
get_ready_to_start_goals([Goal|OtherGoals], FinishedGoals, ReadyGoals, RemainingGoals):-
    Goal=goal(OE, _GoalToRun),
    dependencies(OE, DependencyList),
    get_ready_to_start_goals(OtherGoals, FinishedGoals, ReadyGoals1, RemainingGoals1),
    (   all_dependencies_in_finished_goals(DependencyList, FinishedGoals)
    -> (    ReadyGoals = [Goal|ReadyGoals1], RemainingGoals = RemainingGoals1)
    ; (ReadyGoals=ReadyGoals1, RemainingGoals=[Goal|RemainingGoals1])).

%check that a list of dependencies has only met dependencies
all_dependencies_in_finished_goals([],_).
all_dependencies_in_finished_goals([A|A1],B):-
    member(A, B), all_dependencies_in_finished_goals(A1,B).
    
dependencies(OE, Dependecies):-
    processingLevel(Level, _, OE),
    findall(OEi,(
    		 processingLevel(Li, _, OEi), Li < Level
    		), Dependecies).   

join_all([]).
join_all([Id|T]) :-
    thread_join(Id, _),
    join_all(T).
