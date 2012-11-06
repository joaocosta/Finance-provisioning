include jenkins

# These packages are Fedora specific and required by jenkins.  The font package under debian is "ttf-dejavu"
package { ["java-1.7.0-openjdk", "dejavu-sans-fonts"]:
    ensure  => latest,
}

jenkins::plugin { ["git", "github-api", "github-oauth"]:
    require =>  [ Class["jenkins::package"], Package["java-1.7.0-openjdk"] ],
}
