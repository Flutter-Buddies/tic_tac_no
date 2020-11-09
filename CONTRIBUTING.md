# Contribution Guidelines

This document will briefly describe basic guidelines for contributors. All project communication shall be done at [issues](https://github.com/Flutter-Buddies/tic_tac_no/issues) or FlutterBuddies Discord  [server](https://discord.gg/X3pfRES6). Everything in this text that you find confusing or have any objections, can and should be discussed at issues or Discord.

The upcoming titles sort of describe the order of things you want to explore before contributing.

## Join a Team

If you like, ask the creator fo this project (slovnicki / sly) to add you to the project's team so you can directly contribute to the repository. If you don't want to be in a project's team, don't worry - you can still contribute.

## Issues

Issues at this repository are a main place to look at when planning to contribute. Two situations can occur:

**Your idea is already present in an issue**

In this case, after reading all the comments at this issue to assess the situation and how it aligns with your ideas, you can

- add your comment with some further insight or a question
- contact issue's assignee (either by leaving a comment with assignee tagged or contacting assignee directly) for details on how can you contribute code

**You have an idea not present in issues**

In this case, you can create a new issue with detailed explanation of your idea, question or bug report with minimal code example if applicable. Then the other contributors will comment further at your issue and you can plan how this will be developed. By default, you can then become the assignee at this issue, the one who will be responsible for it's development. Of course, this is not forced upon anyone so you can let us know in the comments that you prefer not to be the assignee. Then others can apply to be the assignee.

If an issue doesn't have an assignee, the position is open for anyone who wants it. In this assigneeless situation, the "acting assignee" is the project creator (slovnicki / sly).

## Branches

We will try to work by the [GitFlow](https://nvie.com/posts/a-successful-git-branching-model/) branching model to keep ourselfs organized and with as little conflicts as possible. If you want to know more about this, read the link, but it is not necessary. Everything will be explained well enough here.

<p align="center">
<img src="https://raw.githubusercontent.com/Flutter-Buddies/tic_tac_no/master/doc/assets/gitflow.png" alt="gitflow" width="420" style="margin-right:16px;margin-bottom:16px"> 
</p>

We have 3 main branches and these are rarely of concern for most of contributors. We will not use `release` branch for now, but handle this in `master`.

- `master` branch is the one no one should worry about for some time. This is the branch that holds the latest stable version of our project.

- `hotfix` branch is closely related to `master` and is used to fix bugs that simply cannot wait.

- `develop` branch was created from `master` and will be sometime in the future merged into it again. All other branches (except `hotfix` branch) are branched from `develop` and will be merged into `develop`.

Many feature branches

- `settings` branch was created from `develop` to specifically work on `settings/` part of the app

- `menu` branch was created from `develop` to specifically work on `menu/` part of the app

- `game` branch was created from `develop` to specifically work on `game/` part of the app

After there are some useful changes done at some feature branch, Pull Request shall be created to merge it into `develop`. Then we will review changes, maybe have a discussion at pull request's comments section and finally merge it. Of course, in practice there will be little discussion to be made if everything works as expected.

Then, other feature branches can (but don't have to) pull these changes from `develop` to have the latest development state.

### Tips

When you clone the project, you will be at `master` branch by default. To switch branches, use `git checkout <branch-name>`.

If you are contributing at some branch for a while, `git pull origin <branch_name>` to have the latest changes if someone else pushed something in the meantime.

Contributors that are added to the team (contact slovnicki / sly) can `git push origin <branch-name>` directly to this repository.

## Pull Requests

If you wish to contribute code without being a part of the team, you can send a [Pull Request](https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request-from-a-fork) with your changes. Please, after you fork a repository, switch to the `develop` branch and branch your `super-cool-feature` branch from it.

## Code

It is sufficient that you format your code. See [here](https://flutter.dev/docs/development/tools/formatting) how this can be accomplished and automated.
