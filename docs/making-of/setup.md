# Feature: Project Setup

Goal: Project setup is ready to begin.


## Details

- [x] [Git repository on Github](#git-repository-on-github)
- [x] [Making-Of setup on Github Pages](#making-of-setup-on-github-pages)
- [x] [VS Code setup](#vs-code-setup)
- [x] [Empty Elm project](#empty-elm-project)


## Git repository on Github

I start with my Github user "pitnyr".
This project is named "elm-y-aeiou-m".
The main branch is "main".

For accessing the Github repository I execute the following steps:

```text
$ git config credential.github.com.usehttppath true
$ git credential approve
url=https://github.com/pitnyr
username=pitnyr
password=<personal-access-token>
<newline>
```

After that I'm able to push to the repository.


## Making-Of setup on Github Pages

The branch name is "gh-pages".
It is an orphaned branch,
so its commit history is independent of the other branches.

The contents is located in the "docs" subdirectory.

In order to have both the Making-Of docs and the sources checked out simultaneously,
I create a git-ignored subdirectory named ".gh-pages".
In this subdirectory I have the "gh-pages" branch checked out.


## VS Code setup

I create a workspace with both the top-level and the ".gh-pages" folders.
It also contains the settings for my VS Code extension [making-of-vscode](https://github.com/pitnyr/making-of-vscode) 😀

The configuration is pretty normal:
```text
making-of.localPath  = /docs/
making-of.publishUrl = https://pitnyr.github.io/elm-y-aeiou-m/
making-of.sourceUrl  = https://github.com/pitnyr/elm-y-aeiou-m/
```


## Empty Elm project

All there is to do is executing “elm init”,
adding "elm-stuff/" to the .gitignore file,
and creating a simple “Main.elm” file.


<a id="commit-2022-03-07-17-08"></a>

## Summary so far

So far it is the standard setup for a project with making-of documentation.

I also add a short README.

[commit-2022-03-07-17-08](https://github.com/pitnyr/elm-y-aeiou-m/commit/57fbeda8c751fa1f85c073bf0c7117c202adac0d)
```email
subject: Create basic project structure
```


## Done

OK, ready to be [merged into the main branch](main.md#commit-2022-03-07-17-12).
