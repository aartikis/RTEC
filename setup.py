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
   packages=['RTECv2'],
   package_data={
      'RTECv2': ['src/*.prolog', 'src/utilities/*.prolog', 'src/data loader/*.prolog', 'src/dynamic grounding/*.prolog', 'execution scripts/*.prolog']
   },
   #include_package_data=True,
	scripts=['RTECv2/execution scripts/RTEC2_cli.py'],
	entry_points={
		'console_scripts':['RTEC2=RTEC2_cli:cli'],
     }
)

