from setuptools import setup #, find_packages

setup(
	name='RTEC2',
	version='1.0',
	py_modules=['RTEC2'],
	install_requires=[
		'Click',
	],
	#include_package_data=True,
	scripts=['execution scripts/RTEC2_cli.py'], #, 'execution scripts/continuousQueries.prolog', 
			#'execution scripts/handleApplication.prolog', 'src/*.prolog'],
	entry_points={
		'console_scripts':['RTEC2=RTEC2_cli:cli'],
     },
     data_files=[('bin/RTEC2-files/src', ['src/RTEC.prolog']),
     			 ('bin/RTEC2-files/src', ['src/compiler.prolog']),
     			 ('bin/RTEC2-files/src', ['src/inputModule.prolog']),
     			 ('bin/RTEC2-files/src', ['src/processEvents.prolog']),
     			 ('bin/RTEC2-files/src', ['src/processSDFluents.prolog']),
     			 ('bin/RTEC2-files/src', ['src/processSimpleFluents.prolog']),
     			 ('bin/RTEC2-files/src', ['src/timeoutTreatment.prolog']),
     			 ('bin/RTEC2-files/src/data loader', ['src/data loader/dataLoader.prolog']),
     			 ('bin/RTEC2-files/src/data loader', ['src/data loader/manualCSVReader.prolog']),
     			 ('bin/RTEC2-files/src/dynamic grounding', ['src/dynamic grounding/dynamicGrounding.prolog']), 
                 ('bin/RTEC2-files/src/utilities', ['src/utilities/amalgamate-periods.prolog']),
                 ('bin/RTEC2-files/src/utilities', ['src/utilities/interval-manipulation.prolog']),
                 ('bin/RTEC2-files/execution scripts', ['execution scripts/continuousQueries.prolog']),
                 ('bin/RTEC2-files/execution scripts', ['execution scripts/handleApplication.prolog'])]
     #packages=['execution scripts', 'src'],
     #package_dir={'execution scripts': 'execution scripts', 'src': 'src'},
     #package_data={'execution scripts': ['execution scripts/*.prolog'], 'src': ['src/*.prolog']}
     #  package_data={
        # If any package contains *.txt files, include them:
     #   "": ["execution scripts/*.prolog"],
        # And include any *.dat files found in the "data" subdirectory
        # of the "mypkg" package, also:
        #"mypkg": ["data/*.dat"],
    #}
)

