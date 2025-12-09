@echo off
echo === ArtEcho 开发环境检查 ===
echo 检查时间: %date% %time%
echo.

echo [基础开发环境]
echo [1/8] 检查 Node.js...
node --version >nul 2>&1 && echo ✅ Node.js 已安装 || echo ❌ Node.js 未安装

echo [2/8] 检查 Python...
python --version >nul 2>&1 && echo ✅ Python 已安装 || echo ❌ Python 未安装

echo [3/8] 检查 Git...
git --version >nul 2>&1 && echo ✅ Git 已安装 || echo ❌ Git 未安装

echo.
echo [数据库环境]
echo [4/8] 检查 PostgreSQL...
psql --version >nul 2>&1 && echo ✅ PostgreSQL 已安装 || echo ❌ PostgreSQL 未安装

echo [5/8] 检查 Redis...
redis-cli --version >nul 2>&1 && echo ✅ Redis 已安装 || echo ❌ Redis 未安装

echo [6/8] 检查 MongoDB...
mongo --version >nul 2>&1 && echo ✅ MongoDB 已安装 || echo ❌ MongoDB 未安装

echo.
echo [移动端开发环境]
echo [7/8] 检查 Flutter...
flutter --version >nul 2>&1 && echo ✅ Flutter 已安装 || echo ❌ Flutter 未安装

echo [8/8] 检查 React Native CLI...
npx react-native --version >nul 2>&1 && echo ✅ React Native CLI 已安装 || echo ❌ React Native CLI 未安装

echo.
echo [项目结构检查]
if exist "mobile" (echo ✅ mobile 目录存在) else (echo ❌ mobile 目录不存在)
if exist "web" (echo ✅ web 目录存在) else (echo ❌ web 目录不存在)
if exist "server" (echo ✅ server 目录存在) else (echo ❌ server 目录不存在)
if exist "artecho-venv" (echo ✅ Python 虚拟环境存在) else (echo ❌ Python 虚拟环境不存在)

echo.
echo [Python 虚拟环境检查]
if exist "artecho-venv\Scripts\activate.bat" (
    echo ✅ 虚拟环境可激活
    artecho-venv\Scripts\pip list | findstr fastapi >nul 2>&1 && echo ✅ FastAPI 已安装 || echo ❌ FastAPI 未安装
    artecho-venv\Scripts\pip list | findstr uvicorn >nul 2>&1 && echo ✅ Uvicorn 已安装 || echo ❌ Uvicorn 未安装
) else (
    echo ❌ 虚拟环境不可激活
)

echo.
echo === 环境检查完成 ===
echo.
echo 下一步操作建议：
echo 1. 如果 Flutter 未安装，请运行 install_flutter.bat
echo 2. 如果数据库未安装，请检查开发环境配置.md
echo 3. 激活 Python 虚拟环境: artecho-venv\Scripts\activate
echo.
pause