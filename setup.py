from setuptools import setup, find_packages
from setuptools.command.egg_info import egg_info

class egg_info_ex(egg_info):
    """Includes license file into `.egg-info` folder."""

    def run(self):
        # don't duplicate license into `.egg-info` when building a distribution
        if not self.distribution.have_run.get('install', True):
            # `install` command is in progress, copy license
            self.mkpath(self.egg_info)
            self.copy_file('LICENSE', self.egg_info)

        egg_info.run(self)

setup(
   name='RTEC2',
   version='1.0',
   py_modules=['RTEC2'],
   install_requires=[
      'Click',
   ],
   author='Alexander Artikis, Manolis Pitsikalis, Periklis Mantenoglou',
   author_email='a.artikis@gmail.com, E.pitsikalis@liverpool.ac.uk, pmantenoglou@iit.demokritos.gr',
   maintainer='Periklis Mantenoglou',
   maintainer_email='pmantenoglou@iit.demokritos.gr',
   description='An Event Calculus dialect optimised for Stream Reasoning',
   url='https://github.com/aartikis/RTEC',
   license_files = ('LICENSE',),
   license='LGPL-3.0',
   cmdclass = {'egg_info': egg_info_ex},
   #package_dir= {
   #   'RTEC2.execution scripts': './execution scripts', 
   #   'RTEC2.src': './src'
   #},
   packages=['RTECv2'],
   package_data={
      'RTECv2': ['src/*.prolog', 'src/utilities/*.prolog', 'src/data loader/*.prolog', 'src/dynamic grounding/*.prolog', 'scripts/*.prolog', 'scripts/*.sh']
   },
   #include_package_data=True,
   scripts=['RTECv2/scripts/RTEC2_cli.py'],
   entry_points={
      'console_scripts':['RTEC2=RTEC2_cli:cli'],
     }
)

