@echo off
color 3
rem Batch file by MrOrdenador
title By MrOrdenador on Youtube

echo Do you want to do a Restore Point?
echo [1] Yes [2] No
set /p input=:
if /i %input% == 1 goto rstr
if /i %input% == 2 goto x
:rstr
set restorePointName=MrOrdenador Tool Restore Point
powershell.exe -Command "Checkpoint-Computer -Description '%restorePointName%'"
goto :x
:x
if not exist "C:\pingoptimizer" goto :download
if exist "C:\pingoptimizer" goto :menu
:download
md C:\pingoptimizer
goto :menu

:menu
cls

echo [36m *******   **   ****     **   ********          *******   *******  ********** **  ****     **** ** ******** ******** *******  
echo /**////** /**  /**/**   /**  **//////**        **/////** /**////**/////**/// /** /**/**   **/**/**//////** /**///// /**////** 
echo /**   /** /**  /**//**  /** **      //        **     //**/**   /**    /**    /** /**//** ** /**/**     **  /**      /**   /** 
echo /*******  /**  /** //** /**/**               /**      /**/*******     /**    /** /** //***  /**/**    **   /******* /*******  
echo /**////   /**  /**  //**/**/**    *****      /**      /**/**////      /**    /** /**  //*   /**/**   **    /**////  /**///**  
echo /**       /**  /**   //****//**  ////**      //**     ** /**          /**    /** /**   /    /**/**  **     /**      /**  //** 
echo /**       /**  /**    //*** //********        //*******  /**          /**    /** /**        /**/** ********/********/**   //**
echo //        //   //      ///   ////////          ///////   //           //     //  //         // // //////// //////// //     // 
echo ----------------------------------------------------------------------------------------------------------------------
echo By MrOrdenador on [31mYoutube
echo  [36m[[35m1[0m[36m] [35mStart TCPOptimizer and more ping tweaks
echo  [36m[[35m2[0m[36m] [35mClean DNS
echo  [36m[[35m3[0m[36m] [35mOptimized DNS
echo  [36m[[35m4[0m[36m] [35mSome good apps to get less ping
echo  [36m[[35m5[0m[36m] [35mOpen advanced network config
echo  [36m[[35mR[0m[36m] [35mUse the restorepoint
echo  [36m[[35mL[0m[36m] [35mMrOrdenador's links
set /p input=[35m:
if /i %input% == 1 goto 1
if /i %input% == 2 goto 2
if /i %input% == 3 goto 3
if /i %input% == 4 goto 4
if /i %input% == 5 ncpa.cpl
if /i %input% == r rstrui.exe
if /i %input% == L start https://linktr.ee/mrordenador
goto :menu

:1
echo Downloading TCPOptimizer
curl -g -k -L -# -o "C:\pingoptimizer\TCPOptimizer.exe" "https://cdn.discordapp.com/attachments/1224379792392978483/1226157337119686780/3_TCPOptimizer.exe?ex=6623bf02&is=66114a02&hm=97660903d562ad8a28d401a29b28277401c428ed5e109a35abdf656b043068db&"
start C:\pingoptimizer\TCPOptimizer.exe
netsh int tcp set global autotuninglevel=normal
netsh interface 6to4 set state disabled
netsh int isatap set state disable
netsh int tcp set global timestamps=disabled
netsh int tcp set heuristics disabled
netsh int tcp set global chimney=disabled
netsh int tcp set global ecncapability=disabled
netsh int tcp set global rsc=disabled
netsh int tcp set global nonsackrttresiliency=disabled
netsh int tcp set security mpp=disabled
netsh int tcp set security profiles=disabled
netsh int ip set global icmpredirects=disabled
netsh int tcp set security mpp=disabled profiles=disabled
netsh int ip set global multicastforwarding=disabled
netsh int tcp set supplemental internet congestionprovider=ctcp
netsh interface teredo set state disabled
netsh winsock reset
netsh int isatap set state disable
netsh int ip set global taskoffload=disabled
netsh int ip set global neighborcachelimit=4096
netsh int tcp set global dca=enabled
netsh int tcp set global netdma=enabled
PowerShell Disable-NetAdapterLso -Name "*"
powershell "ForEach($adapter In Get-NetAdapter){Disable-NetAdapterPowerManagement -Name $adapter.Name -ErrorAction SilentlyContinue}"
powershell "ForEach($adapter In Get-NetAdapter){Disable-NetAdapterLso -Name $adapter.Name -ErrorAction SilentlyContinue}"

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableICMPRedirect" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxDupAcks" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d "32" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "GlobalMaxTcpWindowSize" /t REG_DWORD /d "8760" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpWindowSize" /t REG_DWORD /d "8760" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxConnectionsPerServer" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" /t REG_DWORD /d "65534" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SackOpts" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d "64" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_SZ /d "ffffffff" /f
echo.
goto :finished

:2
ipconfig /flushdns
goto :finished
:3

setlocal enabledelayedexpansion

set "adapterName=Ethernet"
set "googleDNS1=8.8.8.8"
set "googleDNS2=8.8.4.4"
set "cloudflareDNS1=1.1.1.1"
set "cloudflareDNS2=1.0.0.1"

:: Set Google DNS
netsh interface ipv4 set dns "%adapterName%" static %googleDNS1% primary
netsh interface ipv4 add dns "%adapterName%" %googleDNS2% index=2

:: Flush DNS cache
ipconfig /flushdns

echo Google DNS set.

:: Wait for a few seconds
timeout /t 5 /nobreak >nul

:: Set Cloudflare DNS
netsh interface ipv4 set dns "%adapterName%" static %cloudflareDNS1% primary
netsh interface ipv4 add dns "%adapterName%" %cloudflareDNS2% index=2

goto :finished

:finished
cls
echo Finished
pause
goto :menu

:4
cls
echo [36mGOOD APPS FOR LESS PING
echo ------------------------
echo  [36m[[35m1[0m[36m] [35mGhast.io (Free)
echo  [36m[[35m2[0m[36m] [35mExitLag (Not free)
echo  [36m[[35m3[0m[36m] [35mMenu
set /p input=:
if /i %input% == 1 start https://ghast.io & goto :4
if /i %input% == 2 start https://exitlag.com & goto :4
if /i %input% == 3 goto :menu