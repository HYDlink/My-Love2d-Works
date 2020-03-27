# Love2D Turtle 绘图

一个用游戏更新思维制作的海龟绘图程序, 思路还挺蠢的, 都不记得一些细节了
现在觉得可以重构一些东西, 但又没动力, 真正使用肯定是用 py 的 turtle..

可以写脚本之后执行, 使用方式, 假设当前文件夹就在这里
`love . <filename>`
比如 `love . input.txt`

示例脚本 `input.txt`

## Turtle 类型

支持的动作
- `setpos` - 设置当前笔尖的位置
- `setvel` - 设置绘制下次线段时 笔移动的速度
- `right` - 向右转向 90 度
- `left` - 向左转向 90 度
- `rotate` - 逆时针转向
- `forward` - 向前绘制指定距离
- `setwidth` - 设置下次画线的线段宽度
- `setcolor` - 设置下次画线的选段颜色

### [turtle](turtle.lua)

#### 数据结构

`position` - 海龟当前位置
`direction` - 海龟当前方向
`vel` - 默认速度 ( 很二义性 )
`curVel` - 当前速度
`movedDist` - 至上次开始 `forward` 移动过的距离
`targetDist` - `forward` 需要的移动距离
`funcQueue` - **事件队列**, 保存海龟要执行的所有函数
`funcIndex` - 当前使用中的函数在事件队列中的索引

#### 基本思路

每次更新时在当前位置画一个圆 ( 笔的直径 ), 而且不 clear 画面 (更改 `love.run`),
单纯的 turtle 程序不会在中途用到擦写功能, 如果有需要可以手动清除

缺陷非常明显, 可以看到很明显的, 这是用笔不断点击而不是画线的过程, 速度一快中间还会有间隔
可以用绘制正方形取代, 
或者保存之前的位置, 画之前的位置和现在的位置的连线 ( 转角可能会被发现 )

使用函数队列, 调用外部函数时把 内部/私有函数`*_p`, 和相应的参数, 存取到队列中
在 `update` 过程中, 从队列中取出函数和参数, 
如果函数是 `forward`( 这是一个唯一需要等待 然后才能从队列取出函数的过程 ), 记录下要移动的目标距离 `targetDist`, 设置当前移动过的距离 `movedDist` 为0, 在 `update` 不断前进, 
直到移动的距离超过了目标距离, 取出下一个函数, 并进行调用

### [BetterTurtle](BetterTurtle.lua)

#### 数据结构

`position`, `movedDist`, `targetDist`
`lineQueue` - 保存要绘制的线段, 最后一条线作为哨兵记录下次画线的方向
`lastLineIndex` 

取消函数队列, 而是计算总共要画哪些, 怎么样的线, 作为队列 `lineQueue`
删除 turtle 自身保存的 `direction`, 由当前线段的 direction 属性记录

最后一个线作为哨兵, 作为下次更改的方向, 不进行绘制

`update` 的思路和上面一样, 检查当前移动了的距离, 然后进行下一次画线


## 语法解析并执行 [RunTurtle](RunTurtle.lua)

思路: 获取一个 turtle 作为引用, 调用 `LoadOne` 将会解析一个 函数表达式, 然后通过 turtle 调用获取到的函数名以及参数, 以脚本的方式添加 turtle 的执行语句

`init(turtle)` 获取一个 `turtle` 作为引用, 必需

`LoadOne(str)`
解析函数语句 `<func>(<numberparam>[, <paramn> ...])`
保存一个表 `funcTable`, 键对应着 `turtle` 的函数
得到的 `func` 作为表的键从 `funcTable` 获取, 并调用函数

`LoadAll(s)`
按字符串 `s` 的每行, 调用 `LoadOne`, 最后打印 turtle 的信息