# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v3.0.0](https://github.com/voxpupuli/puppet-rvm/tree/v3.0.0) (2024-01-09)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v2.0.0...v3.0.0)

**Breaking changes:**

- Drop OracleLinux support [\#204](https://github.com/voxpupuli/puppet-rvm/pull/204) ([ekohl](https://github.com/ekohl))
- Drop Puppet 6 support [\#197](https://github.com/voxpupuli/puppet-rvm/pull/197) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- puppetlabs/stdlib: Allow 9.x [\#199](https://github.com/voxpupuli/puppet-rvm/pull/199) ([bastelfreak](https://github.com/bastelfreak))
- make gnupg class/wget package optional [\#193](https://github.com/voxpupuli/puppet-rvm/pull/193) ([bastelfreak](https://github.com/bastelfreak))

**Fixed bugs:**

- Fix broken logic for gpg keys [\#192](https://github.com/voxpupuli/puppet-rvm/pull/192) ([bastelfreak](https://github.com/bastelfreak))
- Deal with -next part in RVM versions [\#191](https://github.com/voxpupuli/puppet-rvm/pull/191) ([jplindquist](https://github.com/jplindquist))

**Merged pull requests:**

- Remove legacy top-scope syntax in README [\#203](https://github.com/voxpupuli/puppet-rvm/pull/203) ([smortex](https://github.com/smortex))

## [v2.0.0](https://github.com/voxpupuli/puppet-rvm/tree/v2.0.0) (2022-07-07)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.13.1...v2.0.0)

**Breaking changes:**

- Add support for Puppet 7, EL8 & Debian 11; drop Debian 9 [\#184](https://github.com/voxpupuli/puppet-rvm/pull/184) ([ekohl](https://github.com/ekohl))
- Add data types and other minor cleanups [\#182](https://github.com/voxpupuli/puppet-rvm/pull/182) ([ekohl](https://github.com/ekohl))
- Rename gnupg\_key\_id parameter to signing\_keys [\#178](https://github.com/voxpupuli/puppet-rvm/pull/178) ([saz](https://github.com/saz))
- Drop Solaris support [\#177](https://github.com/voxpupuli/puppet-rvm/pull/177) ([bastelfreak](https://github.com/bastelfreak))
- Drop Windows support [\#176](https://github.com/voxpupuli/puppet-rvm/pull/176) ([bastelfreak](https://github.com/bastelfreak))
- Drop AIX support [\#175](https://github.com/voxpupuli/puppet-rvm/pull/175) ([bastelfreak](https://github.com/bastelfreak))
- Update supported Ubuntu versions to 18.04 & 20.04 [\#169](https://github.com/voxpupuli/puppet-rvm/pull/169) ([bastelfreak](https://github.com/bastelfreak))
- Update Debian to support versions 9 & 10 [\#168](https://github.com/voxpupuli/puppet-rvm/pull/168) ([bastelfreak](https://github.com/bastelfreak))
- Drop EOL EL4, EL5 and EL6 [\#167](https://github.com/voxpupuli/puppet-rvm/pull/167) ([bastelfreak](https://github.com/bastelfreak))
- Drop EoL Puppet 5 [\#166](https://github.com/voxpupuli/puppet-rvm/pull/166) ([bastelfreak](https://github.com/bastelfreak))
- Remove `rvm::gpg` class [\#149](https://github.com/voxpupuli/puppet-rvm/pull/149) ([alexjfisher](https://github.com/alexjfisher))

**Implemented enhancements:**

- Properly ensure curl is present when needed [\#181](https://github.com/voxpupuli/puppet-rvm/pull/181) ([ekohl](https://github.com/ekohl))
- puppetlabs/stdlib: Allow 7.x/8.x [\#170](https://github.com/voxpupuli/puppet-rvm/pull/170) ([bastelfreak](https://github.com/bastelfreak))
- Allow rvm to mount a Ruby [\#110](https://github.com/voxpupuli/puppet-rvm/pull/110) ([paulccarey](https://github.com/paulccarey))

**Fixed bugs:**

- Support environment isolation by removing lambdas from title patterns [\#163](https://github.com/voxpupuli/puppet-rvm/pull/163) ([joshperry](https://github.com/joshperry))
- update GPG key [\#159](https://github.com/voxpupuli/puppet-rvm/pull/159) ([mmoll](https://github.com/mmoll))
- Update deprecated install options, and strip default string from gem output [\#142](https://github.com/voxpupuli/puppet-rvm/pull/142) ([jplindquist](https://github.com/jplindquist))
- Avoid warn with puppet4 [\#137](https://github.com/voxpupuli/puppet-rvm/pull/137) ([PascalBourdier](https://github.com/PascalBourdier))
- Fix autolib\_mode parameter references [\#123](https://github.com/voxpupuli/puppet-rvm/pull/123) ([walkamongus](https://github.com/walkamongus))

**Closed issues:**

- OptionParser::InvalidOption ERROR when using --no-rdoc \(this is not a warning\) [\#146](https://github.com/voxpupuli/puppet-rvm/issues/146)
- Update rvm signature key [\#145](https://github.com/voxpupuli/puppet-rvm/issues/145)

**Merged pull requests:**

- Clean up tests of deprecated styles [\#180](https://github.com/voxpupuli/puppet-rvm/pull/180) ([ekohl](https://github.com/ekohl))
- puppet-lint: fix top\_scope\_facts warnings [\#172](https://github.com/voxpupuli/puppet-rvm/pull/172) ([bastelfreak](https://github.com/bastelfreak))
- Various Rubocop and lint fixes [\#164](https://github.com/voxpupuli/puppet-rvm/pull/164) ([bastelfreak](https://github.com/bastelfreak))
- Require puppet-epel over stahnma-epel in acceptance test [\#161](https://github.com/voxpupuli/puppet-rvm/pull/161) ([dhoppe](https://github.com/dhoppe))
- Rubocop: Fix Lint/HandleExceptions [\#157](https://github.com/voxpupuli/puppet-rvm/pull/157) ([alexjfisher](https://github.com/alexjfisher))
- Rubocop: Fix RSpec/InstanceVariable [\#156](https://github.com/voxpupuli/puppet-rvm/pull/156) ([alexjfisher](https://github.com/alexjfisher))
- Rubocop: Fix Lint/AssignmentInCondition [\#155](https://github.com/voxpupuli/puppet-rvm/pull/155) ([alexjfisher](https://github.com/alexjfisher))
- Rubocop: Fix Style/GuardClause [\#154](https://github.com/voxpupuli/puppet-rvm/pull/154) ([alexjfisher](https://github.com/alexjfisher))
- Rubocop Autofixes [\#153](https://github.com/voxpupuli/puppet-rvm/pull/153) ([alexjfisher](https://github.com/alexjfisher))
- Fix puppet-lint errors and get tests running [\#152](https://github.com/voxpupuli/puppet-rvm/pull/152) ([alexjfisher](https://github.com/alexjfisher))
- Fix metadata.json lint warnings [\#151](https://github.com/voxpupuli/puppet-rvm/pull/151) ([alexjfisher](https://github.com/alexjfisher))
- Add dependencies to `.fixtures.yml` [\#150](https://github.com/voxpupuli/puppet-rvm/pull/150) ([alexjfisher](https://github.com/alexjfisher))
- Convert rvm\_system\_ruby autolib\_mode to parameter [\#122](https://github.com/voxpupuli/puppet-rvm/pull/122) ([walkamongus](https://github.com/walkamongus))

## [v1.13.1](https://github.com/voxpupuli/puppet-rvm/tree/v1.13.1) (2016-03-01)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.13.0...v1.13.1)

**Merged pull requests:**

- Update project url and source to use HTTPS [\#112](https://github.com/voxpupuli/puppet-rvm/pull/112) ([rnelson0](https://github.com/rnelson0))

## [v1.13.0](https://github.com/voxpupuli/puppet-rvm/tree/v1.13.0) (2016-03-01)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.12.1...v1.13.0)

**Closed issues:**

- RVM tries, by default, to create a file /etc/rvmrc on Windows. [\#102](https://github.com/voxpupuli/puppet-rvm/issues/102)
- Key D39DC0E3 does not exist on hkp://keys.gnupg.net [\#100](https://github.com/voxpupuli/puppet-rvm/issues/100)
- `ensure => latest` results in resource change on every run [\#57](https://github.com/voxpupuli/puppet-rvm/issues/57)

**Merged pull requests:**

- Fix idempotency error when using latest. [\#115](https://github.com/voxpupuli/puppet-rvm/pull/115) ([eesprit](https://github.com/eesprit))
- Include ruby- prefix in hiera example. [\#109](https://github.com/voxpupuli/puppet-rvm/pull/109) ([rubys](https://github.com/rubys))
- System user and group [\#104](https://github.com/voxpupuli/puppet-rvm/pull/104) ([stintel](https://github.com/stintel))
- -- Added a smartparam to toggle managing the rvmrc based on osfamily [\#103](https://github.com/voxpupuli/puppet-rvm/pull/103) ([madelaney](https://github.com/madelaney))
- fix 'Undefined variable "::rvm\_version"' [\#99](https://github.com/voxpupuli/puppet-rvm/pull/99) ([jangrewe](https://github.com/jangrewe))
- added support for freebsd and tests for freebsd/darwin [\#98](https://github.com/voxpupuli/puppet-rvm/pull/98) ([tosmi](https://github.com/tosmi))

## [v1.12.1](https://github.com/voxpupuli/puppet-rvm/tree/v1.12.1) (2015-07-08)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.12.0...v1.12.1)

**Closed issues:**

- rvm first install doesn't work because  RVM 1.26.0 introduces signed releases and automated check of signatures when GPG software found [\#94](https://github.com/voxpupuli/puppet-rvm/issues/94)
- Suggest using the forge approved module for gpg [\#86](https://github.com/voxpupuli/puppet-rvm/issues/86)
- how to install rvm and ruby and gems under single user? [\#84](https://github.com/voxpupuli/puppet-rvm/issues/84)
- rvm no available for user [\#72](https://github.com/voxpupuli/puppet-rvm/issues/72)
- Can't install Rubinius  [\#61](https://github.com/voxpupuli/puppet-rvm/issues/61)
- Could not autoload rvm\_system\_ruby [\#60](https://github.com/voxpupuli/puppet-rvm/issues/60)

**Merged pull requests:**

- Allow custom key\_server paramter for gnupg keys [\#93](https://github.com/voxpupuli/puppet-rvm/pull/93) ([xelwarto](https://github.com/xelwarto))

## [v1.12.0](https://github.com/voxpupuli/puppet-rvm/tree/v1.12.0) (2015-05-16)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.11.0...v1.12.0)

**Closed issues:**

- Key server down [\#91](https://github.com/voxpupuli/puppet-rvm/issues/91)
- RVM installs with default ruby but fails to create gemset [\#89](https://github.com/voxpupuli/puppet-rvm/issues/89)

**Merged pull requests:**

- Extractig key\_id as paramater for rvm class [\#92](https://github.com/voxpupuli/puppet-rvm/pull/92) ([joebew42](https://github.com/joebew42))

## [v1.11.0](https://github.com/voxpupuli/puppet-rvm/tree/v1.11.0) (2015-03-27)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.10.2...v1.11.0)

**Merged pull requests:**

- Install gems using Hiera [\#87](https://github.com/voxpupuli/puppet-rvm/pull/87) ([tiengo](https://github.com/tiengo))
- Added option to specify the key\_server [\#85](https://github.com/voxpupuli/puppet-rvm/pull/85) ([ajcrowe](https://github.com/ajcrowe))

## [v1.10.2](https://github.com/voxpupuli/puppet-rvm/tree/v1.10.2) (2015-03-09)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.10.1...v1.10.2)

## [v1.10.1](https://github.com/voxpupuli/puppet-rvm/tree/v1.10.1) (2015-02-20)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.10.0...v1.10.1)

**Closed issues:**

- Puppet RVM looks for presence of gpg2, but RVM installer is agostic [\#82](https://github.com/voxpupuli/puppet-rvm/issues/82)
- CentOS 7 dependencies should be libcurl-devel not curl-devel [\#80](https://github.com/voxpupuli/puppet-rvm/issues/80)

**Merged pull requests:**

- Fixes \#80 - CentOS 7 libcurl-devel dependency [\#81](https://github.com/voxpupuli/puppet-rvm/pull/81) ([TJM](https://github.com/TJM))

## [v1.10.0](https://github.com/voxpupuli/puppet-rvm/tree/v1.10.0) (2015-02-05)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.9.1...v1.10.0)

**Closed issues:**

- Changes for gpg ignore Darwin \(OSX\) support [\#76](https://github.com/voxpupuli/puppet-rvm/issues/76)

**Merged pull requests:**

- Use which to test for gpg2 [\#78](https://github.com/voxpupuli/puppet-rvm/pull/78) ([edestecd](https://github.com/edestecd))

## [v1.9.1](https://github.com/voxpupuli/puppet-rvm/tree/v1.9.1) (2015-01-29)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.9.0...v1.9.1)

**Merged pull requests:**

- allow override to not install mod\_passenger if just installing the gem [\#75](https://github.com/voxpupuli/puppet-rvm/pull/75) ([eefahy](https://github.com/eefahy))
- Name check should be exact, not globbed [\#74](https://github.com/voxpupuli/puppet-rvm/pull/74) ([scurvy](https://github.com/scurvy))

## [v1.9.0](https://github.com/voxpupuli/puppet-rvm/tree/v1.9.0) (2015-01-16)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.8.1...v1.9.0)

**Closed issues:**

- passenger\_mod.so missing? [\#54](https://github.com/voxpupuli/puppet-rvm/issues/54)

**Merged pull requests:**

- adding ubuntu 14.04 support for rvm:passenger [\#73](https://github.com/voxpupuli/puppet-rvm/pull/73) ([jonoterc](https://github.com/jonoterc))

## [v1.8.1](https://github.com/voxpupuli/puppet-rvm/tree/v1.8.1) (2014-12-19)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.8.0...v1.8.1)

**Closed issues:**

- Concat\(\) requires an array - but it has one [\#71](https://github.com/voxpupuli/puppet-rvm/issues/71)

## [v1.8.0](https://github.com/voxpupuli/puppet-rvm/tree/v1.8.0) (2014-12-15)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.7.1...v1.8.0)

## [v1.7.1](https://github.com/voxpupuli/puppet-rvm/tree/v1.7.1) (2014-11-25)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.7.0...v1.7.1)

**Closed issues:**

- Push 1.7.0 to Forge [\#66](https://github.com/voxpupuli/puppet-rvm/issues/66)

## [v1.7.0](https://github.com/voxpupuli/puppet-rvm/tree/v1.7.0) (2014-11-20)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.6.6...v1.7.0)

**Closed issues:**

- Gem not installing correctly [\#62](https://github.com/voxpupuli/puppet-rvm/issues/62)

## [v1.6.6](https://github.com/voxpupuli/puppet-rvm/tree/v1.6.6) (2014-09-15)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.6.5...v1.6.6)

## [v1.6.5](https://github.com/voxpupuli/puppet-rvm/tree/v1.6.5) (2014-09-12)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.6.4...v1.6.5)

**Closed issues:**

- run gem installed with rvm\_gem? [\#56](https://github.com/voxpupuli/puppet-rvm/issues/56)
- Invalid resource type rvm\_wrapper [\#55](https://github.com/voxpupuli/puppet-rvm/issues/55)
- instructions to use `file{'/etc/rvmrc'}` fail as duplicate [\#51](https://github.com/voxpupuli/puppet-rvm/issues/51)

**Merged pull requests:**

- Quote bare word upper case words in case statements [\#58](https://github.com/voxpupuli/puppet-rvm/pull/58) ([edestecd](https://github.com/edestecd))

## [v1.6.4](https://github.com/voxpupuli/puppet-rvm/tree/v1.6.4) (2014-08-19)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.6.3...v1.6.4)

**Merged pull requests:**

- Add instructions for using rvm::rvmrc class [\#52](https://github.com/voxpupuli/puppet-rvm/pull/52) ([mczepiel](https://github.com/mczepiel))

## [v1.6.3](https://github.com/voxpupuli/puppet-rvm/tree/v1.6.3) (2014-08-18)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.6.2...v1.6.3)

**Merged pull requests:**

- Add silence\_path\_mismatch\_check\_flag to rvm::rvmrc [\#53](https://github.com/voxpupuli/puppet-rvm/pull/53) ([mczepiel](https://github.com/mczepiel))
- consider not using ensure\_resource in system\_user.pp [\#50](https://github.com/voxpupuli/puppet-rvm/pull/50) ([eefahy](https://github.com/eefahy))

## [v1.6.2](https://github.com/voxpupuli/puppet-rvm/tree/v1.6.2) (2014-07-29)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.6.1...v1.6.2)

**Merged pull requests:**

- Use OS X's directory service tools to manage adding user to rvm group [\#48](https://github.com/voxpupuli/puppet-rvm/pull/48) ([paulmakepeace](https://github.com/paulmakepeace))

## [v1.6.1](https://github.com/voxpupuli/puppet-rvm/tree/v1.6.1) (2014-07-23)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.6.0...v1.6.1)

## [v1.6.0](https://github.com/voxpupuli/puppet-rvm/tree/v1.6.0) (2014-07-22)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.5.9...v1.6.0)

**Closed issues:**

- How to: Not use group=rvm [\#46](https://github.com/voxpupuli/puppet-rvm/issues/46)
- rvm::passenger::apache not loading correct mod\_passenger.so module on Debian [\#18](https://github.com/voxpupuli/puppet-rvm/issues/18)

**Merged pull requests:**

- use mod\_lib\_path with apache::mod::passenger for compatibility [\#47](https://github.com/voxpupuli/puppet-rvm/pull/47) ([jonoterc](https://github.com/jonoterc))

## [v1.5.9](https://github.com/voxpupuli/puppet-rvm/tree/v1.5.9) (2014-06-24)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.5.8...v1.5.9)

**Closed issues:**

- Bad curl URL for rvm-installer [\#43](https://github.com/voxpupuli/puppet-rvm/issues/43)
- Rvm install not working due to github domain changes [\#42](https://github.com/voxpupuli/puppet-rvm/issues/42)

**Merged pull requests:**

- Fix RVM version logging [\#44](https://github.com/voxpupuli/puppet-rvm/pull/44) ([jbussdieker](https://github.com/jbussdieker))

## [v1.5.8](https://github.com/voxpupuli/puppet-rvm/tree/v1.5.8) (2014-06-09)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.5.7...v1.5.8)

**Closed issues:**

- documentation references puppet 2.x, module requires puppet 3 [\#35](https://github.com/voxpupuli/puppet-rvm/issues/35)

**Merged pull requests:**

- Make the autoupdate\_flag a string to avoid this bug: [\#41](https://github.com/voxpupuli/puppet-rvm/pull/41) ([huasome](https://github.com/huasome))

## [v1.5.7](https://github.com/voxpupuli/puppet-rvm/tree/v1.5.7) (2014-05-27)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.5.6...v1.5.7)

## [v1.5.6](https://github.com/voxpupuli/puppet-rvm/tree/v1.5.6) (2014-05-13)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.5.5...v1.5.6)

**Closed issues:**

- 1.5.6 is not on the forge [\#38](https://github.com/voxpupuli/puppet-rvm/issues/38)

**Merged pull requests:**

- only install curl if it isn't defined elsewhere [\#39](https://github.com/voxpupuli/puppet-rvm/pull/39) ([ghost](https://github.com/ghost))

## [v1.5.5](https://github.com/voxpupuli/puppet-rvm/tree/v1.5.5) (2014-04-30)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.5.4...v1.5.5)

**Closed issues:**

- RVM Fails due to some certificate [\#36](https://github.com/voxpupuli/puppet-rvm/issues/36)
- Puppet + puppet-rvm + bundler defaults to system Ruby, not RVM default [\#33](https://github.com/voxpupuli/puppet-rvm/issues/33)
- mod\_passenger is installed with yum [\#28](https://github.com/voxpupuli/puppet-rvm/issues/28)

## [v1.5.4](https://github.com/voxpupuli/puppet-rvm/tree/v1.5.4) (2014-04-04)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.5.3...v1.5.4)

**Closed issues:**

- spec/acceptance instructions in README are out of date [\#31](https://github.com/voxpupuli/puppet-rvm/issues/31)

**Merged pull requests:**

- Increase apache install timeout [\#32](https://github.com/voxpupuli/puppet-rvm/pull/32) ([iszak](https://github.com/iszak))

## [v1.5.3](https://github.com/voxpupuli/puppet-rvm/tree/v1.5.3) (2014-03-31)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.5.2...v1.5.3)

## [v1.5.2](https://github.com/voxpupuli/puppet-rvm/tree/v1.5.2) (2014-03-19)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.5.1...v1.5.2)

**Closed issues:**

- Fail to install necessary package "curl" [\#24](https://github.com/voxpupuli/puppet-rvm/issues/24)

## [v1.5.1](https://github.com/voxpupuli/puppet-rvm/tree/v1.5.1) (2014-03-15)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.5.0...v1.5.1)

**Closed issues:**

- Why does puppet-rvm depend on puppet-apache? [\#27](https://github.com/voxpupuli/puppet-rvm/issues/27)
- Issue installing system wide and rails app [\#26](https://github.com/voxpupuli/puppet-rvm/issues/26)
- Installation Help [\#19](https://github.com/voxpupuli/puppet-rvm/issues/19)
- encountering general issues related to running puppet as root [\#16](https://github.com/voxpupuli/puppet-rvm/issues/16)

## [v1.5.0](https://github.com/voxpupuli/puppet-rvm/tree/v1.5.0) (2014-03-06)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.4.4...v1.5.0)

## [v1.4.4](https://github.com/voxpupuli/puppet-rvm/tree/v1.4.4) (2014-03-05)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.4.3...v1.4.4)

**Closed issues:**

- RVM not in PATH after installation [\#25](https://github.com/voxpupuli/puppet-rvm/issues/25)

## [v1.4.3](https://github.com/voxpupuli/puppet-rvm/tree/v1.4.3) (2014-03-04)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.4.2...v1.4.3)

## [v1.4.2](https://github.com/voxpupuli/puppet-rvm/tree/v1.4.2) (2014-02-24)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.4.1...v1.4.2)

**Closed issues:**

- Module assumes there's a rvm group [\#20](https://github.com/voxpupuli/puppet-rvm/issues/20)

**Merged pull requests:**

- Added proxy support for provider, and added spec test [\#23](https://github.com/voxpupuli/puppet-rvm/pull/23) ([superseb](https://github.com/superseb))

## [v1.4.1](https://github.com/voxpupuli/puppet-rvm/tree/v1.4.1) (2014-01-31)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.4.0...v1.4.1)

## [v1.4.0](https://github.com/voxpupuli/puppet-rvm/tree/v1.4.0) (2014-01-27)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.3.1...v1.4.0)

## [v1.3.1](https://github.com/voxpupuli/puppet-rvm/tree/v1.3.1) (2014-01-22)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.3.0...v1.3.1)

**Closed issues:**

- rvm fails when /tmp is mounted with noexec flag [\#9](https://github.com/voxpupuli/puppet-rvm/issues/9)

## [v1.3.0](https://github.com/voxpupuli/puppet-rvm/tree/v1.3.0) (2014-01-14)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.2.0...v1.3.0)

**Closed issues:**

- Dependency missing for RedHat 6 [\#17](https://github.com/voxpupuli/puppet-rvm/issues/17)
- ruby-2.0.0 breaks rvm\_gem type [\#3](https://github.com/voxpupuli/puppet-rvm/issues/3)

## [v1.2.0](https://github.com/voxpupuli/puppet-rvm/tree/v1.2.0) (2013-11-06)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.1.12...v1.2.0)

## [v1.1.12](https://github.com/voxpupuli/puppet-rvm/tree/v1.1.12) (2013-10-27)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.1.11...v1.1.12)

**Closed issues:**

- RVM version change fails due to recent commit [\#10](https://github.com/voxpupuli/puppet-rvm/issues/10)

**Merged pull requests:**

- Centos 5 also requires curl-devel [\#14](https://github.com/voxpupuli/puppet-rvm/pull/14) ([ddub](https://github.com/ddub))

## [v1.1.11](https://github.com/voxpupuli/puppet-rvm/tree/v1.1.11) (2013-10-15)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.1.10...v1.1.11)

## [v1.1.10](https://github.com/voxpupuli/puppet-rvm/tree/v1.1.10) (2013-10-15)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.1.9...v1.1.10)

## [v1.1.9](https://github.com/voxpupuli/puppet-rvm/tree/v1.1.9) (2013-10-11)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.1.8...v1.1.9)

## [v1.1.8](https://github.com/voxpupuli/puppet-rvm/tree/v1.1.8) (2013-09-05)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.1.7...v1.1.8)

## [v1.1.7](https://github.com/voxpupuli/puppet-rvm/tree/v1.1.7) (2013-08-28)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.1.6...v1.1.7)

## [v1.1.6](https://github.com/voxpupuli/puppet-rvm/tree/v1.1.6) (2013-08-28)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.1.5...v1.1.6)

**Closed issues:**

- Install Stage breaking entire puppet run due to missing dependencies [\#7](https://github.com/voxpupuli/puppet-rvm/issues/7)

**Merged pull requests:**

- Remove stage in rvm class [\#8](https://github.com/voxpupuli/puppet-rvm/pull/8) ([tmclaugh](https://github.com/tmclaugh))

## [v1.1.5](https://github.com/voxpupuli/puppet-rvm/tree/v1.1.5) (2013-07-23)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.1.4...v1.1.5)

## [v1.1.4](https://github.com/voxpupuli/puppet-rvm/tree/v1.1.4) (2013-06-21)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.1.3...v1.1.4)

## [v1.1.3](https://github.com/voxpupuli/puppet-rvm/tree/v1.1.3) (2013-06-19)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.1.2...v1.1.3)

## [v1.1.2](https://github.com/voxpupuli/puppet-rvm/tree/v1.1.2) (2013-06-05)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.1.1...v1.1.2)

## [v1.1.1](https://github.com/voxpupuli/puppet-rvm/tree/v1.1.1) (2013-05-30)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.1.0...v1.1.1)

## [v1.1.0](https://github.com/voxpupuli/puppet-rvm/tree/v1.1.0) (2013-05-29)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/v1.0.0...v1.1.0)

**Closed issues:**

- Invalid option when installing gems [\#6](https://github.com/voxpupuli/puppet-rvm/issues/6)
- Installing RVM breaks puppet on target system [\#5](https://github.com/voxpupuli/puppet-rvm/issues/5)
- Ruby 2.0.0-p0 CentOS 6 has additional dependencies. [\#4](https://github.com/voxpupuli/puppet-rvm/issues/4)
- using rvm to different location [\#2](https://github.com/voxpupuli/puppet-rvm/issues/2)

## [v1.0.0](https://github.com/voxpupuli/puppet-rvm/tree/v1.0.0) (2013-01-30)

[Full Changelog](https://github.com/voxpupuli/puppet-rvm/compare/72e28ccaf74baae4e110416047d1fb35a5264537...v1.0.0)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
