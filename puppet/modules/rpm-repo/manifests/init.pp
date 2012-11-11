class rpm-repo {
    package { "['createrepo', 'yum-utils']":
        ensure      => latest,
    }
}
