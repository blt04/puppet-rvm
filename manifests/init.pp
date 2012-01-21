stage { 'rvm-install': before => Stage['main'] }

import "classes/*.pp"
import "definitions/*.pp"
