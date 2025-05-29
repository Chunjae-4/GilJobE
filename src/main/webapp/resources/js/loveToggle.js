let debounceMap = {};

document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll("button[data-prono]").forEach(button => {
        button.addEventListener("click", function (e) {
            e.stopPropagation();
            const btn = this;
            const proNo = btn.dataset.prono;

            // ✅ debounce 중이면 무시
            if (debounceMap[proNo]) return;

            // ✅ debounce 플래그 설정
            debounceMap[proNo] = true;

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
                    alert(data.message);
                }
            })
            .finally(() => {
                // ✅ debounce 해제 (0.8초 뒤에 다시 클릭 가능)
                setTimeout(() => {
                    debounceMap[proNo] = false;
                }, 800);
            });
        });
    });
});
