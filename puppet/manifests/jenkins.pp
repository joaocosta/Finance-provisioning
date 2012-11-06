include jenkins

package { "java":
    ensure  => latest,
}

jenkins::plugin { "git":
    require =>  [ Class["jenkins::package"], Package["java"] ],
}
