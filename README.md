## 文档类名称
此文档类文件命名为 `mathexercise.cls`。

## 基于文档类
本文档类基于 report 文档类制作。

## 用途
此文档类文件用于编写数学类教材课后习题解答。

## 文档类文件内容
- 基于 TikZ 自定义封面图片
- 基于计数器和 amsthm 宏包自定义习题环境和解答环境

## 文档类选项
- `withinchap`（默认） 和 `withinsec`。使用 `withinchap` 选项时，习题计数器在新的章开始后重置为零；使用 `withinsec` 选项时，习题计数器在新的节开始后重置为零。 

## 需要解决的问题



## 协议


## 参考资料与致谢
- `withinchap` 和 `withinsec` 的选项制作参考 [MSE](https://tex.stackexchange.com/questions/632017/define-own-class-options-relating-to-counter)，向 egreg 表示感谢。