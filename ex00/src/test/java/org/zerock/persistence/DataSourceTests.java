package org.zerock.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

//spring-test를 이용해서 테스트
@RunWith(SpringJUnit4ClassRunner.class)
// 테스트할 때 정보 - 생성하고 조립 후 설정된 내용 확인 후 실행
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class DataSourceTests {
	
	// 필요한 객체를 선언 
	// - HikariCP 사용
	@Setter(onMethod_ = {@Autowired})
	private DataSource dataSource;
	
	// - Mybatis-spring 사용 : HikariCP 포함.
	@Setter(onMethod_ = {@Autowired})
	private SqlSessionFactory sqlSessionFactory;
	
	// 테스트할 메소드 생성 - MyBatis
	@Test
	public void testMyBatis() {
		try(SqlSession session = sqlSessionFactory.openSession();
			Connection con = session.getConnection()){
			log.info("MyBatis Test -------------------------------");
			log.info(session);
			log.info(con);
		} catch (Exception e) {
			// TODO: handle exception
//			e.printStackTrace();
			fail(e.getMessage());
		}
	}

	// 테스트할 메소드 생성 - HikariCP
	@Test
	public void testConnection() {
		try(Connection con = dataSource.getConnection()) {
			log.info("HikariCP Test -------------------------------");
			log.info(con);
		} catch (Exception e) {
			// TODO: handle exception
//			e.printStackTrace();
			fail(e.getMessage());
		}
	}
}
