<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.giljobe.program.model.dto.*,
                 com.giljobe.qna.model.dto.*, 
                 com.giljobe.user.model.dto.*,
                 com.giljobe.company.model.dto.*,
                 java.util.List" %>
<%
    User loginUser = (User) session.getAttribute("user");
    Company loginCompany = (Company) session.getAttribute("company");
    Program program = (Program) request.getAttribute("program");
    List<QNA> qnaList = (List<QNA>) request.getAttribute("qnaList");
    String qnaMessage = (String) session.getAttribute("qnaMessage");
    if (qnaMessage != null) session.removeAttribute("qnaMessage");
%>
<%! 
    public String escape(String s) {
        return s == null ? "" : s.replaceAll("&", "&amp;")
                                 .replaceAll("<", "&lt;")
                                 .replaceAll(">", "&gt;")
                                 .replaceAll("\"", "&quot;");
    }
%>

<div class="card mb-5 border-0 rounded-4 shadow-sm">
    <div class="card-header bg-white fw-bold">Q&A</div>
    <div class="card-body program-qna">

        <%-- 메시지 출력 --%>
        <% if (qnaMessage != null) { %>
        <div class="alert alert-info"><%= qnaMessage %></div>
        <% } %>

        <%-- 로그인한 사용자만 문의 작성 가능 --%>
        <% if (loginUser != null) { %>
        <form action="<%=request.getContextPath()%>/qna/insert" method="post" class="mb-4"
              onsubmit="return validateQnaForm(this.qnaContent)">
            <input type="hidden" name="proNo" value="<%=program.getProNo()%>">
            <textarea name="qnaContent" class="form-control mb-2 rounded-3"
                      maxlength="500" oninput="updateCharCount(this, 'qnaContentCount')"
                      placeholder="프로그램에 대해 궁금한 점을 남겨주세요!" required></textarea>
            <div class="text-end text-muted small mb-2">
                <span id="qnaContentCount">0</span>/500자
            </div>
            <button type="submit" class="btn btn-primary btn-sm px-4 rounded-pill">등록</button>
        </form>
        <% } %>

        <%-- Q&A 목록 --%>
        <% if (qnaList == null || qnaList.isEmpty()) { %>
        <div class="text-muted text-center">아직 등록된 Q&A가 없습니다.</div>
        <% } else { %>
        <div class="accordion" id="qnaAccordion">
            <% for (QNA q : qnaList) {
                boolean isWriter = (loginUser != null && loginUser.getUserNo() == q.getUserNoRef());
                boolean isOwner = (loginCompany != null && program.getComNoRef() == loginCompany.getComNo());
            %>
            <div class="accordion-item">
                <h2 class="accordion-header" id="qna-heading-<%=q.getQnaNo()%>">
                    <button class="accordion-button collapsed py-3" type="button" data-bs-toggle="collapse"
                            data-bs-target="#qna-body-<%=q.getQnaNo()%>" aria-expanded="false"
                            aria-controls="qna-body-<%=q.getQnaNo()%>">
                        <span class="fw-semibold">문의</span>: <%= escape(q.getQnaContent()) %>
                        <% if (q.getAnswer() != null) { %>
                        <span class="ms-2 badge bg-success">답변 완료</span>
                        <% } else { %>
                        <span class="ms-2 badge bg-secondary">미답변</span>
                        <% } %>
                    </button>
                </h2>
                <div id="qna-body-<%=q.getQnaNo()%>" class="accordion-collapse collapse"
                     aria-labelledby="qna-heading-<%=q.getQnaNo()%>" data-bs-parent="#qnaAccordion">
                    <div class="accordion-body bg-light-subtle rounded-bottom">

                        <%-- 답변 영역 --%>
                        <% if (q.getAnswer() != null) { %>
                        <div class="mb-3"><strong>답변:</strong> <%= escape(q.getAnswer()) %></div>

                        <% if (isOwner) { %>
                        <form action="<%=request.getContextPath()%>/qna/updateAnswer" method="post"
                              onsubmit="return validateQnaForm(this.answer)">
                            <input type="hidden" name="qnaNo" value="<%=q.getQnaNo()%>">
                            <input type="hidden" name="proNo" value="<%=program.getProNo()%>">
                            <textarea name="answer" class="form-control mb-1" maxlength="500"
                                      oninput="updateCharCount(this, 'answerCount-<%=q.getQnaNo()%>')"><%= escape(q.getAnswer()) %></textarea>
                            <div class="text-end text-muted small mb-2">
                                <span id="answerCount-<%=q.getQnaNo()%>"><%= q.getAnswer().length() %></span>/500자
                            </div>
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-sm btn-warning">수정</button>
                                <a href="<%=request.getContextPath()%>/qna/deleteAnswer?qnaNo=<%=q.getQnaNo()%>&proNo=<%=program.getProNo()%>"
                                   class="btn btn-sm btn-outline-danger">삭제</a>
                            </div>
                        </form>
                        <% } %>

                        <% } else if (isOwner) { %>
                        <%-- 답변 작성 폼 --%>
                        <form action="<%=request.getContextPath()%>/qna/answer" method="post"
                              onsubmit="return validateQnaForm(this.answer)">
                            <input type="hidden" name="qnaNo" value="<%=q.getQnaNo()%>">
                            <input type="hidden" name="proNo" value="<%=program.getProNo()%>">
                            <textarea name="answer" class="form-control mb-2" maxlength="500"
                                      oninput="updateCharCount(this, 'answerCount-<%=q.getQnaNo()%>')"
                                      placeholder="답변 작성" required></textarea>
                            <div class="text-end text-muted small mb-2">
                                <span id="answerCount-<%=q.getQnaNo()%>">0</span>/500자
                            </div>
                            <button type="submit" class="btn btn-sm btn-success px-4">등록</button>
                        </form>
                        <% } else { %>
                        <div class="text-muted">아직 답변이 등록되지 않았습니다.</div>
                        <% } %>

                        <%-- 질문 작성자 삭제 버튼 --%>
                        <% if (isWriter) { %>
                        <form action="<%=request.getContextPath()%>/qna/delete" method="post" class="mt-3">
                            <input type="hidden" name="qnaNo" value="<%=q.getQnaNo()%>">
                            <input type="hidden" name="proNo" value="<%=program.getProNo()%>">
                            <button type="submit" class="btn btn-sm btn-outline-danger">문의 삭제</button>
                        </form>
                        <% } %>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
        <% } %>
    </div>
</div>


<script>
function validateQnaForm(textarea) {
    const value = textarea.value.trim();
    if (!value) {
        alert("내용을 입력해주세요.");
        textarea.focus();
        return false;
    }
    return true;
}

function updateCharCount(textarea, targetId) {
    const count = textarea.value.length;
    document.getElementById(targetId).innerText = count;
}
</script>
