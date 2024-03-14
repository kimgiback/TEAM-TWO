package config;

import javax.servlet.Filter;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;
/*
 Spring 웹 애플리케이션의 구성

 웹 애플리케이션 실행:
 웹 애플리케이션이 시작되면 서블릿 컨테이너인 톰캣(Tomcat)에 의해 web.xml 파일이 실행됩니다.

 ContextLoaderListener 등록:
 web.xml 파일에 등록된 ContextLoaderListener가 생성됩니다.
 이 리스너는 웹 애플리케이션이 시작될 때 루트 컨텍스트를 로딩하고 초기화하는 역할을 합니다.

 루트 컨텍스트 설정:
 ContextLoaderListener는 Spring 프레임워크의 설정 파일들(RootContext.class)을 로드하여 Spring ApplicationContext를 구성합니다.
 이는 주로 전역적인 설정들을 포함하며, 데이터베이스 연결, 서비스 계층, 보안 설정 등과 같은 애플리케이션 전반에 걸친 설정을 정의합니다.

 DispatcherServlet 설정:
 클라이언트에서 웹 애플리케이션에 요청을 보내면, DispatcherServlet은 클라이언트의 요청을 처리하기 위해
 Spring의 웹 계층 관련 설정을 담은 서블릿 컨텍스트를 로드합니다.
 이는 웹 영역과 관련된 설정을 담고 있으며, 컨트롤러, 뷰 리졸버, 핸들러 매핑 등과 같은 웹 계층에 필요한 설정을 정의합니다.

 이러한 구성은 Spring의 Inversion of Control (IoC) 컨테이너인 ApplicationContext를 활용하여 빈의 생성, 관계 설정 등을 총괄하며
 이를 통해 애플리케이션의 제어 흐름을 관리합니다.
*/

import context.Context_1_mybatis;
import context.Context_2_dao;
import context.Context_3_fileupload;

public class WebInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

	@Override
	protected Class<?>[] getRootConfigClasses() {
		
		return new Class[] {Context_1_mybatis.class, Context_2_dao.class, Context_3_fileupload.class};
	}
	
	@Override
	protected Class<?>[] getServletConfigClasses() {
		
		return new Class[] {config.ServletContext.class}; // servlet-context.xml 역할
	}

	@Override
	protected String[] getServletMappings() {
		
		return new String[] {"/"};
	}
	
	@Override
	protected Filter[] getServletFilters() {
		
		CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
		characterEncodingFilter.setEncoding("utf-8");
		characterEncodingFilter.setForceEncoding(true);
		
		return new Filter[] {characterEncodingFilter};
	}
	
}
