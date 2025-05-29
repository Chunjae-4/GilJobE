document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll("button[data-prono]").forEach(button => {
        button.addEventListener("click", function (e) {
            e.stopPropagation();
			console.log(e.target);
            const btn = this;

            // ✅ 중복 요청 방지
           /* if (btn.disabled) return;
            btn.disabled = true;*/

            const proNo = btn.dataset.prono;

            fetch(contextPath + "/ajax/love/toggle", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "proNo=" + encodeURIComponent(proNo)
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    btn.classList.remove("btn-danger", "btn-outline-secondary");
                    btn.classList.add(data.liked ? "btn-danger" : "btn-outline-secondary");

                    const countSpan = btn.querySelector(".like-count");
                    if (countSpan) {
                        countSpan.textContent = data.likeCount;
                    } else {
                        btn.innerHTML = `♥ <span class="like-count">${data.likeCount}</span>`;
                    }
                } else {
                    alert(data.message || "로그인이 필요합니다.");
                }
            })
            .finally(() => {
                // ✅ 요청 완료 후 다시 활성화 (짧게 기다릴 수도 있음)
                setTimeout(() => {
                    //btn.disabled = false;
                }, 500); // 0.5초 정도 여유
            });
        });
    });
});
