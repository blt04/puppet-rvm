
define rvm::system_user () {

    $username = $title
    $group = $operatingsystem ? {
        default => 'rvm',
    }

    exec { "/usr/sbin/usermod -a -G $group $username":
        unless => "cat /etc/group | grep $group | grep $username",
        require => [User[$username], Exec['system-rvm']];
    }
}
