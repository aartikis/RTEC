
:- ['../../CE patterns/compiled_ctm_CE_patterns.prolog'].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Notes: 
% The LastTime of the dataset is 50000.
% TimesFile records the event recognition times, 
% while InputFile records the number of input events per window.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

continuousER(TimesFile, WM, Step, LastTime) :-
  open(TimesFile, write, TimesStream),
  initialiseRecognition(unordered, nopreprocessing, 1),
  updateManySDE( 0, WM, '1p_all' ),
  WMPlus1 is WM+1, 
  % the first event recognition time should not be counted
  % because there are no old input facts being retracted
  eventRecognition(WM, WMPlus1),
  CurrentTime is WM+Step,
  updateManySDE(WM, CurrentTime, '1p_all' ), 
  write('ER: '), write(CurrentTime), write(WM), nl, 
  statistics(cputime, [S1,T1]), 
  eventRecognition(CurrentTime, WM), 
  findall((F=V,L), (outputEntity(F=V),holdsFor(F=V,L)), CC),  
  statistics(cputime, [S2,T2]), T is T2-T1, S is S2-S1, %S=T2,
  write(TimesStream, S),
  NewCurrentTime is CurrentTime+Step,
  querying(TimesStream, WM, Step, NewCurrentTime, LastTime, [S], WorstCase),
  % calculate average query time
  sum_list(WorstCase, Sum),
  length(WorstCase, L),
  AvgTime is Sum/L,
  nl(TimesStream), write(TimesStream, AvgTime),
  % calculate max query time
  max_list(WorstCase, Max),
  nl(TimesStream), write(TimesStream, Max),
  close(TimesStream), !.

querying(_TimesStream, _WM, _Step, CurrentTime, LastTime, WorstCase, WorstCase) :- 
  CurrentTime >= LastTime, !.

querying(TimesStream, WM, Step, CurrentTime, LastTime, InitWorstCase, WorstCase) :- 
  OldCurrentTime is CurrentTime-Step,
  updateManySDE(OldCurrentTime, CurrentTime, '1p_all' ), 
  Diff is CurrentTime-WM,
  write('ER: '),write(CurrentTime),write(' '),write(WM),nl,
  statistics(cputime,[S1,T1]), 
  eventRecognition(CurrentTime, WM), 
  findall((F=V,L), (outputEntity(F=V),holdsFor(F=V,L)), CC),  
  statistics(cputime,[S2,T2]), 
  T is T2-T1, S is S2-S1, %S=T2,
  writeResult(S, TimesStream),
  NewCurrentTime is CurrentTime+Step,
  querying(TimesStream, WM, Step, NewCurrentTime, LastTime, [S|InitWorstCase], WorstCase).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I/O Utils
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

writeResult(Time, Stream):-
  write(Stream,'+'), write(Stream,Time).


% 100 vehicles, 1 per cent each

