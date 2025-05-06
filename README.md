# 📌 길JOB이

청소년 직업 체험 프로그램을 보다 쉽고 흥미롭게 탐색하고 신청할 수 있도록 돕는 홍보 및 안내 웹서비스입니다.

## 📋 프로젝트 개요

* **주제:** 청소년 직업 체험 프로그램 홍보 서비스를 위한 웹 개발
* **기간:** 2025.05 (미정)
* **목표:** 청소년을 위한 직업 체험 정보 탐색 및 신청 기능을 제공하는 웹 서비스 개발

## 👥 팀원 소개

| 이름  | 역할 | 담당 업무 |
| --- | -- | ----- |
| 김경주 | ㅡ  | ㅡ     |
| 양지혁 | ㅡ  | ㅡ     |
| 윤우식 | ㅡ  | ㅡ     |
| 임희석 | ㅡ  | ㅡ     |

## 🛠 협업 도구
  - Figma
      - https://www.figma.com/design/wGanJcDmIcmOjODOXm09ZH/%EA%B8%B8%EC%9E%A1%EC%9D%B4?node-id=0-1&p=f&t=R4HVKoTG4AKjSEWF-0
  - Google Drive
      - https://drive.google.com/drive/folders/1oq0g0-rOoA2PDKTugTrrmd7wm7cyil0J?usp=drive_link

## 📁 임시 프로젝트 디렉토리 구조

```
team-project-root/
├── frontend/                  # JS (VSCode)
│   ├── index.html             # 메인화면
│   ├── css/
│   │   └── style.css
│   ├── js/
│   │   ├── main.js            # 메인 로직
│   │   ├── navbar.js
│   │   ├── login.js
│   │   ├── signup.js
│   │   ├── experiences.js     # 진로체험 리스트 + 상세 + 채팅
│   │   ├── apply.js
│   │   ├── notice.js
│   │   ├── mypage.js
│   │   └── utils.js
│   ├── pages/                 # 페이지 단위 HTML
│   │   ├── login.html
│   │   ├── signup.html
│   │   ├── experiences.html
│   │   ├── detail.html
│   │   ├── apply.html
│   │   ├── notice.html
│   │   ├── mypage.html
│   │   └── 404.html
│   └── assets/                # 이미지, 폰트 등
│
├── backend/                   # Java + Oracle
│   ├── src/
│   │   ├── controller/        # Servlet
│   │   ├── service/           
│   │   ├── dao/               # DB 접근 (JDBC 또는 MyBatis)
│   │   ├── model/             # VO/DTO
│   │   └── util/              # 공통 유틸
│   ├── webapp/
│   │   └── WEB-INF/
│   │       └── web.xml
│   └── oracle.sql             # 초기 스키마 또는 샘플 데이터
│
├── README.md
└── .gitignore
```
