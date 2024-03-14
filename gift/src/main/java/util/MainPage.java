package util;

public class MainPage {
    /*
        nowPage: 현재 페이지
        rowTotal: 전체 데이터 개수
        blockList: 한 페이지당 게시글 수
        blockPage: 한 화면에 나타낼 페이지 메뉴 수
     */
    public static String getPaging(String pageURL, int nowPage, int rowTotal, int blockList, int blockPage, int cate_no, String sort) {

        int totalPage; // 전체 페이지 수
        int startPage; // 현재 블록의 시작 페이지 번호
        int endPage; // 현재 블록의 마지막 페이지 번호

        boolean isPrevPage, isNextPage;
        StringBuffer sb; // 모든 상황을 판단하여 html 코드를 저장할 곳

        isPrevPage = isNextPage = false;

        // 전체 페이지 수 
        totalPage = (int)(rowTotal / blockList); // 필요한 페이지 수 = 전체 데이터 개수/ 한 페이지에서 보려는 게시글 수

        // 게시글 수가 10의 배수로 떨어지지 않고 나머지가 생겼을 때 한 페이지 추가
        if (rowTotal % blockList != 0) { 
            totalPage++;
        }

        // 만약 잘못된 연산과 움직임으로 인하여 현재 페이지 수가 전체 페이지 수를 넘을 경우
        // 강제로 현재 페이지 값을 전체 페이지 값으로 변경한다.
        if (nowPage > totalPage) {
            nowPage = totalPage;
        }

        // 현재 블록의 시작페이지 구하기
        startPage = (int)(((nowPage -1) / blockPage) * blockPage + 1);

        // 현재 블록의 마지막 페이지 구하기
        endPage = startPage + blockPage -1;

        // 현재 블록의 마지막 페이지가 전체 페이지 수보다 크면 마지막 페이지 값 변경
        if (endPage > totalPage) {
            endPage = totalPage;
        }

        // 마지막 페이지가 전체 페이지보다 작을 경우 다음 페이징이 적용될 수 있도록 값 설정
        if (endPage < totalPage) {
            isNextPage = true;
        }

        // 시작페이지의 값이 1보다 크면 이전 페이지로 이동할 수 있도록 값 설정
        if (startPage > 1) {
            isPrevPage = true;
        }

        // HTMl 코드를 저장할 StringBuffer 생성
        sb = new StringBuffer();

        // 이전 페이지 링크 생성
        if (isPrevPage) { 
        	sb.append("<a href=\"javascript:;\" class=\"prev arrow\" onclick='sort(\"").append(sort).append("\", ").append(startPage - 1).append(")'><span></span></a>");
        	} else {
        	sb.append("<a href=\"javascript:;\" class=\"prev arrow\"><span></span></a>");
        	}

        // 페이지 목록 출력
        for (int i = startPage; i <= endPage; i++) {
        	if (i == nowPage) { // 현재 선택된 페이지
        		sb.append("<a href=\"javascript:;\" style=\"font-weight: bold; text-decoration: underline;\"><span>").append(i).append("</span></a>");
        	} else { // 현재 페이지가 아닐 때
        		sb.append("<a href=\"javascript:;\" onclick='sort(\"").append(sort).append("\", ").append(i).append(")'><span>").append(i).append("</span></a>");
        	}
        }

        // 다음 페이지 링크 생성
        if (isNextPage) {
        	sb.append("<a href=\"javascript:;\" class=\"next arrow\" onclick='sort(\"").append(sort).append("\", ").append(endPage + 1).append(")'><span></span></a>");
        	} else {
        	sb.append("<a href=\"javascript:;\" class=\"next arrow\"><span></span></a>");
        }

        return sb.toString();
    }
}