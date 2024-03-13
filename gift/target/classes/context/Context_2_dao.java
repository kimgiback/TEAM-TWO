package context;

import org.apache.ibatis.session.SqlSession;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import dao.BuBoardDAO;
import dao.BuMemberDAO;
import dao.ItemDAO;
import dao.MainDAO;
import dao.MemberDAO;
import dao.PayingDAO;
import dao.UserQnaDAO;
import dao.WishCartDAO;
import dao.buItemDAO;
import service.BuBoardService;
import service.BuMemberService;


@Configuration 
public class Context_2_dao {

		@Bean
		public PayingDAO payingDAO(SqlSession sqlSession) {
			return new PayingDAO(sqlSession);
		}

		//dao
		@Bean
		public BuMemberDAO buMemberDAO(SqlSession sql) {
			return new BuMemberDAO(sql);
		}
		
		
		//service
		@Bean
		public BuMemberService buMemberService(BuMemberDAO dao) {
			return new BuMemberService(dao);
		}
		
		@Bean
		public BuBoardService buBoardService(BuBoardDAO dao) {
			return new BuBoardService(dao);
		}
		
		@Bean
		public BuBoardDAO buBoardDAO(SqlSession sqlSession) {
			return new BuBoardDAO(sqlSession);
		}
		
		@Bean
		public MainDAO mainDAO(SqlSession sqlSession) {
			return new MainDAO(sqlSession);
		}
		
		@Bean
		public ItemDAO itemDAO(SqlSession sqlSession) {
			return new ItemDAO(sqlSession);
		}
		

		@Bean
		public MemberDAO memberDAO(SqlSession sqlSession) {
			return new MemberDAO(sqlSession);
		}
		
		@Bean
		public UserQnaDAO userQnaDAO(SqlSession sqlSession) {
			return new UserQnaDAO(sqlSession);
		}
		
		@Bean
		public WishCartDAO wishCartDAO(SqlSession sqlSession) {
			return new WishCartDAO(sqlSession);
		}
		
		@Bean
		public buItemDAO buItemDAO(SqlSession sqlSession) {
			return new buItemDAO(sqlSession);
		}
		

}
