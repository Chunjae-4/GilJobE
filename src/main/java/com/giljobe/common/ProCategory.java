package com.giljobe.common;

import java.lang.reflect.Array;

public enum ProCategory {

    //https://www.career.go.kr/cloud/w/job/list 직업 분류별 검색 기준
    //business office finance insurance
    //bofi
    BUSINESS_OFFICE(new String[]{"경영", "사무", "금융", "보험직"}),
    SCIENCE_TECH(new String[]{"연구", "공학기술"}),
    PUBLIC(new String[]{"교육", "법률", "사회복지", "경찰", "소방", "군인"}),
    MEDICAL(new String[]{"보건", "의료"}),
    ART_MEDIA_SPORTS(new String[]{"예술", "디자인", "방송", "스포츠"}),
    SERVICE(new String[]{"미용", "여행", "숙박", "음식", "경비", "청소"}),
    SALES_DRIVE(new String[]{"영업", "판매", "운전", "운송"}),
    BUILD_MINING(new String[]{"건설", "채굴"}),
    MACHINERY(new String[]{"설치", "정비", "생산"}),
    FARMING(new String[]{"농립", "어업"})
    ;
    private String[] subcategories = new String[]{};

    ProCategory(String[] subcategories) {
        this.subcategories = subcategories;
    }

    public String[] getSubcategories() {
        return subcategories;
    }
}
