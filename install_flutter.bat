@echo off
echo === Flutter 自动安装脚本 ===
echo.

REM 检查管理员权限
net session >nul 2>&1
if %errorLevel% == 0 (
    echo ✅ 检测到管理员权限
) else (
    echo ❌ 请以管理员身份运行此脚本
    pause
    exit /b 1
)

REM 设置安装目录
set "FLUTTER_INSTALL_DIR=C:\flutter"
set "FLUTTER_VERSION=3.16.0"
set "FLUTTER_ZIP=flutter_windows_%FLUTTER_VERSION%-stable.zip"
set "FLUTTER_URL=https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/%FLUTTER_ZIP%"

echo 📥 正在下载 Flutter SDK...
echo 版本: %FLUTTER_VERSION%
echo 安装目录: %FLUTTER_INSTALL_DIR%
echo.

REM 创建安装目录
if not exist "%FLUTTER_INSTALL_DIR%" (
    mkdir "%FLUTTER_INSTALL_DIR%"
)

REM 使用 PowerShell 下载文件
powershell -Command "& {Invoke-WebRequest -Uri '%FLUTTER_URL%' -OutFile '%TEMP%\%FLUTTER_ZIP%'}"

if %errorLevel% neq 0 (
    echo ❌ 下载失败，请检查网络连接
    pause
    exit /b 1
)

echo ✅ 下载完成

REM 解压文件
echo 📦 正在解压 Flutter SDK...
powershell -Command "& {Expand-Archive -Path '%TEMP%\%FLUTTER_ZIP%' -DestinationPath '%FLUTTER_INSTALL_DIR%' -Force}"

if %errorLevel% neq 0 (
    echo ❌ 解压失败
    pause
    exit /b 1
)

echo ✅ 解压完成

REM 设置环境变量
echo 🔧 正在配置环境变量...

REM 添加到 PATH
for /f "tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH 2^>nul') do set "SYSTEM_PATH=%%b"
echo %SYSTEM_PATH% | findstr /C:"%FLUTTER_INSTALL_DIR%\bin" >nul
if %errorLevel% neq 0 (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH /t REG_EXPAND_SZ /d "%SYSTEM_PATH%;%FLUTTER_INSTALL_DIR%\bin" /f
    echo ✅ 已添加到系统 PATH
) else (
    echo ✅ PATH 已存在
)

REM 设置 FLUTTER_HOME 环境变量
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v FLUTTER_HOME /t REG_SZ /d "%FLUTTER_INSTALL_DIR%" /f
echo ✅ 已设置 FLUTTER_HOME 环境变量

REM 刷新环境变量
call refreshenv

REM 清理临时文件
del "%TEMP%\%FLUTTER_ZIP%" /f /q

echo.
echo === Flutter 安装完成 ===
echo.
echo 🚀 请运行以下命令验证安装：
echo    flutter doctor
echo.
echo 📝 注意事项：
echo 1. 可能需要重新启动命令提示符或重启电脑
echo 2. 首次运行 flutter doctor 会下载额外的依赖
echo 3. 如果遇到权限问题，请以管理员身份运行
echo.

pause