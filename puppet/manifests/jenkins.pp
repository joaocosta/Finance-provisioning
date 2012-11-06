include jenkins

package { "java-1.7.0-openjdk":
    ensure  => latest,
}

jenkins::plugin { "git":
    require =>  [ Class["jenkins::package"], Package["java-1.7.0-openjdk"] ],
}
