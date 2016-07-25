set LINKFLAGS=%LINKFLAGS% /SUBSYSTEM:WINDOWS /ENTRY:mainCRTStartup
set LINKFLAGS=%LINKFLAGS% -subsystemwindows


mbuild -setup
mcc -m MODIPRO manage_register register Choice TableContents Main StatisticTool Diagnostic DiagnosticANN DiagnosticGMM TableContentsSimu MainSimu
cd(prefdir)
edit compopts.bat
mcc -m MODIPRO manage_register register Choice TableContents Main StatisticTool Diagnostic DiagnosticANN DiagnosticGMM TableContentsSimu MainSimu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mcc -e MODIPRO manage_register register Choice TableContents Main StatisticTool Diagnostic DiagnosticANN DiagnosticGMM