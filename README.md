# GooseRedis
GooseRedis is a redis client with swift language
# 想法
模拟Python的redis库做Swift Redis库

由于Python是动态语言，在处理类型的时候，遇到了一些麻烦。
比如在set方法中，不是所有的参数都能set进去，所以得添加协议，使其符合协议的可以数据可以，所以要把int， string等添加默认扩展能

get方法也是要做类似的方式

还需要搞清楚python库的运行流程，才好移植