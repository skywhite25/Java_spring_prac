package org.zerock.persistence;


import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {
	
	// static 블록 - static 변수 초기화 할 때 또는 딱 한 번만 실행이 되도록 할 때
	static {
		try {
			// 1.드라이버 확인 2.static으로 정의되어있는 요소들을 메모리로 올림
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	} // static블록의 끝
	
	// 오라클 DB와 연결이 되는지 확인 - Connection만 확인
	@Test
	public void testConnection() {
		// try(try안에서만 사용할 객체 선언 - try 밖으로 나가면 자동 close()){ 처리문 }
		try(Connection con = DriverManager.getConnection(
				"jdbc:oracle:thin:@localhost:1521:xe", "java00", "java00")){
			log.info(con);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
