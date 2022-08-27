---
layout: post
title: "Why we create Atomic Commits in Git"
subtitle: "为什么我们要创建 Git 原子提交"
date: 2021-05-15 18:34
author: "Oscaner"
header-img: "assets/img/post-bg-alitrip.jpg"
multilingual: false
mathjax: true
no-catalog: false
categories:
  - skill
  - others
  - git
tags:
  - Skill
  - Others
  - Git
---

我们都曾遇到过这样一种情况:

在一次代码提交中进行了大量修改, 但是其中一部分与其他代码**没有任何共同之处**。

但是为了方便起见 (这次顺带), 您决定将所有修改集中到一个 commit 中并准备收工。

是的, 这看起来很诱人, 但事实上它会导致很多问题。

1. 混淆 bugs 或者代码回归的源头。
2. 很难在不 revert[^git_revert] 所需修改的情况下, revert 错误修改。
3. 一个巨大的 Ticket 将变得更加巨大, 并且无法管理。

Atomic Commits (原子提交) 能够帮您解决此类问题, 使您的工作更易于管理。

我建议您尝试一下, 看它是否适合您。

[^git_revert]: [《Git Revert \| Atlassian Git Tutorial》](https://www.atlassian.com/git/tutorials/undoing-changes/git-revert){:target="_blank"}{:rel="nofollow"}

## 单一责任原则 (Single Responsibility Principle)

每当开发者在讨论如何编写干净的代码的时候, 他们经常会提到单一责任原则 (Single Responsibility Principle),

即一个代码单元 (如函数或组件) 应该只关注完成一项任务, 这使得该代码单元更易于测试和重用。

## 原子提交 (Atomic Commits)

我们可以将此原则扩展到 Git, 以支持**负责记录单个、完整工作单元**的原子提交。

这并不意味着每个 commit 都需要限制在一个文件或者几行代码 (但是如果真的出现这种情况, 还是需要的)。

相反, 它意味着您应该能够用一个简单、有意义的 message 来描述您的修改, 而无需添加额外的信息来解释您所做的无关工作。

一个很简单的例子:

假设我进行了代码重构, 同时我也更新了两个功能的 workflow, 以及添加了一个新功能。

在原子提交中, 我们需要将重构、更新、添加分别 commit。

1. Refactor xxx
2. Update feature 1 xxx
3. Update feature 2 xxx
4. Add feature 3 xxx

我不知道原子提交的官方定义是什么, 但对于我来说, 原子提交指的是一个关注它的**上下文** (context), 或者仅关注它的**上下文**的 commit, 并且每一个 commit 应该都是独立可用的。

而何为上下文? 就如同上面所说, `这并不意味着每个 commit 都需要限制在一个文件或者几行代码`,

上下文更多的代指一个主题:

1. 功能 (feature)
2. 错误修复 (bug fix)
3. 重构 (refactor)
4. 升级 (upgrade)
5. 任务 (task)
6. etc...

是的, 这非常棘手, 对于个人的 Git 能力有着极高的要求。我也只能尽可能做到这一点, 但我不确定我总是正确的。

同样您也无需强制要求您团队所有人执行此操作, 也不应该期望它对于所有人都有成效。

但无论如何, 您会发现编写原子提交是一个很好的实践。

## 整体提交 (Monolithic Commits)

与原子提交相反的就是整体提交, 同样拿上面的例子说明。

假设我进行了代码重构, 同时我也更新了两个功能的 workflow, 以及添加了一个新功能。

整个 changeset 在一个 commit 中整体提交。

是的, 也许这不是一个很大的 commit, 它只是将所有修改紧密耦合到了单个 commit 之中。

但是, 它会随着 changeset 的体积而变得庞大, 变得愈发脆弱和容易出错 (即使它有很好的文档说明 - 我在我的工作中遇到过此类情况), 变得难以阅读 (read)、审核 (review) 和撤销 (revert)。

## 太多的 commits

**开发人员/架构**有时**不愿意/不同意**进行大量的小提交, 因为他们担心这会在他们的 commit log 中产生不必要的混乱, 或者产生大量的 commit 冗余。

但事实上, 真的没有所谓的 commit 太多这回事, 许多企业级代码库里的 commit count 可能达到了数万次, 甚至更多。

我们可以简单浏览一下 Github 上比较受欢迎的存储库的 commit count (也许在本文编写之后会更高):

- Visual Studio Code: 82k
- Node.js: 33k
- TypeScript: 32k
- etc ...

很明显, 推送大量 commits 并不会使 git log 或者 time travel 变得更加困难。

并且, 原子提交通过将修改彼此隔离, 让任务追踪变得异常简单, 您可以清楚的区分 `commit X-1, X, X+1`。

## 原子提交的好处

### 追踪 (Track)

原子提交使代码追踪回归变得异常容易, 虽然您确实需要预先付出更多的努力才能将 commit 拆分为独立的工作单元。

但是这项投资非常值得, 我可以很轻松的知道任何一个工作单元在 history 中的位置。

- `git log --online`: 显示所有 commits
- `git log --grep [pattern]`: 基于 message 规则查找相应的 commit
- `git log [commit]`: 跳转到对应 commit 并显示之前的所有 commit
- `git bisect start [start] [end]`: 查找哪一次 commit 引入了 bug

通过原子提交和 `git bisect` 相结合, 可以帮助您更有效的识别有问题的 commit, 同时也可以很确信的保证 commit 中的修改不会影响其他代码。

在必要时刻, 您甚至可以直接 revert 该 commit 而不必担心它会产生更大的负面影响。

### Read, Review, Revert

#### 阅读 (Read)

修改只是集中在单一上下文, 这使得 Chunk 变得更小、更简单、更容易阅读和理解。

- `git show [commit]`
- `git log [commit] -p`
- `tig`[^tig]

[^tig]: [《Tig: text-mode interface for Git》](https://jonas.github.io/tig/){:target="_blank"}{:rel="nofollow"}

#### 审查 (Review)

作为一个小的、集中的、有记录的修改, 代码审查员应该能够在跟踪代码变更的同时仍然保持他们的理智?

#### 撤销 (Revert)

撤销一个原子提交不会影响不相关修改, 而撤销整体提交会同时撤销大量不相关修改。

- `git revert [commit]`

举个例子, 假设您在开发一项重要的功能, 可能需要重构一部分旧代码以适应您的新功能。

当您最终提交 PR 时, 一些 Reviewer 不同意您的某些无关修改, 并要求您撤销他们。也许听起来很简单?

不幸的是, 您没有进行原子提交。

为了方便起见, 您将所有修改集中在了一个 commit 里, 工作范围重叠。

您的一些 message 也是随意编写, 这使得您难以确定是哪部分功能中引入了无关修改。

您唯一的选择是一点点排查, 并手动撤销这些修改。

您没有预先投入时间将您的 commit 拆分为独立工作单元, 导致后期必须花费更多的代价来重新整理和撤销修改。

如果您使用的是原子提交, 那么您能在短短几分钟内, 撤销与 Change Request 相关的 commit, 并请求 Reviewer 重新进行审查。

### 大任务 (Larger Tasks)

假设这样一个场景, 您正在编写一个大的功能, 或者正在重构大量文件。

最初, 这可能过于庞大而缺少方向, 您开始在其中一块代码区域开始工作, 以确认您能走多远。

不知不觉中, 您发现您为了尽快获得解决方案而修改了大量文件, 并且面临另一个挑战: 我该怎么编写我的 commit message? 我如何仅通过一个 commit 来总结我的所有工作?

是的, 当您尝试一次性处理大量修改时, 您无法有效地将它们拆分成独立的工作单元。因此, 您会很想通过一次 commit 来简单带过它们以完成您的工作。

在这种情况下, 缺乏原子提交就是这个大问题的症状, 您没有将原始工作拆分为小单元、可管理的 Chunk, 相反, 您试图一次性完成所有事情。

如果您将工作拆分为较小的 Task, 那么您就能够对每项工作单独 commit, 以提供清晰准确的进度记录。

基于此, 我们能够看到原子提交的两个优点:

1. 它最大程度的减少了较大 Ticket 的认知负担。
2. 它使您可以更轻松地追踪和记录您的工作进度。

编写原子提交迫使您在处理较大 Ticket 时进行小单元、可管理的修改。当您离开工作一天回来后, 它也可以提醒您上回做了什么, 帮助您回忆下一步应该做什么。

## 该怎么做

- 只工作一件事

    这基本不太可能, 因此这也是使用 Git 交互模式的优势所在。

    ```shell
    > git add -i
    ```

- 保持修改尽可能的小

    这可以方便提交修改, 尤其是在进入交互模式时。

- 经常 commit

    需要 amend 的时候就尽快 amend

    ```shell
    > git commit -m "<message>" --amend
    ```

- 有用的 commit message

    1. 选择一个时态并坚持下去。比如, 我很喜欢用现在时的动词作为 message 的开头 (e.g. `Fix xxx`, `Add support for xxx`)
    2. 提及修改的模块、功能或者代码区块
    3. 提及您所修复的 bug
    4. 如果可能, 在您的 commit message 中 reference 相应的 issue, 这在 Github 中非常常见 (e.g. `Fix #123: xxx`, `Fix xxx (#123)`)

        ![1.png](/assets/img/in-post/skill/others/post-why-we-create-atomic-commits-in-git/1.png)

    当然, 这取决于您与您的开发人员之间的约定, 并非强制。

- 整理 commit

    当为了本地调试方便而随意添加 commit 之后, 在提交 PR 之前需要通过交互模式对 commit 做一次整理

    ```shell
    > git rebase -i [commit]
    ```

## 总结

编写原子提交真的很烦人。它会影响您的开发速度和进度, 迫使您必须将工作拆分成更小单元, 它还要求您编写有意义的、描述性的 commit message。

但是, 这看似不怎么方便, 却实实在在的提高了您的工作质量, 并使您和您的开发人员的生活变得更加轻松。

并且, 编写原子提交的目标也并不是创建"100 个 commit", 而是务实地制作相关修改以获得更好的历史记录、认知负载以及更简单的回滚修改。

如果有需要, 我还会讲一期如何编写原子提交。

致辞, 共勉。
