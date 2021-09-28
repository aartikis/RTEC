from setuptools import setup #, find_packages

setup(
	name='RTEC',
	version='1.0',
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
     data_files=[('bin/RTEC-files/src', ['src/RTEC.prolog']),
                  ('bin/RTEC-files/src', ['src/compiler.prolog']),
                  ('bin/RTEC-files/src', ['src/inputModule.prolog']),
                  ('bin/RTEC-files/src', ['src/processEvents.prolog']),
                  ('bin/RTEC-files/src', ['src/processSDFluents.prolog']),
                  ('bin/RTEC-files/src', ['src/processSimpleFluents.prolog']),
                 ('bin/RTEC-files/src/utilities', ['src/utilities/amalgamate-periods.prolog']),
                 ('bin/RTEC-files/src/utilities', ['src/utilities/interval-manipulation.prolog']),
                 ('bin/RTEC-files/execution scripts', ['execution scripts/continuousQueries.prolog']),
                 ('bin/RTEC-files/execution scripts', ['execution scripts/handleApplication.prolog'])]
                 #('bin/execution scripts', ['execution scripts/RTEC_cli.py'])]
)