:- ['../../data/100_vehicles/20000-21000/abrupt_deceleration20000-21000.prolog'].      %0
:- ['../../data/100_vehicles/20000-21000/internal_temperature_change20000-21000.prolog'].      %1
:- ['../../data/100_vehicles/20000-21000/passenger_density_change20000-21000.prolog'].      %2
:- ['../../data/100_vehicles/20000-21000/abrupt_acceleration20000-21000.prolog'].      %3
:- ['../../data/100_vehicles/20000-21000/stop_enter_leave20000-21000.prolog'].      %4
:- ['../../data/100_vehicles/20000-21000/noise_level_change20000-21000.prolog'].      %5
:- ['../../data/100_vehicles/20000-21000/sharp_turn20000-21000.prolog'].      %6
:- ['../../data/100_vehicles/26000-27000/abrupt_deceleration26000-27000.prolog'].      %7
:- ['../../data/100_vehicles/26000-27000/passenger_density_change26000-27000.prolog'].      %8
:- ['../../data/100_vehicles/26000-27000/stop_enter_leave26000-27000.prolog'].      %9
:- ['../../data/100_vehicles/26000-27000/noise_level_change26000-27000.prolog'].      %10
:- ['../../data/100_vehicles/26000-27000/sharp_turn26000-27000.prolog'].      %11
:- ['../../data/100_vehicles/26000-27000/internal_temperature_change26000-27000.prolog'].      %12
:- ['../../data/100_vehicles/26000-27000/abrupt_acceleration26000-27000.prolog'].      %13
:- ['../../data/100_vehicles/45000-46000/passenger_density_change45000-46000.prolog'].      %14
:- ['../../data/100_vehicles/45000-46000/noise_level_change45000-46000.prolog'].      %15
:- ['../../data/100_vehicles/45000-46000/internal_temperature_change45000-46000.prolog'].      %16
:- ['../../data/100_vehicles/45000-46000/stop_enter_leave45000-46000.prolog'].      %17
:- ['../../data/100_vehicles/45000-46000/sharp_turn45000-46000.prolog'].      %18
:- ['../../data/100_vehicles/45000-46000/abrupt_deceleration45000-46000.prolog'].      %19
:- ['../../data/100_vehicles/45000-46000/abrupt_acceleration45000-46000.prolog'].      %20
:- ['../../data/100_vehicles/36000-37000/abrupt_deceleration36000-37000.prolog'].      %21
:- ['../../data/100_vehicles/36000-37000/internal_temperature_change36000-37000.prolog'].      %22
:- ['../../data/100_vehicles/36000-37000/sharp_turn36000-37000.prolog'].      %23
:- ['../../data/100_vehicles/36000-37000/passenger_density_change36000-37000.prolog'].      %24
:- ['../../data/100_vehicles/36000-37000/abrupt_acceleration36000-37000.prolog'].      %25
:- ['../../data/100_vehicles/36000-37000/noise_level_change36000-37000.prolog'].      %26
:- ['../../data/100_vehicles/36000-37000/stop_enter_leave36000-37000.prolog'].      %27
:- ['../../data/100_vehicles/18000-19000/stop_enter_leave18000-19000.prolog'].      %28
:- ['../../data/100_vehicles/18000-19000/noise_level_change18000-19000.prolog'].      %29
:- ['../../data/100_vehicles/18000-19000/sharp_turn18000-19000.prolog'].      %30
:- ['../../data/100_vehicles/18000-19000/passenger_density_change18000-19000.prolog'].      %31
:- ['../../data/100_vehicles/18000-19000/internal_temperature_change18000-19000.prolog'].      %32
:- ['../../data/100_vehicles/18000-19000/abrupt_acceleration18000-19000.prolog'].      %33
:- ['../../data/100_vehicles/18000-19000/abrupt_deceleration18000-19000.prolog'].      %34
:- ['../../data/100_vehicles/10000-11000/sharp_turn10000-11000.prolog'].      %35
:- ['../../data/100_vehicles/10000-11000/abrupt_acceleration10000-11000.prolog'].      %36
:- ['../../data/100_vehicles/10000-11000/abrupt_deceleration10000-11000.prolog'].      %37
:- ['../../data/100_vehicles/10000-11000/passenger_density_change10000-11000.prolog'].      %38
:- ['../../data/100_vehicles/10000-11000/internal_temperature_change10000-11000.prolog'].      %39
:- ['../../data/100_vehicles/10000-11000/stop_enter_leave10000-11000.prolog'].      %40
:- ['../../data/100_vehicles/10000-11000/noise_level_change10000-11000.prolog'].      %41
:- ['../../data/100_vehicles/0-1000/abrupt_deceleration0-1000.prolog'].      %42
:- ['../../data/100_vehicles/0-1000/stop_enter_leave0-1000.prolog'].      %43
:- ['../../data/100_vehicles/0-1000/internal_temperature_change0-1000.prolog'].      %44
:- ['../../data/100_vehicles/0-1000/sharp_turn0-1000.prolog'].      %45
:- ['../../data/100_vehicles/0-1000/noise_level_change0-1000.prolog'].      %46
:- ['../../data/100_vehicles/0-1000/abrupt_acceleration0-1000.prolog'].      %47
:- ['../../data/100_vehicles/0-1000/passenger_density_change0-1000.prolog'].      %48
:- ['../../data/100_vehicles/34000-35000/stop_enter_leave34000-35000.prolog'].      %49
:- ['../../data/100_vehicles/34000-35000/sharp_turn34000-35000.prolog'].      %50
:- ['../../data/100_vehicles/34000-35000/noise_level_change34000-35000.prolog'].      %51
:- ['../../data/100_vehicles/34000-35000/internal_temperature_change34000-35000.prolog'].      %52
:- ['../../data/100_vehicles/34000-35000/passenger_density_change34000-35000.prolog'].      %53
:- ['../../data/100_vehicles/34000-35000/abrupt_deceleration34000-35000.prolog'].      %54
:- ['../../data/100_vehicles/34000-35000/abrupt_acceleration34000-35000.prolog'].      %55
:- ['../../data/100_vehicles/11000-12000/sharp_turn11000-12000.prolog'].      %56
:- ['../../data/100_vehicles/11000-12000/passenger_density_change11000-12000.prolog'].      %57
:- ['../../data/100_vehicles/11000-12000/abrupt_acceleration11000-12000.prolog'].      %58
:- ['../../data/100_vehicles/11000-12000/noise_level_change11000-12000.prolog'].      %59
:- ['../../data/100_vehicles/11000-12000/abrupt_deceleration11000-12000.prolog'].      %60
:- ['../../data/100_vehicles/11000-12000/internal_temperature_change11000-12000.prolog'].      %61
:- ['../../data/100_vehicles/11000-12000/stop_enter_leave11000-12000.prolog'].      %62
:- ['../../data/100_vehicles/7000-8000/stop_enter_leave7000-8000.prolog'].      %63
:- ['../../data/100_vehicles/7000-8000/internal_temperature_change7000-8000.prolog'].      %64
:- ['../../data/100_vehicles/7000-8000/passenger_density_change7000-8000.prolog'].      %65
:- ['../../data/100_vehicles/7000-8000/sharp_turn7000-8000.prolog'].      %66
:- ['../../data/100_vehicles/7000-8000/abrupt_deceleration7000-8000.prolog'].      %67
:- ['../../data/100_vehicles/7000-8000/abrupt_acceleration7000-8000.prolog'].      %68
:- ['../../data/100_vehicles/7000-8000/noise_level_change7000-8000.prolog'].      %69
:- ['../../data/100_vehicles/6000-7000/passenger_density_change6000-7000.prolog'].      %70
:- ['../../data/100_vehicles/6000-7000/abrupt_deceleration6000-7000.prolog'].      %71
:- ['../../data/100_vehicles/6000-7000/abrupt_acceleration6000-7000.prolog'].      %72
:- ['../../data/100_vehicles/6000-7000/internal_temperature_change6000-7000.prolog'].      %73
:- ['../../data/100_vehicles/6000-7000/noise_level_change6000-7000.prolog'].      %74
:- ['../../data/100_vehicles/6000-7000/sharp_turn6000-7000.prolog'].      %75
:- ['../../data/100_vehicles/6000-7000/stop_enter_leave6000-7000.prolog'].      %76
:- ['../../data/100_vehicles/47000-48000/abrupt_acceleration47000-48000.prolog'].      %77
:- ['../../data/100_vehicles/47000-48000/internal_temperature_change47000-48000.prolog'].      %78
:- ['../../data/100_vehicles/47000-48000/sharp_turn47000-48000.prolog'].      %79
:- ['../../data/100_vehicles/47000-48000/abrupt_deceleration47000-48000.prolog'].      %80
:- ['../../data/100_vehicles/47000-48000/passenger_density_change47000-48000.prolog'].      %81
:- ['../../data/100_vehicles/47000-48000/noise_level_change47000-48000.prolog'].      %82
:- ['../../data/100_vehicles/47000-48000/stop_enter_leave47000-48000.prolog'].      %83
:- ['../../data/100_vehicles/9000-10000/noise_level_change9000-10000.prolog'].      %84
:- ['../../data/100_vehicles/9000-10000/internal_temperature_change9000-10000.prolog'].      %85
:- ['../../data/100_vehicles/9000-10000/sharp_turn9000-10000.prolog'].      %86
:- ['../../data/100_vehicles/9000-10000/stop_enter_leave9000-10000.prolog'].      %87
:- ['../../data/100_vehicles/9000-10000/abrupt_acceleration9000-10000.prolog'].      %88
:- ['../../data/100_vehicles/9000-10000/passenger_density_change9000-10000.prolog'].      %89
:- ['../../data/100_vehicles/9000-10000/abrupt_deceleration9000-10000.prolog'].      %90
:- ['../../data/100_vehicles/24000-25000/sharp_turn24000-25000.prolog'].      %91
:- ['../../data/100_vehicles/24000-25000/abrupt_acceleration24000-25000.prolog'].      %92
:- ['../../data/100_vehicles/24000-25000/stop_enter_leave24000-25000.prolog'].      %93
:- ['../../data/100_vehicles/24000-25000/passenger_density_change24000-25000.prolog'].      %94
:- ['../../data/100_vehicles/24000-25000/abrupt_deceleration24000-25000.prolog'].      %95
:- ['../../data/100_vehicles/24000-25000/noise_level_change24000-25000.prolog'].      %96
:- ['../../data/100_vehicles/24000-25000/internal_temperature_change24000-25000.prolog'].      %97
:- ['../../data/100_vehicles/42000-43000/sharp_turn42000-43000.prolog'].      %98
:- ['../../data/100_vehicles/42000-43000/internal_temperature_change42000-43000.prolog'].      %99
:- ['../../data/100_vehicles/42000-43000/stop_enter_leave42000-43000.prolog'].      %100
:- ['../../data/100_vehicles/42000-43000/abrupt_deceleration42000-43000.prolog'].      %101
:- ['../../data/100_vehicles/42000-43000/passenger_density_change42000-43000.prolog'].      %102
:- ['../../data/100_vehicles/42000-43000/noise_level_change42000-43000.prolog'].      %103
:- ['../../data/100_vehicles/42000-43000/abrupt_acceleration42000-43000.prolog'].      %104
:- ['../../data/100_vehicles/37000-38000/noise_level_change37000-38000.prolog'].      %105
:- ['../../data/100_vehicles/37000-38000/passenger_density_change37000-38000.prolog'].      %106
:- ['../../data/100_vehicles/37000-38000/abrupt_deceleration37000-38000.prolog'].      %107
:- ['../../data/100_vehicles/37000-38000/sharp_turn37000-38000.prolog'].      %108
:- ['../../data/100_vehicles/37000-38000/internal_temperature_change37000-38000.prolog'].      %109
:- ['../../data/100_vehicles/37000-38000/stop_enter_leave37000-38000.prolog'].      %110
:- ['../../data/100_vehicles/37000-38000/abrupt_acceleration37000-38000.prolog'].      %111
:- ['../../data/100_vehicles/14000-15000/internal_temperature_change14000-15000.prolog'].      %112
:- ['../../data/100_vehicles/14000-15000/noise_level_change14000-15000.prolog'].      %113
:- ['../../data/100_vehicles/14000-15000/abrupt_acceleration14000-15000.prolog'].      %114
:- ['../../data/100_vehicles/14000-15000/stop_enter_leave14000-15000.prolog'].      %115
:- ['../../data/100_vehicles/14000-15000/passenger_density_change14000-15000.prolog'].      %116
:- ['../../data/100_vehicles/14000-15000/sharp_turn14000-15000.prolog'].      %117
:- ['../../data/100_vehicles/14000-15000/abrupt_deceleration14000-15000.prolog'].      %118
:- ['../../data/100_vehicles/32000-33000/stop_enter_leave32000-33000.prolog'].      %119
:- ['../../data/100_vehicles/32000-33000/abrupt_acceleration32000-33000.prolog'].      %120
:- ['../../data/100_vehicles/32000-33000/noise_level_change32000-33000.prolog'].      %121
:- ['../../data/100_vehicles/32000-33000/abrupt_deceleration32000-33000.prolog'].      %122
:- ['../../data/100_vehicles/32000-33000/internal_temperature_change32000-33000.prolog'].      %123
:- ['../../data/100_vehicles/32000-33000/passenger_density_change32000-33000.prolog'].      %124
:- ['../../data/100_vehicles/32000-33000/sharp_turn32000-33000.prolog'].      %125
:- ['../../data/100_vehicles/8000-9000/internal_temperature_change8000-9000.prolog'].      %126
:- ['../../data/100_vehicles/8000-9000/stop_enter_leave8000-9000.prolog'].      %127
:- ['../../data/100_vehicles/8000-9000/passenger_density_change8000-9000.prolog'].      %128
:- ['../../data/100_vehicles/8000-9000/sharp_turn8000-9000.prolog'].      %129
:- ['../../data/100_vehicles/8000-9000/abrupt_deceleration8000-9000.prolog'].      %130
:- ['../../data/100_vehicles/8000-9000/noise_level_change8000-9000.prolog'].      %131
:- ['../../data/100_vehicles/8000-9000/abrupt_acceleration8000-9000.prolog'].      %132
:- ['../../data/100_vehicles/17000-18000/noise_level_change17000-18000.prolog'].      %133
:- ['../../data/100_vehicles/17000-18000/abrupt_acceleration17000-18000.prolog'].      %134
:- ['../../data/100_vehicles/17000-18000/stop_enter_leave17000-18000.prolog'].      %135
:- ['../../data/100_vehicles/17000-18000/abrupt_deceleration17000-18000.prolog'].      %136
:- ['../../data/100_vehicles/17000-18000/passenger_density_change17000-18000.prolog'].      %137
:- ['../../data/100_vehicles/17000-18000/internal_temperature_change17000-18000.prolog'].      %138
:- ['../../data/100_vehicles/17000-18000/sharp_turn17000-18000.prolog'].      %139
:- ['../../data/100_vehicles/43000-44000/stop_enter_leave43000-44000.prolog'].      %140
:- ['../../data/100_vehicles/43000-44000/abrupt_acceleration43000-44000.prolog'].      %141
:- ['../../data/100_vehicles/43000-44000/noise_level_change43000-44000.prolog'].      %142
:- ['../../data/100_vehicles/43000-44000/passenger_density_change43000-44000.prolog'].      %143
:- ['../../data/100_vehicles/43000-44000/abrupt_deceleration43000-44000.prolog'].      %144
:- ['../../data/100_vehicles/43000-44000/sharp_turn43000-44000.prolog'].      %145
:- ['../../data/100_vehicles/43000-44000/internal_temperature_change43000-44000.prolog'].      %146
:- ['../../data/100_vehicles/44000-45000/noise_level_change44000-45000.prolog'].      %147
:- ['../../data/100_vehicles/44000-45000/stop_enter_leave44000-45000.prolog'].      %148
:- ['../../data/100_vehicles/44000-45000/internal_temperature_change44000-45000.prolog'].      %149
:- ['../../data/100_vehicles/44000-45000/abrupt_deceleration44000-45000.prolog'].      %150
:- ['../../data/100_vehicles/44000-45000/abrupt_acceleration44000-45000.prolog'].      %151
:- ['../../data/100_vehicles/44000-45000/sharp_turn44000-45000.prolog'].      %152
:- ['../../data/100_vehicles/44000-45000/passenger_density_change44000-45000.prolog'].      %153
:- ['../../data/100_vehicles/2000-3000/sharp_turn2000-3000.prolog'].      %154
:- ['../../data/100_vehicles/2000-3000/abrupt_acceleration2000-3000.prolog'].      %155
:- ['../../data/100_vehicles/2000-3000/passenger_density_change2000-3000.prolog'].      %156
:- ['../../data/100_vehicles/2000-3000/abrupt_deceleration2000-3000.prolog'].      %157
:- ['../../data/100_vehicles/2000-3000/internal_temperature_change2000-3000.prolog'].      %158
:- ['../../data/100_vehicles/2000-3000/stop_enter_leave2000-3000.prolog'].      %159
:- ['../../data/100_vehicles/2000-3000/noise_level_change2000-3000.prolog'].      %160
:- ['../../data/100_vehicles/4000-5000/abrupt_acceleration4000-5000.prolog'].      %161
:- ['../../data/100_vehicles/4000-5000/passenger_density_change4000-5000.prolog'].      %162
:- ['../../data/100_vehicles/4000-5000/internal_temperature_change4000-5000.prolog'].      %163
:- ['../../data/100_vehicles/4000-5000/stop_enter_leave4000-5000.prolog'].      %164
:- ['../../data/100_vehicles/4000-5000/sharp_turn4000-5000.prolog'].      %165
:- ['../../data/100_vehicles/4000-5000/abrupt_deceleration4000-5000.prolog'].      %166
:- ['../../data/100_vehicles/4000-5000/noise_level_change4000-5000.prolog'].      %167
:- ['../../data/100_vehicles/19000-20000/sharp_turn19000-20000.prolog'].      %168
:- ['../../data/100_vehicles/19000-20000/passenger_density_change19000-20000.prolog'].      %169
:- ['../../data/100_vehicles/19000-20000/abrupt_deceleration19000-20000.prolog'].      %170
:- ['../../data/100_vehicles/19000-20000/noise_level_change19000-20000.prolog'].      %171
:- ['../../data/100_vehicles/19000-20000/internal_temperature_change19000-20000.prolog'].      %172
:- ['../../data/100_vehicles/19000-20000/abrupt_acceleration19000-20000.prolog'].      %173
:- ['../../data/100_vehicles/19000-20000/stop_enter_leave19000-20000.prolog'].      %174
:- ['../../data/100_vehicles/13000-14000/stop_enter_leave13000-14000.prolog'].      %175
:- ['../../data/100_vehicles/13000-14000/abrupt_acceleration13000-14000.prolog'].      %176
:- ['../../data/100_vehicles/13000-14000/internal_temperature_change13000-14000.prolog'].      %177
:- ['../../data/100_vehicles/13000-14000/noise_level_change13000-14000.prolog'].      %178
:- ['../../data/100_vehicles/13000-14000/abrupt_deceleration13000-14000.prolog'].      %179
:- ['../../data/100_vehicles/13000-14000/sharp_turn13000-14000.prolog'].      %180
:- ['../../data/100_vehicles/13000-14000/passenger_density_change13000-14000.prolog'].      %181
:- ['../../data/100_vehicles/33000-34000/passenger_density_change33000-34000.prolog'].      %182
:- ['../../data/100_vehicles/33000-34000/internal_temperature_change33000-34000.prolog'].      %183
:- ['../../data/100_vehicles/33000-34000/abrupt_deceleration33000-34000.prolog'].      %184
:- ['../../data/100_vehicles/33000-34000/noise_level_change33000-34000.prolog'].      %185
:- ['../../data/100_vehicles/33000-34000/stop_enter_leave33000-34000.prolog'].      %186
:- ['../../data/100_vehicles/33000-34000/sharp_turn33000-34000.prolog'].      %187
:- ['../../data/100_vehicles/33000-34000/abrupt_acceleration33000-34000.prolog'].      %188
:- ['../../data/100_vehicles/49000-50000/abrupt_acceleration49000-50000.prolog'].      %189
:- ['../../data/100_vehicles/49000-50000/sharp_turn49000-50000.prolog'].      %190
:- ['../../data/100_vehicles/49000-50000/noise_level_change49000-50000.prolog'].      %191
:- ['../../data/100_vehicles/49000-50000/abrupt_deceleration49000-50000.prolog'].      %192
:- ['../../data/100_vehicles/49000-50000/stop_enter_leave49000-50000.prolog'].      %193
:- ['../../data/100_vehicles/49000-50000/internal_temperature_change49000-50000.prolog'].      %194
:- ['../../data/100_vehicles/49000-50000/passenger_density_change49000-50000.prolog'].      %195
:- ['../../data/100_vehicles/30000-31000/noise_level_change30000-31000.prolog'].      %196
:- ['../../data/100_vehicles/30000-31000/abrupt_deceleration30000-31000.prolog'].      %197
:- ['../../data/100_vehicles/30000-31000/sharp_turn30000-31000.prolog'].      %198
:- ['../../data/100_vehicles/30000-31000/stop_enter_leave30000-31000.prolog'].      %199
:- ['../../data/100_vehicles/30000-31000/internal_temperature_change30000-31000.prolog'].      %200
:- ['../../data/100_vehicles/30000-31000/passenger_density_change30000-31000.prolog'].      %201
:- ['../../data/100_vehicles/30000-31000/abrupt_acceleration30000-31000.prolog'].      %202
:- ['../../data/100_vehicles/28000-29000/stop_enter_leave28000-29000.prolog'].      %203
:- ['../../data/100_vehicles/28000-29000/noise_level_change28000-29000.prolog'].      %204
:- ['../../data/100_vehicles/28000-29000/passenger_density_change28000-29000.prolog'].      %205
:- ['../../data/100_vehicles/28000-29000/abrupt_acceleration28000-29000.prolog'].      %206
:- ['../../data/100_vehicles/28000-29000/internal_temperature_change28000-29000.prolog'].      %207
:- ['../../data/100_vehicles/28000-29000/sharp_turn28000-29000.prolog'].      %208
:- ['../../data/100_vehicles/28000-29000/abrupt_deceleration28000-29000.prolog'].      %209
:- ['../../data/100_vehicles/5000-6000/internal_temperature_change5000-6000.prolog'].      %210
:- ['../../data/100_vehicles/5000-6000/abrupt_acceleration5000-6000.prolog'].      %211
:- ['../../data/100_vehicles/5000-6000/noise_level_change5000-6000.prolog'].      %212
:- ['../../data/100_vehicles/5000-6000/abrupt_deceleration5000-6000.prolog'].      %213
:- ['../../data/100_vehicles/5000-6000/passenger_density_change5000-6000.prolog'].      %214
:- ['../../data/100_vehicles/5000-6000/stop_enter_leave5000-6000.prolog'].      %215
:- ['../../data/100_vehicles/5000-6000/sharp_turn5000-6000.prolog'].      %216
:- ['../../data/100_vehicles/35000-36000/noise_level_change35000-36000.prolog'].      %217
:- ['../../data/100_vehicles/35000-36000/abrupt_deceleration35000-36000.prolog'].      %218
:- ['../../data/100_vehicles/35000-36000/abrupt_acceleration35000-36000.prolog'].      %219
:- ['../../data/100_vehicles/35000-36000/internal_temperature_change35000-36000.prolog'].      %220
:- ['../../data/100_vehicles/35000-36000/passenger_density_change35000-36000.prolog'].      %221
:- ['../../data/100_vehicles/35000-36000/stop_enter_leave35000-36000.prolog'].      %222
:- ['../../data/100_vehicles/35000-36000/sharp_turn35000-36000.prolog'].      %223
:- ['../../data/100_vehicles/38000-39000/passenger_density_change38000-39000.prolog'].      %224
:- ['../../data/100_vehicles/38000-39000/sharp_turn38000-39000.prolog'].      %225
:- ['../../data/100_vehicles/38000-39000/abrupt_acceleration38000-39000.prolog'].      %226
:- ['../../data/100_vehicles/38000-39000/abrupt_deceleration38000-39000.prolog'].      %227
:- ['../../data/100_vehicles/38000-39000/internal_temperature_change38000-39000.prolog'].      %228
:- ['../../data/100_vehicles/38000-39000/stop_enter_leave38000-39000.prolog'].      %229
:- ['../../data/100_vehicles/38000-39000/noise_level_change38000-39000.prolog'].      %230
:- ['../../data/100_vehicles/22000-23000/passenger_density_change22000-23000.prolog'].      %231
:- ['../../data/100_vehicles/22000-23000/abrupt_acceleration22000-23000.prolog'].      %232
:- ['../../data/100_vehicles/22000-23000/stop_enter_leave22000-23000.prolog'].      %233
:- ['../../data/100_vehicles/22000-23000/sharp_turn22000-23000.prolog'].      %234
:- ['../../data/100_vehicles/22000-23000/noise_level_change22000-23000.prolog'].      %235
:- ['../../data/100_vehicles/22000-23000/abrupt_deceleration22000-23000.prolog'].      %236
:- ['../../data/100_vehicles/22000-23000/internal_temperature_change22000-23000.prolog'].      %237
:- ['../../data/100_vehicles/31000-32000/stop_enter_leave31000-32000.prolog'].      %238
:- ['../../data/100_vehicles/31000-32000/abrupt_acceleration31000-32000.prolog'].      %239
:- ['../../data/100_vehicles/31000-32000/passenger_density_change31000-32000.prolog'].      %240
:- ['../../data/100_vehicles/31000-32000/sharp_turn31000-32000.prolog'].      %241
:- ['../../data/100_vehicles/31000-32000/noise_level_change31000-32000.prolog'].      %242
:- ['../../data/100_vehicles/31000-32000/internal_temperature_change31000-32000.prolog'].      %243
:- ['../../data/100_vehicles/31000-32000/abrupt_deceleration31000-32000.prolog'].      %244
:- ['../../data/100_vehicles/39000-40000/internal_temperature_change39000-40000.prolog'].      %245
:- ['../../data/100_vehicles/39000-40000/stop_enter_leave39000-40000.prolog'].      %246
:- ['../../data/100_vehicles/39000-40000/abrupt_acceleration39000-40000.prolog'].      %247
:- ['../../data/100_vehicles/39000-40000/sharp_turn39000-40000.prolog'].      %248
:- ['../../data/100_vehicles/39000-40000/noise_level_change39000-40000.prolog'].      %249
:- ['../../data/100_vehicles/39000-40000/passenger_density_change39000-40000.prolog'].      %250
:- ['../../data/100_vehicles/39000-40000/abrupt_deceleration39000-40000.prolog'].      %251
:- ['../../data/100_vehicles/48000-49000/stop_enter_leave48000-49000.prolog'].      %252
:- ['../../data/100_vehicles/48000-49000/passenger_density_change48000-49000.prolog'].      %253
:- ['../../data/100_vehicles/48000-49000/internal_temperature_change48000-49000.prolog'].      %254
:- ['../../data/100_vehicles/48000-49000/abrupt_acceleration48000-49000.prolog'].      %255
:- ['../../data/100_vehicles/48000-49000/sharp_turn48000-49000.prolog'].      %256
:- ['../../data/100_vehicles/48000-49000/noise_level_change48000-49000.prolog'].      %257
:- ['../../data/100_vehicles/48000-49000/abrupt_deceleration48000-49000.prolog'].      %258
:- ['../../data/100_vehicles/15000-16000/noise_level_change15000-16000.prolog'].      %259
:- ['../../data/100_vehicles/15000-16000/sharp_turn15000-16000.prolog'].      %260
:- ['../../data/100_vehicles/15000-16000/abrupt_deceleration15000-16000.prolog'].      %261
:- ['../../data/100_vehicles/15000-16000/passenger_density_change15000-16000.prolog'].      %262
:- ['../../data/100_vehicles/15000-16000/stop_enter_leave15000-16000.prolog'].      %263
:- ['../../data/100_vehicles/15000-16000/abrupt_acceleration15000-16000.prolog'].      %264
:- ['../../data/100_vehicles/15000-16000/internal_temperature_change15000-16000.prolog'].      %265
:- ['../../data/100_vehicles/46000-47000/stop_enter_leave46000-47000.prolog'].      %266
:- ['../../data/100_vehicles/46000-47000/passenger_density_change46000-47000.prolog'].      %267
:- ['../../data/100_vehicles/46000-47000/noise_level_change46000-47000.prolog'].      %268
:- ['../../data/100_vehicles/46000-47000/abrupt_deceleration46000-47000.prolog'].      %269
:- ['../../data/100_vehicles/46000-47000/internal_temperature_change46000-47000.prolog'].      %270
:- ['../../data/100_vehicles/46000-47000/abrupt_acceleration46000-47000.prolog'].      %271
:- ['../../data/100_vehicles/46000-47000/sharp_turn46000-47000.prolog'].      %272
:- ['../../data/100_vehicles/1000-2000/stop_enter_leave1000-2000.prolog'].      %273
:- ['../../data/100_vehicles/1000-2000/passenger_density_change1000-2000.prolog'].      %274
:- ['../../data/100_vehicles/1000-2000/abrupt_acceleration1000-2000.prolog'].      %275
:- ['../../data/100_vehicles/1000-2000/noise_level_change1000-2000.prolog'].      %276
:- ['../../data/100_vehicles/1000-2000/sharp_turn1000-2000.prolog'].      %277
:- ['../../data/100_vehicles/1000-2000/abrupt_deceleration1000-2000.prolog'].      %278
:- ['../../data/100_vehicles/1000-2000/internal_temperature_change1000-2000.prolog'].      %279
:- ['../../data/100_vehicles/25000-26000/internal_temperature_change25000-26000.prolog'].      %280
:- ['../../data/100_vehicles/25000-26000/sharp_turn25000-26000.prolog'].      %281
:- ['../../data/100_vehicles/25000-26000/noise_level_change25000-26000.prolog'].      %282
:- ['../../data/100_vehicles/25000-26000/abrupt_deceleration25000-26000.prolog'].      %283
:- ['../../data/100_vehicles/25000-26000/stop_enter_leave25000-26000.prolog'].      %284
:- ['../../data/100_vehicles/25000-26000/abrupt_acceleration25000-26000.prolog'].      %285
:- ['../../data/100_vehicles/25000-26000/passenger_density_change25000-26000.prolog'].      %286
:- ['../../data/100_vehicles/40000-41000/stop_enter_leave40000-41000.prolog'].      %287
:- ['../../data/100_vehicles/40000-41000/internal_temperature_change40000-41000.prolog'].      %288
:- ['../../data/100_vehicles/40000-41000/sharp_turn40000-41000.prolog'].      %289
:- ['../../data/100_vehicles/40000-41000/noise_level_change40000-41000.prolog'].      %290
:- ['../../data/100_vehicles/40000-41000/abrupt_acceleration40000-41000.prolog'].      %291
:- ['../../data/100_vehicles/40000-41000/passenger_density_change40000-41000.prolog'].      %292
:- ['../../data/100_vehicles/40000-41000/abrupt_deceleration40000-41000.prolog'].      %293
:- ['../../data/100_vehicles/21000-22000/abrupt_deceleration21000-22000.prolog'].      %294
:- ['../../data/100_vehicles/21000-22000/passenger_density_change21000-22000.prolog'].      %295
:- ['../../data/100_vehicles/21000-22000/sharp_turn21000-22000.prolog'].      %296
:- ['../../data/100_vehicles/21000-22000/abrupt_acceleration21000-22000.prolog'].      %297
:- ['../../data/100_vehicles/21000-22000/noise_level_change21000-22000.prolog'].      %298
:- ['../../data/100_vehicles/21000-22000/internal_temperature_change21000-22000.prolog'].      %299
:- ['../../data/100_vehicles/21000-22000/stop_enter_leave21000-22000.prolog'].      %300
:- ['../../data/100_vehicles/41000-42000/noise_level_change41000-42000.prolog'].      %301
:- ['../../data/100_vehicles/41000-42000/abrupt_acceleration41000-42000.prolog'].      %302
:- ['../../data/100_vehicles/41000-42000/passenger_density_change41000-42000.prolog'].      %303
:- ['../../data/100_vehicles/41000-42000/abrupt_deceleration41000-42000.prolog'].      %304
:- ['../../data/100_vehicles/41000-42000/internal_temperature_change41000-42000.prolog'].      %305
:- ['../../data/100_vehicles/41000-42000/stop_enter_leave41000-42000.prolog'].      %306
:- ['../../data/100_vehicles/41000-42000/sharp_turn41000-42000.prolog'].      %307
:- ['../../data/100_vehicles/23000-24000/noise_level_change23000-24000.prolog'].      %308
:- ['../../data/100_vehicles/23000-24000/passenger_density_change23000-24000.prolog'].      %309
:- ['../../data/100_vehicles/23000-24000/stop_enter_leave23000-24000.prolog'].      %310
:- ['../../data/100_vehicles/23000-24000/sharp_turn23000-24000.prolog'].      %311
:- ['../../data/100_vehicles/23000-24000/abrupt_deceleration23000-24000.prolog'].      %312
:- ['../../data/100_vehicles/23000-24000/abrupt_acceleration23000-24000.prolog'].      %313
:- ['../../data/100_vehicles/23000-24000/internal_temperature_change23000-24000.prolog'].      %314
:- ['../../data/100_vehicles/16000-17000/sharp_turn16000-17000.prolog'].      %315
:- ['../../data/100_vehicles/16000-17000/abrupt_deceleration16000-17000.prolog'].      %316
:- ['../../data/100_vehicles/16000-17000/internal_temperature_change16000-17000.prolog'].      %317
:- ['../../data/100_vehicles/16000-17000/passenger_density_change16000-17000.prolog'].      %318
:- ['../../data/100_vehicles/16000-17000/abrupt_acceleration16000-17000.prolog'].      %319
:- ['../../data/100_vehicles/16000-17000/stop_enter_leave16000-17000.prolog'].      %320
:- ['../../data/100_vehicles/16000-17000/noise_level_change16000-17000.prolog'].      %321
:- ['../../data/100_vehicles/29000-30000/passenger_density_change29000-30000.prolog'].      %322
:- ['../../data/100_vehicles/29000-30000/internal_temperature_change29000-30000.prolog'].      %323
:- ['../../data/100_vehicles/29000-30000/noise_level_change29000-30000.prolog'].      %324
:- ['../../data/100_vehicles/29000-30000/abrupt_deceleration29000-30000.prolog'].      %325
:- ['../../data/100_vehicles/29000-30000/abrupt_acceleration29000-30000.prolog'].      %326
:- ['../../data/100_vehicles/29000-30000/stop_enter_leave29000-30000.prolog'].      %327
:- ['../../data/100_vehicles/29000-30000/sharp_turn29000-30000.prolog'].      %328
:- ['../../data/100_vehicles/12000-13000/stop_enter_leave12000-13000.prolog'].      %329
:- ['../../data/100_vehicles/12000-13000/sharp_turn12000-13000.prolog'].      %330
:- ['../../data/100_vehicles/12000-13000/internal_temperature_change12000-13000.prolog'].      %331
:- ['../../data/100_vehicles/12000-13000/noise_level_change12000-13000.prolog'].      %332
:- ['../../data/100_vehicles/12000-13000/abrupt_acceleration12000-13000.prolog'].      %333
:- ['../../data/100_vehicles/12000-13000/abrupt_deceleration12000-13000.prolog'].      %334
:- ['../../data/100_vehicles/12000-13000/passenger_density_change12000-13000.prolog'].      %335
:- ['../../data/100_vehicles/27000-28000/passenger_density_change27000-28000.prolog'].      %336
:- ['../../data/100_vehicles/27000-28000/abrupt_deceleration27000-28000.prolog'].      %337
:- ['../../data/100_vehicles/27000-28000/internal_temperature_change27000-28000.prolog'].      %338
:- ['../../data/100_vehicles/27000-28000/stop_enter_leave27000-28000.prolog'].      %339
:- ['../../data/100_vehicles/27000-28000/noise_level_change27000-28000.prolog'].      %340
:- ['../../data/100_vehicles/27000-28000/sharp_turn27000-28000.prolog'].      %341
:- ['../../data/100_vehicles/27000-28000/abrupt_acceleration27000-28000.prolog'].      %342
:- ['../../data/100_vehicles/3000-4000/internal_temperature_change3000-4000.prolog'].      %343
:- ['../../data/100_vehicles/3000-4000/stop_enter_leave3000-4000.prolog'].      %344
:- ['../../data/100_vehicles/3000-4000/abrupt_acceleration3000-4000.prolog'].      %345
:- ['../../data/100_vehicles/3000-4000/abrupt_deceleration3000-4000.prolog'].      %346
:- ['../../data/100_vehicles/3000-4000/sharp_turn3000-4000.prolog'].      %347
:- ['../../data/100_vehicles/3000-4000/noise_level_change3000-4000.prolog'].      %348
:- ['../../data/100_vehicles/3000-4000/passenger_density_change3000-4000.prolog'].      %349
:- ['../../data/100_vehicles/vehicles.prolog'].

updateSDE( Start, End, Id ) :-
	updateSDE( abrupt_acceleration, Id, Start, End ),
	updateSDE( abrupt_deceleration, Id, Start, End ),
	updateSDE( sharp_turn, Id, Start, End ),
	updateSDE( internal_temperature_change, Id, Start, End ),
	updateSDE( noise_level_change, Id, Start, End ),
	updateSDE( passenger_density_change, Id, Start, End ),
	updateSDE( stop_enter_leave, Id, Start, End ).

updateManySDE( Start, End, Id ) :-
	Diff is End-Start,
	Diff =< 1000,
	!,
	updateSDE( Start, End, Id ).	

updateManySDE( Start, End, Id ) :-
	Diff is End-Start,
	Diff > 1000,
	NewStart is Start + 1000,
	updateSDE( Start, NewStart, Id ),
	updateManySDE( NewStart, End, Id ).





  

