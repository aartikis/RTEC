from setuptools import setup #, find_packages
import os

setup(
	name='RTEC',
	version='1.0',
	py_modules=['RTEC'],
	install_requires=[
		'Click',
	],
	packages=['execution scripts', 'src'],
	include_package_data=True,
	scripts=['execution scripts/RTEC_cli.py'], #, 'execution scripts/continuousQueries.prolog', 
			#'execution scripts/handleApplication.prolog', 'src/*.prolog'],
	entry_points={
		'console_scripts':['RTEC=RTEC_cli:cli'],
     },
    #data_files=[('bin/RTEC-files/src', ['src/RTEC.prolog',
    #									'src/compiler.prolog',
    # 									'src/inputModule.prolog',
    # 									'src/processEvents.prolog',
    # 									'src/processSDFluents.prolog',
    # 									'src/processSimpleFluents.prolog']),
    #             ('bin/RTEC-files/src/utilities', ['src/utilities/amalgamate-periods.prolog',
    #             									'src/utilities/interval-manipulation.prolog']),
    #             ('bin/RTEC-files/execution scripts', ['execution scripts/continuousQueries.prolog',
    #             										'execution scripts/handleApplication.prolog'])]
)

os.system("PATH=$PATH:/usr/local/bin")
os.system("echo Hi!")