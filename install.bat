@echo off
chcp 65001 >nul

:: 检测 Python 安装情况
echo Checking Python installation...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python is not installed. Please install Python from https://www.python.org/downloads/
    pause
    exit /b 1
)

:: 检测 pip 是否可用
echo Checking pip installation...
pip --version >nul 2>&1
if %errorlevel% neq 0 (
    echo pip is not available. Try reinstalling Python with pip support.
    pause
    exit /b 1
)

echo Installing Python dependencies...
pip install -r requirements.txt

echo Starting the backend application...
start "" "dist\dianji.exe"

echo Current working directory: %cd%
set "frontend_path=."
echo Trying to change directory to: %frontend_path%

cd "%frontend_path%"
if %errorlevel% neq 0 (
    echo Failed to change directory to the frontend project.
    pause
    exit /b 1
)

:: 检测 Node.js 安装情况
echo Checking Node.js installation...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Node.js is not installed. Please install Node.js from https://nodejs.org/en/download/
    pause
    exit /b 1
)

:: 检测 npm 是否可用
echo Checking npm installation...
npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo npm is not available. Try reinstalling Node.js.
    pause
    exit /b 1
)

echo Installing frontend dependencies...
npm install
if %errorlevel% neq 0 (
    echo Failed to install frontend dependencies.
    pause
    exit /b 1
)

echo Starting the frontend application...
start "" npm run dev