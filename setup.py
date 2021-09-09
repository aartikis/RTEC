from setuptools import setup #, find_packages

setup(
	name='RTEC',
	version='2.0',
	py_modules=['RTEC'],
	install_requires=[
		'Click',
	],
	#include_package_data=True,
	scripts=['execution scripts/RTEC_cli.py'], #, 'execution scripts/continuousQueries.prolog', 
			#'execution scripts/handleApplication.prolog', 'src/*.prolog'],
	entry_points={
		'console_scripts':['RTEC=RTEC_cli:cli'],
     },
     data_files=[('bin/src', ['src/RTEC.prolog']),
     			 ('bin/src', ['src/compiler.prolog']),
     			 ('bin/src', ['src/inputModule.prolog']),
     			 ('bin/src', ['src/processEvents.prolog']),
     			 ('bin/src', ['src/processSDFluents.prolog']),
     			 ('bin/src', ['src/processSimpleFluents.prolog']),
     			 ('bin/src', ['src/timeoutTreatment.prolog']),
     			 ('bin/src/data loader', ['src/data loader/dataLoader.prolog']),
     			 ('bin/src/data loader', ['src/data loader/manualCSVReader.prolog']),
     			 ('bin/src/dynamic grounding', ['src/dynamic grounding/dynamicGrounding.prolog']), 
                 ('bin/src/utilities', ['src/utilities/amalgamate-periods.prolog']),
                 ('bin/src/utilities', ['src/utilities/interval-manipulation.prolog']),
                 ('bin/execution scripts', ['execution scripts/continuousQueries.prolog']),
                 ('bin/execution scripts', ['execution scripts/handleApplication.prolog'])]
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

