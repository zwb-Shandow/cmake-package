# cmake package 代码示例

该示例展示了 cpack 打包及库的查找。

## 1. 代码目录

|- **module_a**  add 动态库，提供 (find_package)CONFIG 配置，提供runtime/development deb

|- **module_b**  sub 静态库，提供 (find_package)CONFIG 配置

|- **module_c**  div 动态库，提供 PkgConfig 配置

|- **math**      math 动态库，提供 (find_package)CONFIG 配置，为 div 库提供 (find_package)Module 配置

|- **test**      测试 math 动态库及其依赖

## 2. 编译及安装

### 2.1 module

```shell
# 在 module_a/module_b/module_c 目录下执行如下命令
mkdir build && cd build
cmake ..  # 可通过 -DCMAKE_INSTALL_PREFIX 指定安装路径
make -j$(nproc)
make package # 默认为 deb 包
sudo make package -i package/*.deb
```

### 2.2 math

math 库的 CONFIG 配置中已指明了该库的依赖关系

```shell
cd math
mkdir build && cd build
cmake ..  # 若通过 -DCMAKE_INSTALL_PREFIX 指定了安装路径，则需将该路径加至环境变量
make -j$(nproc)
make package
sudo make package -i package/*.deb
```

### 2.3 test

若 math 库缺少依赖，则会直接在 cmake 阶段进行错误提示，可自行删减库进行测试。
以下提供两种编译方式:
 - cmake 编译

```shell
cd test
mkdir build && cd build
cmake ..
make -j$(nproc)
./test
```
 - gcc 编译
```shell
cd test
g++ main.cc -o main `pkg-config --cflags --libs math`
./main
```
