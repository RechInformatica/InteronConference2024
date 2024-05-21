ISCFG.bat Para configurar o java no prompt

Compilar o fonte (isCobol + Java)
	icp EX9999

Compilar Java direto:
	javac.exe -Xdiags:verbose -Xlint:unchecked EX9999.java
	javac.exe -Xdiags:verbose -Xlint:unchecked EX9999CLEAN.java

Executar Java direto:
	java  -Dswing.defaultlaf=com.sun.java.swing.plaf.windows.WindowsLookAndFeel   EX9999
	java  -Dswing.defaultlaf=com.sun.java.swing.plaf.windows.WindowsLookAndFeel   EX9999CLEAN

winmerge EX9999.java EX9999CLEAN.java