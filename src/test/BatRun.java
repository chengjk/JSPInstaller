package test;

import java.io.IOException;

public class BatRun {
	
	public  static void main(String[] args){
		//String test="cmd /c start cmd.exe";
		//String oracle="cmd /c start sqlplus sys/orcl as sysdba @e:/2.sql";
		String mysql="cmd /c mysql -u root < e:/3.sql";
		Runtime run=Runtime.getRuntime();
		try {
			run.exec(mysql);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
