from setuptools import setup, find_packages
from setuptools.command.install import install as _install
from setuptools.command.develop import develop
from setuptools.command.egg_info import egg_info
import os

'''
class CustomInstallCommand(_install):
	def run(self):
		os.system("mv src RTEC-src")
		_install.run(self)

class CustomDevelopCommand(develop):
	def run(self):
		os.system("mv src RTEC-src")
		develop.run(self)

class CustomEggInfoCommand(egg_info):
	def run(self):
		egg_info.run(self)
'''
	
setup(
	name='RTEC',
	version='1.0',
	py_modules=['RTEC'],
	install_requires=[
		'Click',
	],
	#package_dir= {
    #  'RTEC-execution scripts': 'execution scripts', 
    #  'RTEC-src': 'src'
   #},
   packages=['src', 'execution scripts'],
   #package_dir={"RTEC": "../RTEC"},
   package_data={
      'src': ['*.prolog', 'utilities/*.prolog'],
      'execution scripts': ['*.prolog'] 
   },
   #include_package_data=True,
   #package_data = { 'src': ['./*'] },
   scripts=['execution scripts/RTEC_cli.py'],
   entry_points={
		'console_scripts':['RTEC=RTEC_cli:cli'],
     },
    # cmdclass={
    #    'install': CustomInstallCommand,
    #    'develop': CustomDevelopCommand,
    #    'egg_info': CustomEggInfoCommand,
    #},
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

#temp = os.system("$(which pip3)")
#print(temp)
#print('No errors!')
#os.system("PATH=$PATH:/usr/local/bin")
#os.system("echo Hi!")