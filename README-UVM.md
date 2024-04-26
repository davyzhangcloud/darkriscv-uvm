-----------------------------------------------------------------------------------------------------------
# README.中文

## 功能

本项目是一个基于 UVM 的 Verilog 仿真项目，用于测试一个名为 darksocv 的 SOC 设计。该项目包含以下组件：

1. **darksocv_if.sv**: 定义了一个 Verilog 接口，包含了 SOC 的外部信号，如时钟、复位、UART 接口等。

2. **darksocv_pkg.sv**: 包含了 UVM 组件和类的定义，如 transaction、monitor、driver、sequencer、agent 和 scoreboard。

3. **darksocv_top.sv**: 包含了整个测试环境的顶层模块，包括接口实例、UVM 测试类实例等。

4. **darksocv_test.sv**: 包含了 UVM 测试类的定义，用于生成测试激励信号并驱动 DUT。

5. **Makefile**: 包含了编译和运行仿真的命令。

## 编译仿真步骤

1. 确保已经安装了 Synopsys VCS 仿真器和 UVM 1.1d 版本。

2. 设置环境变量 `UVM_HOME`，使其指向 UVM 1.1d 的安装路径。

3. 打开终端，进入项目目录，然后运行以下命令编译仿真：

  
   make vcs
  

4. 编译完成后，运行以下命令启动仿真：

  
   ./simv -l sim.log +notimingcheck +nospecify -k ucli.key
  

5. 若要查看波形，请运行以下命令：

  
   make waves
  

6. 若要使用 Verdi 进行波形查看，请运行以下命令：

  
   make verdi
  

7. 若要清理项目，请运行以下命令：

  
   make clean
  

8. 若要将项目打包为 tar 文件，请运行以下命令：

  
   make tar
  

通过以上步骤，您可以编译和运行本项目的仿真。如果您遇到任何问题，请随时告诉我。



Readme.English:
# README.md

## Functionality

This project is a Verilog simulation project based on UVM (Universal Verification Methodology) for testing a SOC design called darksocv. The project includes the following components:

1. **darksocv_if.sv**: Defines a Verilog interface that includes the external signals of the SOC, such as clock, reset, UART interface, etc.

2. **darksocv_pkg.sv**: Contains definitions of UVM components and classes, such as transaction, monitor, driver, sequencer, agent, and scoreboard.

3. **darksocv_top.sv**: Includes the top-level module of the entire testbench, including interface instances, UVM test class instances, etc.

4. **darksocv_test.sv**: Contains the definition of the UVM test class, which is used to generate test stimuli and drive the DUT.

5. **Makefile**: Contains commands for compiling and running simulations.

## Compilation and Simulation Steps

1. Ensure that Synopsys VCS simulator and UVM version 1.1d are installed.

2. Set the environment variable `UVM_HOME` to point to the installation path of UVM 1.1d.

3. Open a terminal, enter the project directory, and run the following command to compile the simulation:

  
   make vcs
  

4. After compilation is complete, run the following command to start the simulation:

  
   ./simv -l sim.log +notimingcheck +nospecify -k ucli.key
  

5. To view waveforms, please run the following command:

  
   make waves
  

6. To use Verdi for waveform viewing, please run the following command:

  
   make verdi
  

7. To clean the project, please run the following command:

  
   make clean
  

8. To package the project as a tar file, please run the following command:

  
   make tar
  

Through the above steps, you can compile and run the simulation of this project. If you encounter any problems, please feel free to let me know.

