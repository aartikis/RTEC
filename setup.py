from setuptools import setup, find_packages

setup(
	name='RTEC2',
	version='1.0',
	py_modules=['RTEC2'],
	install_requires=[
		'Click',
	],
   #package_dir= {
   #   'RTEC2.execution scripts': './execution scripts', 
   #   'RTEC2.src': './src'
   #},
   packages=['execution scripts', 'src'],
   package_data={
      'src': ['*.prolog', 'utilities/*.prolog', 'data loader/*.prolog', 'dynamic grounding/*.prolog'],
      'execution scripts':['*.prolog'] 
   },
   #include_package_data=True,
	scripts=['execution scripts/RTEC2_cli.py'],
	entry_points={
		'console_scripts':['RTEC2=RTEC2_cli:cli'],
     }
)

