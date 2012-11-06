include jenkins

jenkins::plugin { "git":
    require =>  Class["jenkins::package"],
}
