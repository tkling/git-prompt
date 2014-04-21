git-prompt
==========

prompt format:
```bash
09:36 tkling <span style="color:red;">[awesome-branch]</span> git-prompt => 
```

Copy pasta this script, or be sensible and `source` it, into your user bash profile (usually `~/.profile` or `~/.bash_profile`), 
reload your terminal, and look at your git info!

Only shows git info if you're in a git repo.

Requires a version of git with the `symbolic-ref` command => at least [1.5.6.6](http://git-scm.com/docs/git-symbolic-ref)

Special thanks to [@jusroberts](https://github.com/jusroberts) for cleaning up the script and making colors work!
