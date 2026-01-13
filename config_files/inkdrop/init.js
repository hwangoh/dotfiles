function setUpRelativeLines(editor) {
  const { cm } = editor

  function showRelativeLines(cm) {
    const lineNum = cm.getCursor().line + 1;
    if (cm.state.curLineNum === lineNum) {
      return;
    }
    cm.state.curLineNum = lineNum;
    cm.setOption('lineNumberFormatter', l =>
      l === lineNum ? lineNum : Math.abs(lineNum - l));
  }
  cm.on('cursorActivity', showRelativeLines)
}

const editor = inkdrop.getActiveEditor()
if (editor) {
  setUpRelativeLines(editor)
} else {
  inkdrop.onEditorLoad(setUpRelativeLines)
}