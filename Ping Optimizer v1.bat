@echo off
color 3
rem Batch file by MrOrdenador
title By MrOrdenador on Youtube

echo Do you want to do a Restore Point?
echo [1] Yes [2] No
set /p input=:
if /i %input% == 1 goto rstr
if /i %input% == 2 goto menu
:rstr
set restorePointName=MrOrdenador Tool Restore Point
powershell.exe -Command "Checkpoint-Computer -Description '%restorePointName%'"
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
echo  [36m[[35m1[0m[36m] [35mNetwork Optimization
echo  [36m[[35m2[0m[36m] [35mClean DNS
echo  [36m[[35m3[0m[36m] [35mOptimized DNS
echo  [36m[[35m4[0m[36m] [35mOpen advanced network config
echo  [36m[[35mR[0m[36m] [35mUse the restorepoint
echo  [36m[[35mL[0m[36m] [35mMrOrdenador's links
set /p input=[35m:
if /i %input% == 1 goto 1
if /i %input% == 2 goto 2
if /i %input% == 3 goto 3
if /i %input% == 4 ncpa.cpl
if /i %input% == r rstrui.exe
if /i %input% == L start https://linktr.ee/mrordenador
goto :menu

:1
echo - Setting autotuning level to normal...
netsh int tcp set global autotuninglevel=normal
echo - Disabling 6to4 interface...
netsh interface 6to4 set state disabled
echo - Disabling ISATAP interface...
netsh int isatap set state disable
echo - Disabling TCP timestamps...
netsh int tcp set global timestamps=disabled
echo - Disabling TCP heuristics...
netsh int tcp set heuristics disabled
echo - Disabling TCP chimney...
netsh int tcp set global chimney=disabled
echo - Disabling ECN capability...
netsh int tcp set global ecncapability=disabled
echo - Disabling Receive Side Scaling (RSS)...
netsh int tcp set global rsc=disabled
echo - Disabling non-SACK RTT resiliency...
netsh int tcp set global nonsackrttresiliency=disabled
echo - Disabling TCP security MPP...
netsh int tcp set security mpp=disabled
echo - Disabling TCP security profiles...
netsh int tcp set security profiles=disabled
echo - Disabling ICMP redirects...
netsh int ip set global icmpredirects=disabled
echo - Disabling TCP security MPP and profiles...
netsh int tcp set security mpp=disabled profiles=disabled
echo - Disabling multicast forwarding...
netsh int ip set global multicastforwarding=disabled
echo - Setting supplemental internet congestion provider to CTCP...
netsh int tcp set supplemental internet congestionprovider=ctcp
echo - Disabling Teredo interface...
netsh interface teredo set state disabled
echo - Resetting Winsock catalog...
netsh winsock reset
echo - Disabling ISATAP interface (again)...
netsh int isatap set state disable
echo - Disabling TCP task offload...
netsh int ip set global taskoffload=disabled
echo - Setting neighbor cache limit to 4096...
netsh int ip set global neighborcachelimit=4096
echo - Enabling Direct Cache Access (DCA)...
netsh int tcp set global dca=enabled
echo - Enabling Network Direct Memory Access (NetDMA)...
netsh int tcp set global netdma=enabled
echo - Disabling Large Send Offload (LSO) for all network adapters...
PowerShell Disable-NetAdapterLso -Name "*"
echo - Disabling network adapter power management...
powershell "ForEach($adapter In Get-NetAdapter){Disable-NetAdapterPowerManagement -Name $adapter.Name -ErrorAction SilentlyContinue}"
echo - Disabling Large Send Offload (LSO) for all network adapters (again)...
powershell "ForEach($adapter In Get-NetAdapter){Disable-NetAdapterLso -Name $adapter.Name -ErrorAction SilentlyContinue}"

echo - Enabling ICMP Redirect...
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableICMPRedirect" /t REG_DWORD /d "1" /f
echo - Enabling PMTU Discovery...
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery" /t REG_DWORD /d "1" /f
echo - Disabling TCP 1323 options...
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d "0" /f
echo - Setting TCP MaxDupAcks to 2...
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxDupAcks" /t REG_DWORD /d "2" /f
echo - Setting TCP Timed Wait Delay to 32...
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d "32" /f
echo - Setting GlobalMaxTcpWindowSize to 8760...
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "GlobalMaxTcpWindowSize" /t REG_DWORD /d "8760" /f
echo - Setting TCP Window Size to 8760...
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpWindowSize" /t REG_DWORD /d "8760" /f
echo - Setting Max Connections Per Server to unlimited...
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxConnectionsPerServer" /t REG_DWORD /d "0" /f
echo - Setting Max User Port to 65534...
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" /t REG_DWORD /d "65534" /f
echo - Disabling Selective Acknowledgment (SACK)...
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SackOpts" /t REG_DWORD /d "0" /f
echo - Setting Default TTL to 64...
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d "64" /f
echo - Setting Network Throttling Index to maximum...
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_SZ /d "ffffffff" /f

goto :finished

:2
ipconfig /flushdns
goto :finished
:3
setlocal enabledelayedexpansion
echo - Changing DNS to Google DNS...
netsh interface ipv4 set dns name="Ethernet" static 8.8.8.8 primary
netsh interface ipv4 add dns name="Ethernet" 8.8.4.4 index=2
goto :finished

:finished
cls
echo Finished
pause
goto :menu

