</div> <!--wrap 종료-->

<!-- Toast UI Editor core script -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script src="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.min.js"></script>

<script>
    // 글 작성용 Editor 초기화
    const editorElement = document.querySelector('#editor');
    if (editorElement) {
        const editor = new toastui.Editor({
            el: editorElement,
            height: '500px',
            initialEditType: 'wysiwyg',
            previewStyle: 'vertical',
            hooks: {
                addImageBlobHook: async (blob, callback) => {
                    const formData = new FormData();
                    formData.append('imgPrev', blob);  // 컨트롤러에서 기대하는 파라미터명과 일치해야 함

                    try {
                        const response = await fetch('/imgup', {
                            method: 'POST',
                            body: formData
                        });

                        const result = await response.json();

                        // 서버에서 반환한 이미지 URL 사용
                        if (result.url) {
                            callback(result.url, result.filename || 'image');
                        } else {
                            alert('이미지 업로드 실패');
                        }
                    } catch (err) {
                        console.error('이미지 업로드 중 오류 발생:', err);
                        alert('이미지 업로드 중 오류가 발생했습니다.');
                    }
                }
            }
        });

        const form = document.querySelector('form');
        const contentField = document.querySelector('#content');

        if (form && contentField) {
            form.addEventListener('submit', function () {
                contentField.value = editor.getHTML(); // 또는 getMarkdown()
            });
        }
    }

    // 글 보기용 Viewer 초기화
    const viewerElement = document.querySelector('#viewer');
    if (viewerElement) {
        const html = viewerElement.innerHTML.trim();

        // 기존 내용을 날리고 Viewer 내부에 렌더링
        const viewer = new toastui.Editor.factory({
            el: viewerElement,
            viewer: true,
            initialValue: html
        });
    }
</script>
</body>
</html>
