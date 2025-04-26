# my-typst-template
- A typst template for course report, desighed as a student in Chinese Zhejiang University, and is easy to modify.
- 这个 typst 模板是用于课程实验报告的、基于浙江大学 (ZJU) 学子身份设计的模板，集成了几个相对实用的包，对中英文混排做一定优化。
- 建议在本地 VSCode 中使用 [tinymist](https://github.com/Myriad-Dreamin/tinymist.git) 插件，以获得最佳体验。
- 在直接开始使用前，你可能需要下载字体等，可以根据报错定位缺少哪些部分（不过字体可能不会报错而是 fallback 到你已有的字体，也许会有个 warning？）。

## 特点 (feature)
- 根据个人使用习惯，对封面页设置了"report"和"normal"类型，并支持匿名实验报告，支持无封面的简单作业；
- 拥有一键添加封面与目录、优化页眉与页脚、语言切换、图表分章节自动计数等功能；
- 优化了中西文混排、图文混排；
- 整合了一些方便实用的第三方包在内，便于使用。
  - 优化（添加）功能包括：图、表、代码、伪代码、公式、admonitions、theorems、todo、emoji、树形图、流程图、LaTeX 公式支持等。
- 通过更改校徽和校名并调整大小，你也可以很方便地将其改为你的学校。
- 具体使用方法，可以参考 `template/main.typ`。
    ![](template/main.png)

## Change logs
1. 2024.2.1：Initial commit
2. 2024.2.1：Add README and first publish
3. 2024.2.27：根据不同课程报告添加不同 report 类型并略微调整代码
4. 2024.3.1：修改几个 bug
5. 2024.3.1：删除没用的文件
6. 2024.3.3：加入几个新的第三方包，修改代码部分组织方式，修改 margin
7. 2024.3.3：修 bug
8. 2024.3.8：解决中西文空格问题，添加中文斜体解决方案，添加 thms 包
9. 2024.3.8：优化部分编排
10. 2024.3.9：再次添加几个包，重构部分代码，重新上传整个仓库
11. 2024.3.10：typst 0.11.0 发布，根据新版的 template 要求重新组织结构
12. 2024.4.1：调整表格为 0.11.0 的 built-in 表格及一些细节修改
13. 2024.4.5：修改 theorem boxes，使用 showybox 实现
14. 2024.4.14：细节调整与添加 cheq 包
15. 2024.5.13：删除 xarrow 包，添加 fletcher 包，同时修改一些细节，添加页眉与页脚的种类
16. 2024.7.2：添加 indenta, pinit, mitex. 重构部分代码，重构 thms 包
17. 2024.10.19：更新到 typst 0.12.0，更新相关第三方包
18. 2024.10.22：删除 i-figured（自己做更简洁的实现），添加 timeliney 包
19. 2025.1.8：例行更新第三方包，一些细节优化，添加 drafting 包
20. 2025.2.28：更新到 typst 0.13.0，更新相关第三方包，改 codly 为 zebraw
21. 2025.4.26：加 diagbox 包
