</div> <!--wrap 종료-->

<!-- Toast UI Editor core script -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script src="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.min.js"></script>

<script>
    // ✍️ 글 작성용 Editor 초기화
    const editorElement = document.querySelector('#editor');
    if (editorElement) {
        const editor = new toastui.Editor({
            el: editorElement,
            height: '500px',
            initialEditType: 'wysiwyg',
            previewStyle: 'vertical'
        });

        const form = document.querySelector('form');
        const contentField = document.querySelector('#content');

        if (form && contentField) {
            form.addEventListener('submit', function () {
                contentField.value = editor.getHTML(); // 또는 getMarkdown()
            });
        }
    }

    // 👀 글 보기용 Viewer 초기화
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
