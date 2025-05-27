package com.giljobe.common;

public class Constants {
    //인코딩, 콘텐츠 타입
    public static final String ENCODING = "UTF-8";
    public static final String CONTENT_TYPE_HTML = "text/html; charset=UTF-8";
    public static final String CONTENT_TYPE_JSON = "application/json; charset=UTF-8";

    //View 경로
    public static final String WEB_VIEWS = "/WEB-INF/views/";
    public static final String WEB_INDEX = "/WEB-INF/index.jsp";
    public static final String MSG = "/WEB-INF/views/common/msg.jsp";


    //파일 업로드 경로
    public static final String DEFAULT_UPLOAD_PATH = "/resources/upload/";

    //이미지 경로
    public static final String IMAGE_FILE_PATH = "/resources/images/";

    //메인화면 헤더 li css 규칙
    public static final String CSS_LI_ITEM = "nav-item fs-4 mx-4";

    //multipart
    public static final String FORM_DATA = "multipart/form-data";

    //octet stream
    public static final String OCTET_STREAM = "application/octet-stream";
}
